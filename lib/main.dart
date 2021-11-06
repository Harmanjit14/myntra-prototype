import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:myntra/bitmoji/bitmoji.dart';
import 'package:myntra/constants/theme.dart';
import 'package:myntra/models/user.dart';
import 'package:myntra/screens/dashboard.dart';
import 'package:myntra/screens/login.dart';
import 'package:myntra/screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  Widget authChanges() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const AuthChecker();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Myntra',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
      // home: const GetBitmoji(false, 'DoLDEWUFGHn7TOirmyJN'),
      home: authChanges(),
    );
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> with AfterLayoutMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void afterFirstLayout(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get()
        .then((value) {
      user.name = value['name'];
      user.image = value['image'];
      user.jobType = value['job'];
      user.email = value['email'];
      user.score = value['score'];
      Get.offAll(() => const DashBoard());
    }).catchError((e) {
      print(e);
      Get.offAll(() => const ProfileScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(
              color: Colors.black,
            ),
            SizedBox(height: 15),
            Text("Loading Please Wait...")
          ],
        ),
      )),
    );
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myntra/constants/jobs.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/models/user.dart';
import 'package:myntra/screens/dashboard.dart';

class ProfileButton extends GetxController {
  RxBool loading = false.obs;
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // int selectedValue = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _obj = Get.put(ProfileButton());
  final _key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  profile() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "id": FirebaseAuth.instance.currentUser!.uid.toString(),
      "name": controller.text,
      "score": user.score,
      "image": user.image,
      "email": FirebaseAuth.instance.currentUser!.email.toString(),
      "job": user.jobType,
      "images":[],
    }).then((value) {
      Get.snackbar("Success", "Account created successfully ${user.name}",

          //  "Unable to login, Please try again later..",
          icon: const Icon(Icons.done));
      Get.offAll(() => const DashBoard());
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        height: size.height * 0.11,
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Obx(
                  () => MaterialButton(
                    color: Colors.orange[800],
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    onPressed: () async {
                      (_key.currentState!.validate())
                          ? profile()
                          : Timer(const Duration(seconds: 2), () {
                              _key.currentState!.reset();
                            });
                      // FirebaseAuth.instance.signOut();
                    },
                    child: (_obj.loading.value)
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("Save Changes",
                            style: boldtextsyle(size.height * 0.021,
                                shadow: true, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.orange[800],
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 50,
                    width: 60,
                    // color: Colors.red,
                    child: Image.asset(
                      "assets/logopng.png",
                      fit: BoxFit.fitHeight,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Create Profile',
                  style: boldtextsyle(20, color: Colors.white),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(user.image!),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: SizedBox(
              height: 60,
              width: double.maxFinite,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                      )
                    ]),
                child: Form(
                  key: _key,
                  child: TextField(
                    controller: controller,
                    style: normaltextsyle(15, color: Colors.black),
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.orange[800],
                    decoration: const InputDecoration(
                      hintText: "Enter your full name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                      )
                    ]),
                child: DropdownSearch<String>(
                  mode: Mode.DIALOG,
                  // dropDownButton: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down)),
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search...",
                      focusColor: Colors.orange[800],
                      border: InputBorder.none,
                    ),
                  ),
                  dropdownSearchDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Select your Occupation",
                    hintStyle: normaltextsyle(14, color: Colors.grey[700]),
                  ),
                  items: jobs,
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (item) {
                    user.jobType = item;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myntra/constants/jobs.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/models/user.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
int selectedValue = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
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
                child: TextField(
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
          )),
          SliverToBoxAdapter(
          child: SizedBox(
          child: SearchableDropdown.single(
        items: items,
        value: selectedValue,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        isExpanded: true,
      ),
          ),
          ),
        ],
      ),
    );
  }
}

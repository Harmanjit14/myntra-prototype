import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myntra/constants/text.dart';

class MyProfile extends StatelessWidget {
  const MyProfile(this.uid, {Key? key}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.pink[800],
              ),
              const SizedBox(height: 15),
              const Text("Loading.."),
            ],
          ));
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No Data..",
              style: mediumtextsyle(17),
            ),
          );
        }
        QueryDocumentSnapshot obj = snapshot.data!.docs.first;
        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Image.network(
                      obj.get("image"),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        obj.get("name"),
                        style:
                            boldtextsyle(20, shadow: true, color: Colors.black),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "(${obj.get("job")})",
                        style: mediumtextsyle(14, color: Colors.grey[700]),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    obj.get("verified") ? "Verified " : "Not-Verified ",
                    style: mediumtextsyle(15,
                        color: obj.get("verified")
                            ? Colors.green[800]
                            : Colors.red[800]),
                  ),
                  obj.get("verified")
                      ? Icon(
                          Icons.verified,
                          color: Colors.green[700],
                          size: 17,
                        )
                      : Icon(
                          Icons.error_outline,
                          color: Colors.red[700],
                          size: 17,
                        )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

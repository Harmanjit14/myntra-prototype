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
                        ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(blurRadius: 5, color: Colors.grey)
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Styles Created by User!",
                        style:
                            boldtextsyle(16, shadow: true, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 355,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("kits")
                            .where("createdby",
                                arrayContains:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          } else if (snapshot.hasData) {
                            return PageView.builder(
                              itemCount: (snapshot.data!.docs.length < 3)
                                  ? snapshot.data!.docs.length
                                  : 10,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                      top: 162,
                                                      left: 0,
                                                      right: 0,
                                                      child: SizedBox(
                                                          height: 120,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            children: [
                                                              Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/base_bottom.png"),
                                                                  Image.network(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "bitImages")[1]),
                                                                ],
                                                              ),
                                                            ],
                                                          ))),
                                                  Positioned(
                                                    top: 90,
                                                    left: 0,
                                                    right: 0,
                                                    child: SizedBox(
                                                      height: 200,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        children: [
                                                          Image.asset(
                                                              "assets/base_top.png"),
                                                          Positioned(
                                                            top: 10,
                                                            child: Image.network(
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .get(
                                                                        "bitImages")[0]),
                                                          ),
                                                          // Image.network(fixedData.docs.first.get("image").toString())
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      right: 0,
                                                      child: SizedBox(
                                                          height: 110,
                                                          child: Image.asset(
                                                              "assets/base_head.png"))),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Expanded(
                                                  child: Image.network(snapshot
                                                      .data!.docs[index]
                                                      .get("images")[0])),
                                              Expanded(
                                                  child: Image.network(snapshot
                                                      .data!.docs[index]
                                                      .get("images")[1]))
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            (snapshot.data!.docs[index]
                                                    .get("likedby")
                                                    .contains(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid
                                                        .toString()))
                                                ? IconButton(
                                                    onPressed: () async {
                                                      int likes = snapshot
                                                          .data!.docs[index]
                                                          .get('likes');
                                                      likes = likes - 1;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("kits")
                                                          .doc(snapshot.data!
                                                              .docs[index].id
                                                              .toString())
                                                          .update({
                                                        'likes': likes,
                                                      }).then((value) {
                                                        List users = snapshot
                                                            .data!.docs[index]
                                                            .get('likedby');
                                                        users.remove(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid);
                                                        print(users);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("kits")
                                                            .doc(snapshot.data!
                                                                .docs[index].id
                                                                .toString())
                                                            .update({
                                                          'likedby': users,
                                                        });
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.favorite,
                                                      color: Colors.pink,
                                                    ))
                                                : IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("kits")
                                                          .doc(snapshot.data!
                                                              .docs[index].id
                                                              .toString())
                                                          .update({
                                                        'likes': snapshot.data!
                                                                .docs[index]
                                                                .get('likes') +
                                                            1,
                                                      }).then((value) {
                                                        List users = snapshot
                                                            .data!.docs[index]
                                                            .get('likedby');
                                                        users.add(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid);
                                                        print(users);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("kits")
                                                            .doc(snapshot.data!
                                                                .docs[index].id
                                                                .toString())
                                                            .update({
                                                          'likedby': users,
                                                        });
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                            Text(
                                              "${snapshot.data!.docs[index].get("likes")}",
                                              style: mediumtextsyle(12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: Text("No Data found here..."));
                          }
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 500,
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius: 5, color: Colors.grey)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "User Pictures...",
                          style: boldtextsyle(16,
                              shadow: true, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1,
                          ),
                          itemCount: obj.get("images").length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              obj.get("images")[index],
                              fit: BoxFit.cover,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        );
      },
    );
  }
}

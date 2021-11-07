import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:after_layout/after_layout.dart';
import 'package:myntra/constants/text.dart';
import 'package:youtube_api/youtube_api.dart';

class ScrapedVideos extends GetxController {
  RxList videos = [].obs;
}

class StudioScreen extends StatefulWidget {
  const StudioScreen({Key? key}) : super(key: key);

  @override
  _StudioScreenState createState() => _StudioScreenState();
}

class _StudioScreenState extends State<StudioScreen> {
  static String key = 'AIzaSyCVrUaADZxskcnqngZe9QDrPIG5V-1Bdzk';
  YoutubeAPI ytApi = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];
  final obj = Get.put(ScrapedVideos());
  @override
  void initState() {
    String query = "fashion,myntra";

    String type = "video";

    YoutubeAPI ytApi = YoutubeAPI(key, maxResults: 5, type: type);

    ytApi.search(query).then((value) => {
          videoResult = value,
          obj.videos.value = value,
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("kits")
                    .orderBy("likes", descending: true)
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
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Trending Tops near you..",
                                    style: boldtextsyle(16,
                                        shadow: true, color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                "(Swipw to see more)",
                                style:
                                    normaltextsyle(11, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 300,
                                child: PageView.builder(
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
                                          child: Image.network(
                                            snapshot.data!.docs[index]
                                                .get("images")[0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Trending Lowers near you..",
                                    style: boldtextsyle(16,
                                        shadow: true, color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                "(Swipw to see more)",
                                style:
                                    normaltextsyle(11, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 300,
                                child: PageView.builder(
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
                                          child: Image.network(
                                            snapshot.data!.docs[index]
                                                .get("images")[1],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Trending Styles!",
                                    style: boldtextsyle(16,
                                        shadow: true, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 355,
                                child: PageView.builder(
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
                                                                alignment:
                                                                    Alignment
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
                                                            alignment: Alignment
                                                                .topCenter,
                                                            children: [
                                                              Image.asset(
                                                                  "assets/base_top.png"),
                                                              Positioned(
                                                                top: 10,
                                                                child: Image.network(
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
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
                                                      child: Image.network(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "images")[0])),
                                                  Expanded(
                                                      child: Image.network(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "images")[1]))
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
                                                              .collection(
                                                                  "kits")
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id
                                                                  .toString())
                                                              .update({
                                                            'likes': likes,
                                                          }).then((value) {
                                                            List users = snapshot
                                                                .data!
                                                                .docs[index]
                                                                .get('likedby');
                                                            users.remove(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid);
                                                            print(users);
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "kits")
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id
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
                                                              .collection(
                                                                  "kits")
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id
                                                                  .toString())
                                                              .update({
                                                            'likes': snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .get(
                                                                        'likes') +
                                                                1,
                                                          }).then((value) {
                                                            List users = snapshot
                                                                .data!
                                                                .docs[index]
                                                                .get('likedby');
                                                            users.add(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid);
                                                            print(users);
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "kits")
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text("No Data found here..."));
                  }
                }),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}

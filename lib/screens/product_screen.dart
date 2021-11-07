import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myntra/bitmoji/bitmoji.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/models/user.dart';
import 'package:myntra/screens/dashboard%20screens/my_profile.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ProductInfo extends GetxController {
  RxInt selectedSize = (-1).obs;
}

class ProductScreen extends StatelessWidget {
  ProductScreen(
    this.doc, {
    Key? key,
  }) : super(key: key);
  final DocumentSnapshot? doc;
  final productInfo = Get.put(ProductInfo());

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: doc!.get('video'),
      params: const YoutubePlayerParams(
        startAt: Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomSheet: SizedBox(
        height: 70,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      elevation: 5,
                      onPressed: () {
                        print(doc!.get("top"));
                        Get.to(() =>
                            GetBitmoji(doc!.get("top"), doc!.id.toString()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.tv,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Create Style",
                            style: boldtextsyle(14),
                          )
                        ],
                      ),
                      shape: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      elevation: 5,
                      onPressed: () {},
                      color: Colors.orange.shade800,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.creditCard,
                            color: Colors.grey[300],
                            size: 20,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Buy",
                            style: boldtextsyle(14, color: Colors.grey[300]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
            backgroundColor: Colors.white,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 50,
                    width: 50,
                    // color: Colors.red,
                    child: Image.asset(
                      "assets/logopng.png",
                      fit: BoxFit.fitHeight,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Myntra',
                  style: boldtextsyle(20, color: Colors.black),
                ),
              ],
            ),
            stretch: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 600,
              child: Stack(
                children: [
                  PageView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: size.width,
                          height: double.maxFinite,
                          child: Image.network(
                            "${doc!.get("image")}",
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(blurRadius: 4, color: Colors.grey)
                              ]),
                          height: 30,
                          width: 70,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${doc!.get('rating')}",
                                style: boldtextsyle(15, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.green,
                                size: 17,
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(15),
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
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "${doc!.get('title')}",
                        style: boldtextsyle(20),
                      ),
                      const SizedBox(
                        height: 0,
                        width: 5,
                      ),
                      Text(
                        "${doc!.get('subtitle')}",
                        style: mediumtextsyle(14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${doc!.get('price')}",
                    style: boldtextsyle(22,
                        shadow: false, color: Colors.pink[700]),
                  ),
                  Text(
                    "(inclusive all taxes)",
                    style: normaltextsyle(13, color: Colors.green[700]),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
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
                  Text(
                    "Available Sizes",
                    style: boldtextsyle(16),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doc!.get("size").length,
                        itemBuilder: (context, index) {
                          List<dynamic> proSize = doc!.get("size");
                          return Obx(
                            () => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: FloatingActionButton(
                                heroTag: "$index",
                                backgroundColor:
                                    (productInfo.selectedSize.value == index)
                                        ? Colors.orange[800]
                                        : Colors.white,
                                onPressed: () {
                                  productInfo.selectedSize.value = index;
                                },
                                child: Text(
                                  proSize[index].toString(),
                                  style: boldtextsyle(
                                    13,
                                    color: (productInfo.selectedSize.value ==
                                            index)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
                  Text(
                    "Product Details",
                    style: boldtextsyle(16),
                  ),
                  SizedBox(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: doc!.get("details").length,
                        itemBuilder: (context, index) {
                          return Text(
                            (index + 1).toString() +
                                "." +
                                " " +
                                doc!.get("details")[index].toString(),
                            style: boldtextsyle(
                              13,
                              color: Colors.grey[700],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Size and Fit",
                    style: boldtextsyle(16),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    doc!.get("fit").toString(),
                    style: boldtextsyle(
                      13,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Material",
                    style: boldtextsyle(16),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    doc!.get("material").toString(),
                    style: boldtextsyle(
                      13,
                      color: Colors.grey[700],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
                        "Infulencer Creations",
                        style: boldtextsyle(16,
                            shadow: true, color: Colors.pink[800]),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.verified,
                        color: Colors.pink[800],
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 417,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("kits")
                            .where('verified', isEqualTo: true)
                            .where('id', arrayContainsAny: [
                          doc!.get('id').toString()
                        ]).snapshots(),
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
                                print(snapshot.data!.docs[index].data());
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
                                    TextButton(
                                      style: const ButtonStyle(
                                        // padding: EdgeInsets.all(0),
                                        alignment: Alignment.center,
                                      ),
                                      onPressed: () {
                                        Get.to(() => AnyProfile(snapshot
                                            .data!.docs[index]
                                            .get("createdby")[2]));
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Created with love by ",
                                                style: mediumtextsyle(14,
                                                    color: Colors.grey[700]),
                                              ),
                                              Text(
                                                "${snapshot.data!.docs[index].get("createdby")[0]}",
                                                style: boldtextsyle(14,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          (snapshot.data!.docs[index]
                                                  .get('verified'))
                                              ? Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Verified User",
                                                      style: normaltextsyle(10,
                                                          color: Colors
                                                              .green[800]),
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .checkCircle,
                                                      color: Colors.green[800],
                                                      size: 10,
                                                    )
                                                  ],
                                                )
                                              : const SizedBox(
                                                  height: 0,
                                                  width: 0,
                                                ),
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
          ),
          SliverToBoxAdapter(
            child: Container(
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
                        "Created by Users like You!",
                        style: boldtextsyle(16,
                            shadow: true, color: Colors.orange[900]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 417,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("kits")
                            .where('verified', isEqualTo: false)
                            .where('id', arrayContainsAny: [
                          doc!.get('id').toString()
                        ]).snapshots(),
                        builder: (context, snapshot) {
                          print(snapshot.data!.docs);
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
                                    TextButton(
                                      style: const ButtonStyle(
                                        // padding: EdgeInsets.all(0),
                                        alignment: Alignment.center,
                                      ),
                                      onPressed: () {},
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Created with love by ",
                                                style: mediumtextsyle(14,
                                                    color: Colors.grey[700]),
                                              ),
                                              Text(
                                                "${snapshot.data!.docs[index].get("createdby")[0]}",
                                                style: boldtextsyle(14,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
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
          ),
          SliverToBoxAdapter(
            child: Container(
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
                  Text(
                    "Fresh Styles for you...",
                    style: boldtextsyle(16, shadow: false, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: YoutubePlayerIFrame(
                        controller: _controller,
                        aspectRatio: 4 / 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(blurRadius: 5, color: Colors.grey)
                  ]),
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Comments and Reviews",
                    style: boldtextsyle(16, shadow: false, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "From People you may Know..",
                    style: mediumtextsyle(14, color: Colors.orange[900]),
                  ),
                  Text(
                    "(Swipe to view more...)",
                    style: normaltextsyle(11, color: Colors.orange[900]),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .doc(doc!.get('id'))
                          .snapshots(),
                      builder: (context, snapshot) {
                        // print(snapshot.data!.data());
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          );
                        } else if (snapshot.hasError ||
                            snapshot.data.isBlank!) {
                          return Center(
                            child: Text(
                              "No Data...",
                              style: boldtextsyle(15, color: Colors.black),
                            ),
                          );
                        } else if (snapshot.data!.get("comments").length == 0) {
                          return Center(
                            child: Text(
                              "No Data...",
                              style: boldtextsyle(15, color: Colors.black),
                            ),
                          );
                        }
                        return PageView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                (snapshot.data!.get("comments").length < 10)
                                    ? snapshot.data!.get("comments").length
                                    : 10,
                            itemBuilder: (context, index) {
                              Map<dynamic, dynamic> map =
                                  snapshot.data!.get("comments")[index];
                              // print(map.values.elementAt(index));

                              return SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${map["name"]}",
                                              style: mediumtextsyle(14,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "(${map["job"]})",
                                              style: normaltextsyle(10,
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                        starbuilder(map["rating"]),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      "\"${map["comment"]}\"",
                                      style: boldtextsyle(15,
                                          color: Colors.grey[800]),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  TextButton.icon(
                      style: const ButtonStyle(
                          //  splashFactory: InkSplash,
                          ),
                      onPressed: () {
                        _showMyDialog(context, doc!);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.comments,
                        color: Colors.orange[900],
                      ),
                      label: Text(
                        "Add Comment",
                        style: boldtextsyle(16, color: Colors.orange[900]),
                      ))
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      ),
    );
  }
}

class RatingStars extends GetxController {
  RxInt stars = 0.obs;
}

Future<void> _showMyDialog(
    BuildContext context, DocumentSnapshot snapshot) async {
  final obj = Get.put(RatingStars());
  int star = 0;
  TextEditingController controller = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Comment'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rate it',
                    style: mediumtextsyle(13),
                  ),
                  Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            obj.stars.value = 1;
                          },
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: (obj.stars.value < 1)
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            obj.stars.value = 2;
                          },
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: (obj.stars.value < 2)
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            obj.stars.value = 3;
                          },
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: (obj.stars.value < 3)
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            obj.stars.value = 4;
                          },
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: (obj.stars.value < 4)
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            obj.stars.value = 5;
                          },
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: (obj.stars.value < 5)
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 3,
                controller: controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    hintText: "start typing your review here...",
                    border: InputBorder.none,
                    hintStyle: normaltextsyle(14, color: Colors.grey[700])),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: boldtextsyle(15),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange[800])),
            child: Text(
              'Submit',
              style: boldtextsyle(15, color: Colors.white),
            ),
            onPressed: () async {
              print(snapshot.get("comments"));
              List comments = snapshot.get("comments");
              Map data = {
                "comment": controller.text.toString(),
                "name": user.name,
                "job": user.jobType,
                "rating": obj.stars.value,
              };

              comments.add(data);
              // comments.addAll(finalData);
              print(comments);
              try {
                await FirebaseFirestore.instance
                    .collection("products")
                    .doc(snapshot.get("id"))
                    .update({"comments": comments}).then((value) {
                  Navigator.pop(context);
                });
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      );
    },
  );
}

Widget starbuilder(var value) {
  int count = value as int;
  return SizedBox(
    // color: Colors.amber,
    height: 15,
    width: 75,
    child: Flex(
      direction: Axis.horizontal,
      children: [
        SizedBox(
          width: count * 15,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: count,
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.green,
                  size: 15,
                );
              }),
        ),
        SizedBox(
          width: (5 - count) * 15,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5 - count,
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 15,
                );
              }),
        ),
      ],
    ),
  );
}

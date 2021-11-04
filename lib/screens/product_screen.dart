import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/screens/dashboard.dart';

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
                      onPressed: () {},
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
                            "View Studio",
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
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: size.width,
                          height: double.maxFinite,
                          child: Image.asset(
                            "assets/model.png",
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
                          } else if (snapshot.hasData) {
                            return PageView.builder(
                              itemCount: (snapshot.data!.docs.length < 3)
                                  ? snapshot.data!.docs.length
                                  : 3,
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
                                            child: Container(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            color: Colors.green,
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
                                                "${snapshot.data!.docs[index].get("createdBy")[0]}",
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
                                              :const  SizedBox(
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
                                                      // await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection("kits")
                                                      //     .doc(snapshot.data!
                                                      //         .docs[index].id
                                                      //         .toString())
                                                      //     .set({
                                                      //   'likes': snapshot.data!
                                                      //           .docs[index]
                                                      //           .get('likes') -
                                                      //       1,
                                                      // }).then((value) => {
                                                      //           FirebaseFirestore
                                                      //               .instance
                                                      //               .collection(
                                                      //                   "kits")
                                                      //               .doc(snapshot
                                                      //                   .data!
                                                      //                   .docs[
                                                      //                       index]
                                                      //                   .id
                                                      //                   .toString())
                                                      //               .set({
                                                      //             'id': snapshot
                                                      //                 .data!
                                                      //                 .docs[
                                                      //                     index]
                                                      //                 .get('id')
                                                      //                 .remove(FirebaseAuth
                                                      //                     .instance
                                                      //                     .currentUser!
                                                      //                     .uid
                                                      //                     .toString()),
                                                      //           }),
                                                      //         });
                                                    },
                                                    icon: const Icon(
                                                      Icons.favorite,
                                                      color: Colors.pink,
                                                    ))
                                                : IconButton(
                                                    onPressed: () async {
                                                      //  await FirebaseFirestore
                                                      //     .instance
                                                      //     .collection("kits")
                                                      //     .doc(snapshot.data!
                                                      //         .docs[index].id
                                                      //         .toString())
                                                      //     .set({
                                                      //   'likes': snapshot.data!
                                                      //           .docs[index]
                                                      //           .get('likes') +
                                                      //       1,
                                                      // }).then((value) => {
                                                      //           FirebaseFirestore
                                                      //               .instance
                                                      //               .collection(
                                                      //                   "kits")
                                                      //               .doc(snapshot
                                                      //                   .data!
                                                      //                   .docs[
                                                      //                       index]
                                                      //                   .id
                                                      //                   .toString())
                                                      //               .set({
                                                      //             'id': snapshot
                                                      //                 .data!
                                                      //                 .docs[
                                                      //                     index]
                                                      //                 .get('id')
                                                      //                 .add(FirebaseAuth
                                                      //                     .instance
                                                      //                     .currentUser!
                                                      //                     .uid
                                                      //                     .toString()),
                                                      //           }),
                                                      //         });
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
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                print("Comments");
                                              },
                                              icon: FaIcon(
                                                FontAwesomeIcons.comments,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data!.docs[index].get("comments").length}",
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
                  )
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

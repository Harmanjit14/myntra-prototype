import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/models/user.dart';
import 'package:myntra/screens/dashboard.dart';

class BitmojiButton extends GetxController {
  RxBool loading = false.obs;
  RxList selected = [].obs;
  RxInt index = 0.obs;
}

class GetBitmoji extends StatefulWidget {
  const GetBitmoji(this.top, this.id, {Key? key}) : super(key: key);
  final bool top;
  final String id;

  @override
  _GetBitmojiState createState() => _GetBitmojiState();
}

class _GetBitmojiState extends State<GetBitmoji> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.pink[800],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    print(widget.id);
    print("32KXvHi8WhBCw3ncRb1q");
    QuerySnapshot<Map<String, dynamic>> fixedData = await FirebaseFirestore
        .instance
        .collection("bitmoji")
        .where("id", isEqualTo: widget.id.removeAllWhitespace)
        .get();
    // print(fixedData["type"]);
    if (widget.top) {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("bitmoji")
          .where("type", isEqualTo: 1)
          .get();
      print(data.docs[0].get("type"));
      Get.off(() => BitScreen(true, fixedData, data));
    } else {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("bitmoji")
          .where("type", isEqualTo: 0)
          .get();
      // print(data.docs[0].get("type"));
      Get.off(() => BitScreen(false, fixedData, data));
    }
  }
}

class BitScreen extends StatelessWidget {
  BitScreen(this.top, this.fixedData, this.data, {Key? key}) : super(key: key);

  final QuerySnapshot<Map<String, dynamic>> fixedData;
  final QuerySnapshot<Map<String, dynamic>> data;
  final bool top;

  final obj = Get.put(BitmojiButton());

  Widget fixedBottom(PageController controller) {
    return SizedBox(
      // color: Colors.amber,
      height: 370,
      child: Stack(
        children: [
          Positioned(
              top: 231,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: 120,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset("assets/base_bottom.png"),
                      Image.network(
                          fixedData.docs.first.get("image").toString()),
                    ],
                  ))),
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: SizedBox(
              // color: Colors.amber,
              height: 200,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset("assets/base_top.png"),
                  SizedBox(
                    height: 80,
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (index) {
                        for (var i = 0; i < data.docs.length; i++) {
                          obj.selected[i] = false;
                        }
                        obj.selected[index] = true;
                        obj.index.value = index;
                      },
                      itemCount: data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        // widget.obj.selected.add(false);
                        return Image.network(
                            data.docs[index].get("image").toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 65,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: 110, child: Image.asset("assets/base_head.png"))),
        ],
      ),
    );
  }

  Widget fixedTop(PageController controller) {
    return SizedBox(
      // color: Colors.amber,
      height: 370,
      child: Stack(
        children: [
          Positioned(
              top: 231,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: 120,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Image.asset("assets/base_bottom.png"),
                          PageView.builder(
                            controller: controller,
                            onPageChanged: (index) {
                              for (var i = 0; i < data.docs.length; i++) {
                                obj.selected[i] = false;
                              }
                              obj.selected[index] = true;
                              obj.index.value = index;
                            },
                            itemCount: data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              // widget.obj.selected.add(false);
                              return Image.network(
                                  data.docs[index].get("image").toString());
                            },
                          ),
                        ],
                      ),
                    ],
                  ))),
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset("assets/base_top.png"),
                  Image.network(fixedData.docs.first.get("image").toString())
                ],
              ),
            ),
          ),
          Positioned(
              top: 65,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: 110, child: Image.asset("assets/base_head.png"))),
        ],
      ),
    );
  }

  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        height: 80,
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
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
                color: Colors.pink[700],
                padding: const EdgeInsets.all(10),
                height: double.maxFinite,
                onPressed: () async {
                  obj.loading.value = true;
                  await FirebaseFirestore.instance.collection("kits").add({
                    "createdby": [
                      user.name,
                      user.image,
                      FirebaseAuth.instance.currentUser!.uid
                    ],
                    "id": [
                      fixedData.docs.first.get("id"),
                      data.docs[obj.index.value].get("id")
                    ],
                    "likedby": [],
                    "likes": 0,
                    "verified": user.verified,
                    "comments": [],
                    "images": (top)
                        ? [
                            fixedData.docs.first.get("productImage"),
                            data.docs[obj.index.value].get("productImage"),
                          ]
                        : [
                            data.docs[obj.index.value].get("productImage"),
                            fixedData.docs.first.get("productImage"),
                          ],
                          "bitImages": (top)
                        ? [
                            fixedData.docs.first.get("image"),
                            data.docs[obj.index.value].get("image"),
                          ]
                        : [
                            data.docs[obj.index.value].get("image"),
                            fixedData.docs.first.get("image"),
                          ]
                  }).then((value) => {
                        Get.offAll(()=>const DashBoard()),
                      });
                },
                child: (obj.loading.value)
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Upload",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
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
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (top) ? fixedTop(controller) : fixedBottom(controller),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "Available Designs..",
                style: boldtextsyle(19, shadow: true, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      obj.selected.insert(index, false);
                      return SizedBox(
                        height: 90,
                        width: 90,
                        child: Obx(
                          () => InkWell(
                            onTap: () {
                              for (var i = 0; i < data.docs.length; i++) {
                                obj.selected[i] = false;
                              }
                              controller.animateToPage(index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                              obj.selected[index] = true;
                              obj.index.value = index;
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: (obj.selected[index])
                                      ? Colors.pink[200]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 5, color: Colors.grey)
                                  ]),
                              child: Image.network(
                                data.docs[index].get("image"),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            // const SizedBox()
          ],
        ),
      ),
    );
  }
}

// class BitMoji extends StatefulWidget {
//   BitMoji(this.top, this.fixedData, this.data, {Key? key}) : super(key: key);
//   final QuerySnapshot<Map<String, dynamic>> fixedData;
//   final QuerySnapshot<Map<String, dynamic>> data;
//   final bool top;

//   final obj = Get.put(BitmojiButton());

  

//   @override
//   _BitMojiState createState() => _BitMojiState();
// }

// class _BitMojiState extends State<BitMoji> {
//   Widget fixedBottom(PageController controller) {
//     return SizedBox(
//       // color: Colors.amber,
//       height: 370,
//       child: Stack(
//         children: [
//           Positioned(
//               top: 231,
//               left: 0,
//               right: 0,
//               child: SizedBox(
//                   height: 120,
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       Image.asset("assets/base_bottom.png"),
//                       Image.network(
//                           widget.fixedData.docs.first.get("image").toString()),
//                     ],
//                   ))),
//           Positioned(
//             top: 160,
//             left: 0,
//             right: 0,
//             child: SizedBox(
//               // color: Colors.amber,
//               height: 200,
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Image.asset("assets/base_top.png"),
//                   SizedBox(
//                     height: 80,
//                     child: PageView.builder(
//                       controller: controller,
//                       onPageChanged: (index) {
//                         for (var i = 0; i < widget.data.docs.length; i++) {
//                           widget.obj.selected[i] = false;
//                         }
//                         widget.obj.selected[index] = true;
//                       },
//                       itemCount: widget.data.docs.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         // widget.obj.selected.add(false);
//                         return Image.network(
//                             widget.data.docs[index].get("image").toString());
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               top: 65,
//               left: 0,
//               right: 0,
//               child: SizedBox(
//                   height: 110, child: Image.asset("assets/base_head.png"))),
//         ],
//       ),
//     );
//   }

//   Widget fixedTop(PageController controller) {
//     return SizedBox(
//       // color: Colors.amber,
//       height: 370,
//       child: Stack(
//         children: [
//           Positioned(
//               top: 231,
//               left: 0,
//               right: 0,
//               child: SizedBox(
//                   height: 120,
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       Stack(
//                         alignment: Alignment.topCenter,
//                         children: [
//                           Image.asset("assets/base_bottom.png"),
//                           PageView.builder(
//                             controller: controller,
//                             onPageChanged: (index) {
//                               for (var i = 0;
//                                   i < widget.data.docs.length;
//                                   i++) {
//                                 widget.obj.selected[i] = false;
//                               }
//                               widget.obj.selected[index] = true;
//                             },
//                             itemCount: widget.data.docs.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               // widget.obj.selected.add(false);
//                               return Image.network(widget.data.docs[index]
//                                   .get("image")
//                                   .toString());
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ))),
//           Positioned(
//             top: 160,
//             left: 0,
//             right: 0,
//             child: SizedBox(
//               height: 200,
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Image.asset("assets/base_top.png"),
//                   Image.network("${widget.fixedData.docs.first.get("image")}")
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               top: 65,
//               left: 0,
//               right: 0,
//               child: SizedBox(
//                   height: 110, child: Image.asset("assets/base_head.png"))),
//         ],
//       ),
//     );
//   }

//   final PageController controller = PageController(initialPage: 0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomSheet: Container(
//         color: Colors.white,
//         height: 80,
//         width: double.maxFinite,
//         padding: const EdgeInsets.all(15),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.black,
//               boxShadow: const [
//                 BoxShadow(color: Colors.grey, blurRadius: 10),
//               ],
//               borderRadius: BorderRadius.circular(20)),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//               topLeft: Radius.circular(20),
//               bottomLeft: Radius.circular(20),
//             ),
//             child: Obx(
//               () => MaterialButton(
//                 color: Colors.pink[700],
//                 padding: const EdgeInsets.all(10),
//                 height: double.maxFinite,
//                 onPressed: () async {},
//                 child: (widget.obj.loading.value)
//                     ? const CircularProgressIndicator(
//                         color: Colors.white,
//                       )
//                     : const Text(
//                         "Upload",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//                 height: 50,
//                 width: 50,
//                 // color: Colors.red,
//                 child: Image.asset(
//                   "assets/logopng.png",
//                   fit: BoxFit.fitHeight,
//                 )),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Myntra',
//               style: boldtextsyle(20, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             (widget.top) ? fixedTop(controller) : fixedBottom(controller),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
//               child: Text(
//                 "Available Designs..",
//                 style: boldtextsyle(19, shadow: true, color: Colors.black),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//               child: SizedBox(
//                 height: 100,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: widget.data.docs.length,
//                     itemBuilder: (context, index) {
//                       widget.obj.selected.insert(index, false);
//                       return SizedBox(
//                         height: 90,
//                         width: 90,
//                         child: Obx(
//                           () => InkWell(
//                             onTap: () {
//                               for (var i = 0;
//                                   i < widget.data.docs.length;
//                                   i++) {
//                                 widget.obj.selected[i] = false;
//                               }
//                               controller.animateToPage(index,
//                                   duration: const Duration(milliseconds: 500),
//                                   curve: Curves.easeIn);
//                               widget.obj.selected[index] = true;
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                   color: (widget.obj.selected[index])
//                                       ? Colors.pink[200]
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: const [
//                                     BoxShadow(blurRadius: 5, color: Colors.grey)
//                                   ]),
//                               child: Image.network(
//                                 widget.data.docs[index].get("image"),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//             // const SizedBox()
//           ],
//         ),
//       ),
//     );
//   }
// }

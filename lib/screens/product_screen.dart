import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myntra/constants/text.dart';

class ProductInfo extends GetxController {
  RxInt selectedSize = (-1).obs;
}

class ProductPage extends StatelessWidget {
  ProductPage(
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
                                "." +" "+
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

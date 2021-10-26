import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myntra/constants/text.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

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
                          const Icon(Icons.tv,size: 20,),
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
                                "4.1",
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
                        "Brand Name",
                        style: boldtextsyle(20),
                      ),
                      const SizedBox(
                        height: 0,
                        width: 5,
                      ),
                      Text(
                        "Mens chsbf,f.kh.ffj",
                        style: mediumtextsyle(14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Rs. 5000",
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myntra/constants/small_products.dart';
import 'package:myntra/constants/text.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            actions: [
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
            expandedHeight: 170.0,
            stretch: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey.shade100,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 120.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey,
                                // color: Colors.black
                              )
                            ]),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 7),
                        child: TextField(
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: normaltextsyle(15),
                          // maxLength: 100,
                          decoration: InputDecoration(
                            icon: const FaIcon(FontAwesomeIcons.search),
                            hintText: "Search for Products",
                            hintStyle:
                                normaltextsyle(14, color: Colors.grey[700]),
                            border: InputBorder.none,
                          ),
                          controller: _controller,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildListDelegate(
              [
                product(),
                product(),
                product(),
                product(),
                product(),
                product(),
                product(),
                product(),
                product(),
                product(),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 0.6,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return productBox();
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

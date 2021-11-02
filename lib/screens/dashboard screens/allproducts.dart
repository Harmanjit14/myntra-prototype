import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myntra/constants/small_products.dart';
import 'package:myntra/constants/text.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
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
        // SliverFixedExtentList(
        //   itemExtent: 150.0,
        //   delegate: SliverChildListDelegate(
        //     [
        //       product(),
        //       product(),
        //       product(),
        //       product(),
        //       product(),
        //       product(),
        //       product(),
        //       product(),
        //       product(),
        //       product(),
        //     ],
        //   ),
        // ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return const SliverToBoxAdapter(child: Text("Hello"));
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 0.6,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    DocumentSnapshot _doc = snapshot.data!.docs[index];
                    return productBox(_doc);
                  },
                  childCount: snapshot.data!.size,
                ),
              );
            } else {
              return const SliverToBoxAdapter(child: Text("No data"));
            }
          },
        ),
        // SliverGrid(
        //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 250,
        //     mainAxisSpacing: 15.0,
        //     crossAxisSpacing: 0.0,
        //     childAspectRatio: 0.6,
        //   ),
        //   delegate: SliverChildBuilderDelegate(
        //     (BuildContext context, int index) {
        //       return productBox();
        //     },
        //     childCount: 20,
        //   ),
        // ),
      ],
    );
  }
}

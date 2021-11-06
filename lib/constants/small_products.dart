import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/screens/product_screen.dart';

product() {
  return SizedBox(
    height: 150,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
      ),
    ),
  );
}

productBox(DocumentSnapshot _doc) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductScreen(_doc));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
          ),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: SizedBox(
                      // height:100,
                      child: Image.network(
                        "${_doc.get("image")}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "${_doc.get('title')}",
                  style: boldtextsyle(16, shadow: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "${_doc.get('subtitle')}",
                  style: normaltextsyle(13, color: Colors.grey.shade600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("${_doc.get('price')}",
                    style: boldtextsyle(18,
                        shadow: true, color: Colors.pink.shade300)),
              ),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

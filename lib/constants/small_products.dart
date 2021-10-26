import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/screens/product_screen.dart';

class Product extends GetxController {
  RxBool liked = false.obs;
  RxBool cart = false.obs;
}

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

productBox() {
  final _product = Get.put(Product());
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: InkWell(
        onTap: () {
          Get.to(() => const ProductPage(), transition: Transition.leftToRight);
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: SizedBox(
                          // height:100,
                          child: Image.asset(
                            "assets/model.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            _product.liked.value =
                                (_product.liked.value) ? false : true;
                          },
                          icon: (_product.liked.value)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {
                            _product.cart.value =
                                (_product.cart.value) ? false : true;
                          },
                          icon: (_product.cart.value)
                              ? const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.shopping_bag,
                                  color: Colors.orange.shade700,
                                  size: 30,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Green Dress",
                  style: boldtextsyle(16, shadow: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Women dress A",
                  style: normaltextsyle(13, color: Colors.grey.shade600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("\$50",
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myntra/constants/text.dart';
import 'package:myntra/screens/dashboard%20screens/allproducts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomSelector extends GetxController {
  RxInt selected = 0.obs;
}

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

final obj = Get.put(BottomSelector());
final _controller = PageController();

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: obj.selected.value,
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.pink[800],
          unselectedItemColor: Colors.grey,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedLabelStyle: boldtextsyle(14),
          unselectedLabelStyle: mediumtextsyle(14),
          onTap: (value) {
            obj.selected.value = value;
            _controller.animateToPage(value,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeIn);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Favorites',
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: 'Music',
              icon: Icon(Icons.music_note),
            ),
            BottomNavigationBarItem(
              label: 'Places',
              icon: Icon(Icons.location_on),
            ),
          ],
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
      ),
      body: PageView(
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          AllProducts(),
          AllProducts(),
          AllProducts(),
        ],
      ),
    );
  }
}

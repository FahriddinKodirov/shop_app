import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magazin_app/screen/Tab_Item/all_page.dart';
import 'package:magazin_app/screen/tab_bar/home_page/home_page.dart';
import 'package:magazin_app/screen/tab_bar/savat/savat_page.dart';

class BottomNavigatorBar extends StatefulWidget {
  BottomNavigatorBar({super.key});

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int index = 0;

  List _page = [
    HomePage(),
    SavatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,),
          label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_rounded, size: 30,),
          label: ''),
        ],

      ),
    );
  }
}
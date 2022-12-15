import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magazin_app/data/model/category_model.dart';
import 'package:magazin_app/screen/Tab_Item/electronic.dart';
import 'package:magazin_app/screen/Tab_Item/jewelery.dart';
import 'package:magazin_app/screen/Tab_Item/mens_clothing.dart';
import 'package:magazin_app/screen/Tab_Item/womens_clothing.dart';
import 'package:magazin_app/screen/Tab_Item/all_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          title:const Text(
            'Online Magazin',
          
          ),
        bottom: TabBar(
          unselectedLabelColor: Colors.white30,
          labelColor: Colors.white,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            const  Tab(
              icon: Text('All',style: TextStyle(fontSize: 20),)
            ),
            Tab(
              icon: Text(Category.CategoryList[0],style: TextStyle(fontSize: 20),)
            ),
            Tab(
              icon: Text(Category.CategoryList[1],style: TextStyle(fontSize: 20),)
            ),
            Tab(
              icon: Text(Category.CategoryList[2],style: TextStyle(fontSize: 20),)
            ),
            Tab(
              icon: Text(Category.CategoryList[3],style: TextStyle(fontSize: 20),)
            ),
          ]),
      ),
      body: TabBarView(
           children: [
            AllPage(),
            Electronic(),
            Jewelery(),
            MensClothing(),
            WomensClothing(),
           ],
      ),
      )
    );
  }
}
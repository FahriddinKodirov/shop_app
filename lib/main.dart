import 'package:flutter/material.dart';
import 'package:magazin_app/screen/Tab_Item/all_page.dart';
import 'package:magazin_app/screen/tab_bar/bottom_navigater_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigatorBar(),
    );
  }
}


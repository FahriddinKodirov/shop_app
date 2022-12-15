import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magazin_app/data/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:magazin_app/screen/save_page/save_page.dart';

class InSidePage extends StatefulWidget {
  var id1;
  InSidePage({super.key,
             required this.id1});

  @override
  State<InSidePage> createState() => _InSidePageState();
}

class _InSidePageState extends State<InSidePage> {

  Future<List<Model>> getData()async{
    String url = 'https://fakestoreapi.com/products/';

    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      List json = jsonDecode(response.body) as List;
      List<Model> users = json.map((e) => Model.fromJson(e)).toList();
    return users;
    }
    return List.empty();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "",
          
        ),
      ),
      body: FutureBuilder<List<Model>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
          if(snapshot.hasData){
            List<Model?>? users = snapshot.data;

              return stuff(
                                  context,
                                  users?[widget.id1],
                                  users?[widget.id1]?.id ?? 0,
                                  users?[widget.id1]?.title ?? "NO",
                                  users?[widget.id1]?.price ?? 0.0,
                                  users?[widget.id1]?.description ?? "NO",
                                  users?[widget.id1]?.category ?? "NO",
                                  users?[widget.id1]?.image ?? "NO"
                                  );
          }
          return Container();
        },),
    );
  }
  }
  stuff(context,users,id,title,price,description,category,image){
    var height1 = MediaQuery.of(context).size.height*0.5;
    var width1 = MediaQuery.of(context).size.width;
    
    return Container(
      child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
       SizedBox(height: 10,),
       Container(
         height: 350,
         width: 350,
         
         
         child: Image.network(image,width: 350,) ,
       ),
       SizedBox(height:height1*0.02),
       Container(
         padding: EdgeInsets.only(left: 10),
         alignment: Alignment.centerLeft,
         child: Text(title,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),)
       ),
       SizedBox(height:height1*0.01),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Container(
           child: Text(description,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),)
         ),
       ),
       SizedBox(height:height1*0.04),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Container(
               child: Text("\$ $price",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.blue,fontSize: 30),)
             ),
           ),
           Container(
                  padding: EdgeInsets.only(right: 10),         
                  child:
                   SavePage(
                             product: users,
                             ondeletd: () {
                               
                             },
                           ),
                         ),
         ],
       ),
       
      ]),
    );
}
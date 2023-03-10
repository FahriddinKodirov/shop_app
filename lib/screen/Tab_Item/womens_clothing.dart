import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magazin_app/data/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:magazin_app/screen/inside/inside_page.dart';
import 'dart:convert';

import '../../data/model/category_model.dart';

class WomensClothing extends StatefulWidget {
  const WomensClothing({super.key});

  @override
  State<WomensClothing> createState() => _WomensClothingState();
}

class _WomensClothingState extends State<WomensClothing> {
 Future<List<Model>> getData()async{
    String url = 'https://fakestoreapi.com/products/category/${Category.CategoryList[3]}';

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
      body: FutureBuilder<List<Model>?>(
           future: getData(),
           builder: (BuildContext context, AsyncSnapshot<List<Model>?> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              );
            }
          if(snapshot.hasData){
          List<Model?>? users = snapshot.data;
           return Container(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: users!.length,
                    itemBuilder: (context, index) {
                      return stuff(
                          context,
                          users[index]?.id ?? 0,
                          users[index]?.title ?? "NO",
                          users[index]?.price ?? 0.0,
                          users[index]?.description ?? "NO",
                          users[index]?.category ?? "NO",
                          users[index]?.image ?? "NO");
                    }),
              );
            
 

          }
           return Container();

           }
      ),
    );
  }

  stuff(context, id, title, price, description, category, image) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => InSidePage(
                        id1: id-=1,
                      )));
        }),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(15)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    image,
                    width: 220,
                  ),
                ),
                SizedBox(height: height1 * 0.01),
                Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      )),
                ),
                SizedBox(height: height1 * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                          child: Text(
                        category,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black54),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                          child: Text(
                        "\$ $price",
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black54),
                      )),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magazin_app/data/database/local_database.dart';
import 'package:magazin_app/data/model/product_model.dart';

class SavePage extends StatefulWidget {
  VoidCallback ondeletd;
  Model product;
  SavePage({super.key,
            required this.product,
            required this.ondeletd,});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async{
          // bool isHas = false;
          Model founded = Model(
            image: 'image',
            id: 0,
            title: 'title',
            description: "description",
            price: 1,
            category: ""
          );
        // for(Model i in cart_items){
        //   if(widget.product.title == i.title){
        //     print(widget.product.title);
        //     print(i.title);
        //     isHas = true;
        //     founded = i;
        
        //   }
        // }
        // if(isHas == false){
        //   if(widget.product.count == 0){
        //     widget.product.count += 1;
           LocalDatabase.insertToDatabase(widget.product); 
        //   }
        // } else{
        //   await LocalDatabase.deleteTaskById(widget.product.id!.toInt());
        //   founded.count += 1;
        //   await LocalDatabase.insertToDatabase(founded);
        // }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text("${widget.product.title} savatga qo'shildi"),
          ),
        );
        },
        child: Container(
        height: 32,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Text(
            "Savatga qo'shish",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }


  List<Model> cart_items = [];
getCartItem() async {
  cart_items = await LocalDatabase.getList();
}
}
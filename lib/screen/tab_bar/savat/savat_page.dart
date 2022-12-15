import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magazin_app/data/database/local_database.dart';
import 'package:magazin_app/data/model/product_model.dart';

class SavatPage extends StatefulWidget {
  const SavatPage({super.key});

  @override
  State<SavatPage> createState() => _SavatPageState();
}

class _SavatPageState extends State<SavatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Savat'),
      ),
      body: Container(
        child: FutureBuilder(
          future: LocalDatabase.getList(),
          builder: (BuildContext context, AsyncSnapshot<List<Model>> snapshot){
           if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Container(
                  child: const Center(child: Text('Empty')),
                );
              }
              return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItem(
                    plus: () =>setState(() {
                      
                    }),
                    onDeleted:()=>setState(() {

                    }),
                    model: snapshot.data?[index],

                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          
          },
        ),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  Model? model;
  final VoidCallback onDeleted;
  final VoidCallback plus;

  TaskItem({
    Key? key,
    required this.onDeleted,
    required this.model,
    required this.plus,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var a = 0;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(12),
              child: Image.network(
                widget.model!.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: 328,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              padding:
                  const EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 10),
              margin: const EdgeInsets.all(12),
              child: Text(
                widget.model!.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepPurple.shade900),
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              margin: const EdgeInsets.all(12),
              child: Text(
                widget.model!.category,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Container(
              width: 328,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.grey),
              padding:
                  const EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 10),
              margin: const EdgeInsets.all(12),
              child: Text(widget.model!.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '\$${widget.model!.price.toString()}',
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () async {
                      widget.onDeleted.call();
                                      setState(() async {
                                        await LocalDatabase.deleteTaskById(
                                            widget.model!.id.toInt());
                    
                    });},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    )),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (a != 0) {
                            a--;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.deepPurple),
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 33, color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.deepPurple),
                      child: Text(
                        a.toString(),
                        style:
                            const TextStyle(fontSize: 33, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          var a;
                          widget.plus();
                          a++;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.deepPurple),
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 33, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
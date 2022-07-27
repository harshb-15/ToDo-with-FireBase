import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iste_crud/task.dart';
import 'package:iste_crud/constants.dart';

class DrawList extends StatefulWidget {
  const DrawList({Key? key}) : super(key: key);

  @override
  State<DrawList> createState() => _DrawListState();
}

var db = FirebaseFirestore.instance;

class _DrawListState extends State<DrawList> {
  var collectionRef = db.collection('tasks');
  List lst = [], lst2 = [];

  getData() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final allData2 = querySnapshot.docs.map((doc) => doc.id).toList();
    lst = allData;
    lst2 = allData2;
    setState(() {});
  }
@override
  void initState() {
    print("IntiState called");
    // TODO: implement initState
    super.initState();
    drList=getData;
    getData();
  }
  @override
  Widget build(BuildContext context) {
    drList=getData;
    print("Drawlist called");
    // getData();
    return Container(
      width: double.infinity,
      child: ListView.builder(
        itemCount: lst.length,
        itemBuilder: (BuildContext context, int index) {
          return Task(
            name: lst[index]['lul'],
            docID: lst2[index],
            done: lst[index]['done'],
            // docID: ,
          );
        },
      ),
    );
  }
}

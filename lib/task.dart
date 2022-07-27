import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iste_crud/lists.dart';
import 'package:iste_crud/constants.dart';

class Task extends StatefulWidget {
  String name, docID;
  bool? done;

  Task({
    Key? key,
    required this.name,
    required this.docID,
    required this.done,
  }) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController c2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: c2,
                ),
                ElevatedButton(
                  onPressed: () {
                    String tsk = c2.text;
                    c2.clear();
                    Navigator.pop(context);
                    db
                        .collection('tasks')
                        .doc(widget.docID)
                        .update({'lul': tsk});
                    widget.name = tsk;
                    setState(() {});
                  },
                  child: Text("Update"),
                )
              ],
            ),
          ),
          isScrollControlled: true,
        );
      },
      onLongPress: () {
        db.collection('tasks').doc(widget.docID).delete();
        drList();
        // DrawList();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        width: (width * 9) / 10,
        child: Row(
          children: [
            Checkbox(value: widget.done, onChanged: (bool? newValue) {
              widget.done = newValue;
              db
                  .collection('tasks')
                  .doc(widget.docID)
                  .update({'done': newValue!});
              drList();
            }),
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}

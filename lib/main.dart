// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iste_crud/lists.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iste_crud/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      home: const MyHomePage(title: 'Tasks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController c1 = TextEditingController();

  void addTask(String task) {
    // setState(() {
    //   print("SetState of HomePage called");
    //   print("Details added");
    // });
    db.collection('tasks').doc().set({'lul': task, 'done': false});
    drList();
  }
  @override
  Widget build(BuildContext context) {
    print("MyHomePage called");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tasks"),
          actions: [
            IconButton(
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      Padding(
                        padding: MediaQuery
                            .of(context)
                            .viewInsets,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: c1,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                String tsk = c1.text;
                                c1.clear();
                                Navigator.pop(context);
                                addTask(tsk);
                              },
                              child: Text("Add"),
                            )
                          ],
                        ),
                      ),
                  isScrollControlled: true,
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: DrawList(),
      ),
    );
  }
}

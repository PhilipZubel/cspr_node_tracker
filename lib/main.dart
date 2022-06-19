import 'package:cspr_node_tracker/objects/node.dart';
import 'package:flutter/material.dart';
import 'nodeList.dart';
import 'objects/node.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// tutorial on hive box:
// https://developerb2.medium.com/todo-app-using-hive-database-flutter-2a2de2ca6782

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NodeAdapter());
  await Hive.openBox<Node>("node");
  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSPR Node Tracker',
      home: new NodeList(),
    );
  }
}


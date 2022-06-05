import 'package:flutter/material.dart';
import 'nodeList.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSPR Node Tracker',
      home: new NodeList(),
    );
  }
}


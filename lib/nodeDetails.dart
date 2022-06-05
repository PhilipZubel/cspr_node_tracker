import 'package:flutter/material.dart';
import 'objects.dart';


class SecondRoute extends StatelessWidget {

  final void Function(Node)? removeNode;
  final Node node;

    SecondRoute({
    required this.node,
    required this.removeNode,
  }) : super(key: ObjectKey(node));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
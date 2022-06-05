import 'package:flutter/material.dart';
import 'nodeDetails.dart';
import 'objects.dart';

class NodeItem extends StatelessWidget {
  NodeItem({
    required this.node,
    // required this.onNodeChanged,
  }) : super(key: ObjectKey(node));

  final Node node;
  // final onNodeChanged;

  // TextStyle? _getTextStyle(bool checked) {
  //   if (!checked) return null;

  //   return const TextStyle(
  //     color: Colors.black54,
  //     decoration: TextDecoration.lineThrough,
  //   );
  // }

    void _switchRoute(context){
      print("tap");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondRoute()));
    }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // onNodeChanged(node);
        _switchRoute(context);
      },
      leading: CircleAvatar(
        child: Text(node.IP[0]),
      ),
      title: Text(node.IP),
    );
  }

    

}

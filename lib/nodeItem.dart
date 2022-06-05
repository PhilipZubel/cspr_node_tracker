import 'package:flutter/material.dart';
import 'objects.dart';

class NodeItem extends StatelessWidget {

  final void Function(BuildContext, Node)? switchDetails;
  final Node node;

  NodeItem({
    required this.node,
    required this.switchDetails,
  }) : super(key: ObjectKey(node));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // onNodeChanged(node);
        switchDetails!(context, node);
      },
      leading: CircleAvatar(
        child: Text(node.ip[0]),
      ),
      title: Text('${node.ip}:${node.port}'),
    );
  }

    

}

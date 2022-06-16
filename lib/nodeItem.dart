import 'package:flutter/material.dart';
import 'objects.dart';

class NodeItem extends StatefulWidget {

  final void Function(BuildContext, Node)? switchDetails;
  final void Function(Node)? removeNode;
  final Node node;

  NodeItem({
    required this.node,
    required this.switchDetails, 
    required this.removeNode,
  }) : super(key: ObjectKey(node));

  @override
  State<NodeItem> createState() => _NodeItemState();
}

class _NodeItemState extends State<NodeItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // onNodeChanged(node);
        widget.switchDetails!(context, widget.node);
      },
      leading: CircleAvatar(
        child: Text(widget.node.ip[0]),
        backgroundColor: Colors.green[500],
        foregroundColor: Colors.white,
      ),
      title: Text('${widget.node.ip}:${widget.node.port}'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {widget.removeNode!(widget.node);},
        ),
    );
  }
}

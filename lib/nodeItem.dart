import 'package:flutter/material.dart';
import 'objects.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

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

  Color? iconColor = Colors.grey;
  

  // Future<bool> _getStatus () async {
  //   
  //   var response = await http.get(Uri.http(url , 'status')).timeout(
  //     const Duration(seconds: 1),
  //     onTimeout: () {
  //       return http.Response('Error', 500);
  //     },
  //   );
  //   return true;
  // }
  void _checkStatus() async {
    String url = '${widget.node.ip}:${widget.node.port}';
    http.Response response = await http.get(Uri.http(url , 'status')).timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        return http.Response('Error', 500);
      },
    );
    if (response.statusCode == 200){
      setState(() {
        iconColor = Colors.green[500];
      });
    }
    else{
      setState(() {
        iconColor = Colors.red[500];
      });
    }
    
  }

  @override
  void initState(){
    super.initState();
    _checkStatus();
    final timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => _checkStatus());
    // var status = _getStatus();
    // print(status);
    print("hi");
    
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // onNodeChanged(node);
        widget.switchDetails!(context, widget.node);
      },
      leading: CircleAvatar(
        child: Text(widget.node.ip[0]),
        // backgroundColor: Colors.green[500],
        backgroundColor: iconColor,
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



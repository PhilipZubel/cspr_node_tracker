import 'package:flutter/material.dart';
import 'nodeDetails.dart';
import 'objects.dart';
import 'nodeItem.dart';

class NodeList extends StatefulWidget {
  const NodeList({Key? key}) : super(key: key);
  @override
  State<NodeList> createState() => _NodeListState();
}

class _NodeListState extends State<NodeList> {

  TextEditingController controllerIP = TextEditingController();
  TextEditingController controllerPort = TextEditingController();
  List<Node> nodes = <Node>[];

  void removeNodeItem(Node n) {
      setState(() {nodes.remove(n);});
  }

  void switchDetails(BuildContext context, Node n){
      Navigator.push(context, MaterialPageRoute(builder: (context) => NodeDetails2(
        node: n,
        removeNode: removeNodeItem,
      )));
    }

  bool isIPValid() {
      var ip = controllerIP.text;
      var port = controllerPort.text;
      return isValidIP(ip) && isNumeric(port);
  }

  void _addNodeItem() {
      var ip = controllerIP.text;
      var port = controllerPort.text;
      setState(() {
        nodes = [...nodes, Node(ip: ip, port: int.parse(port), favorite: false)];
      });
      controllerIP.clear();
      controllerPort.clear();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> _displayDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a new Node'),
            content: Column(children: <Widget>[
                const Text("IP Number"),
                TextField(
                  controller: controllerIP,
                  decoration: const InputDecoration(hintText: "127.0.0.1"),
                  maxLength: 15,
                ),
                const Text("Port Number"),
                TextField(
                  controller: controllerPort,
                  decoration: const InputDecoration(hintText: "8000"),
                  maxLength: 5,
                ),
              ],
            ),

            actions: <Widget>[
              TextButton(
                child: const Text('Add') ,
                onPressed: () {
                  if(isIPValid()){
                    _addNodeItem();
                    Navigator.of(context).pop();
                  }
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('CSPR Node Tracker')),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: nodes.map((Node node) {
            return NodeItem(
              node: node,
              switchDetails: switchDetails,
              removeNode: removeNodeItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _displayDialog(),
            tooltip: 'Add Node',
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
    }
}


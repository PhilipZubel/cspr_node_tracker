import 'package:flutter/material.dart';
import 'nodeDetails.dart';
import 'objects/node.dart';
import 'nodeItem.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class NodeList extends StatefulWidget {
  const NodeList({Key? key}) : super(key: key);
  @override
  State<NodeList> createState() => _NodeListState();
}

class _NodeListState extends State<NodeList> {

  TextEditingController controllerIP = TextEditingController();
  TextEditingController controllerPort = TextEditingController();

  late Box<Node> nodeBox;

  @override
  void initState() {
    super.initState();
    nodeBox = Hive.box("node");
  }

  void removeNodeItem(int idx) {
      nodeBox.deleteAt(idx);
  }

  void switchDetails(BuildContext context, Node n){
      Navigator.push(context, MaterialPageRoute(builder: (context) => NodeDetails(
        node: n,
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
      Node node = Node(ip: ip, port: int.parse(port), favorite: false);
      nodeBox.add(node);
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
        // body: ListView(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
        //   children: nodes.map((Node node) {
        //     return NodeItem(
        //       node: node,
        //       switchDetails: switchDetails,
        //       removeNode: removeNodeItem,
        //     );
        //   }).toList(),
        // ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ValueListenableBuilder<Box<Node>>(
            valueListenable: nodeBox.listenable(),
            builder: (BuildContext context, Box<Node> value, Widget? child){
              if (nodeBox.length > 0) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: nodeBox.length,
                  itemBuilder: (context, index) {
                    // print(nodeBox.getAt(index));
                    return NodeItem(
                      node: nodeBox.getAt(index)!,
                      switchDetails: switchDetails,
                      removeNode: removeNodeItem,
                      index: index,
                    );
                    // return ListTile(
                    //   title: Text(nodeBox.getAt(index)!.ip),
                    //   trailing: IconButton(
                    //     icon: Icon(Icons.delete),
                    //     onPressed: () => removeNodeItem(index),
                    //   ),
                    // );
                  },
                );
              };
              return const Text("No node servers added yet.");
            },
            // builder: (context, nodes, child) {
            //   return ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: nodes.length,
            //     itemBuilder: (context, index) {
            //       final node = nodes.getAt(index);
            //       return NodeItem(
            //         node: node!,
            //         switchDetails: switchDetails,
            //         removeNode: removeNodeItem,
            //         index: index,
            //       );
            //     },
            //   );
            // },
            
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _displayDialog(),
            tooltip: 'Add Node',
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
    }
}


import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {

    bool _addNodeItem() {
      var ip = controllerIP.text;
      var port = controllerPort.text;
      
      var validIP = isValidIP(ip) && isNumeric(port);
      if(validIP){
          setState(() {
          // nodes.add(Node(name: name, checked: false));
          nodes = [...nodes, Node(IP: ip, port: int.parse(port), favorite: false)];
        });
        controllerIP.clear();
        controllerPort.clear();

      }else{
        var temp1 = isValidIP(ip);
        var temp2 = isNumeric(port);
        print('Invalid IP address');
      }
      return validIP;
    }


    Future<void> _displayDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a new node'),
            // content: TextField(
            //   controller: controller[0],
            //   decoration: const InputDecoration(hintText: '12'),
            // ),
            content: Column(children: <Widget>[
                TextField(
                  controller: controllerIP,
                  decoration: const InputDecoration(),
                ),
                const Text(":"),
                TextField(
                  controller: controllerPort,
                  decoration: const InputDecoration(),
                ),
              ],
            ),

            actions: <Widget>[
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  var success = _addNodeItem();
                  if(success) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('CSPR node tracker'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: nodes.map((Node node) {
            return NodeItem(
              node: node,
            );
          }).toList(),
        ),
        // body: ListView.builder(
        //   itemCount: nodes.length,
        //   itemBuilder: (context, index) {
        //     return GestureDetector(
        //       child: NodeItem(node: nodes[index]),
        //       onTap: () => _switchRoute()
              
        //     );
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _displayDialog(),
            tooltip: 'Add Node',
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
    }
}


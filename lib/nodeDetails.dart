import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'objects.dart';

import 'package:http/http.dart' as http;

const styleBold = const TextStyle(fontWeight: FontWeight.bold);

class NodeData {
  NodeData({
    required this.uptime, 
    // required this.nextUpgrade, 
    required this.roundLength,
    required this.blockHeight,
    required this.timestamp,
    });
  String uptime;
  // String nextUpgrade;
  String roundLength;
  int blockHeight;
  String timestamp;
}


// 78.159.84.140

class NodeDetails2 extends StatefulWidget {
  final void Function(Node)? removeNode;
  final Node node;

  const NodeDetails2({
    Key? key,
    required this.node,
    required this.removeNode,
  }) : super(key: key);

  @override
  State<NodeDetails2> createState() => _NodeDetails2State();
}

class _NodeDetails2State extends State<NodeDetails2> {

  Future<NodeData> getNodeData() async {
    print("hello");
    String url = '${widget.node.ip}:${widget.node.port}';
    print(url);

    var response = await http.get(Uri.http(url , 'status')).timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        print("fail");
        return http.Response('Error', 500);
      },
      );
    
    print(response.statusCode);
    // print(response.body[0]);
    var jsonData = jsonDecode(response.body);
    // List<User> data = [];

    // print( jsonData['last_added_block_info']['height'].runtimeType);

    NodeData data = NodeData(
      uptime: jsonData['uptime'], 
      // nextUpgrade: jsonData['next_upgrade'], 
      roundLength: jsonData['round_length'], 
      blockHeight: jsonData['last_added_block_info']['height'], 
      timestamp: jsonData['last_added_block_info']['timestamp'],
      );

    return data;
  } 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.node.ip}:${widget.node.port}'),
        
      ),
      body: Center(
        // child: ElevatedButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Text('Go back!'),
        // ),
        child: FutureBuilder<NodeData>(
          future: getNodeData(),
          builder: (context, snapshot){
            if(snapshot.data == null) {
              return const Center(child: Text("Loading..."));
            } else {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: ListTile(
                        title: const Text("Server IP", style: styleBold),
                        trailing: Text('${widget.node.ip}:${widget.node.port}', style: styleBold),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: ListTile(
                        title: const Text("Block Height", style: styleBold),
                        trailing: Text(snapshot.data!.blockHeight.toString()),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: ListTile(
                        title: const Text("Uptime", style: styleBold),
                        trailing: Text(snapshot.data!.uptime),
                      ),
                      // child: Text(snapshot.data!.uptime),
                    ),
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: ListTile(
                        title: const Text("Timestamp", style: styleBold),
                        trailing: Text(snapshot.data!.timestamp),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: ListTile(
                        title: const Text("Round Length", style: styleBold),
                        trailing: Text(snapshot.data!.roundLength),
                      ),
                    ),
                  ],
                );
              } 
                return Text('${snapshot.error}');
              
              }
            },
          )
      ),
    );
  }
}
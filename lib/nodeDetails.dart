import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'objects/node.dart';

import 'package:http/http.dart' as http;

const styleBold = TextStyle(fontWeight: FontWeight.bold);

class NodeData {
  NodeData({
    required this.uptime, 
    required this.roundLength,
    required this.blockHeight,
    required this.timestamp,
    });
  String uptime;
  String roundLength;
  int blockHeight;
  String timestamp;
}


// 78.159.84.140

class NodeDetails extends StatefulWidget {
  final Node node;

  const NodeDetails({
    Key? key,
    required this.node,
  }) : super(key: key);

  @override
  State<NodeDetails> createState() => _NodeDetailsState();
}

class _NodeDetailsState extends State<NodeDetails> {

  Future<NodeData?> getNodeData() async {
    String url = '${widget.node.ip}:${widget.node.port}';

    var response = await http.get(Uri.http(url , 'status')).timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        return http.Response('Error', 500);
      },
      );
    
    if (response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      NodeData data = NodeData(
        uptime: jsonData['uptime'], 
        // nextUpgrade: jsonData['next_upgrade'], 
        roundLength: jsonData['round_length'], 
        blockHeight: jsonData['last_added_block_info']['height'], 
        timestamp: jsonData['last_added_block_info']['timestamp'],
        );

      return data;
    }

    String error; 
    if(response.statusCode == 500){
      error = "Connection Timeout";
    }else{
      error = 'Error - status code ${response.statusCode}';    
    }
    return NodeData(
        uptime: error, 
        // nextUpgrade: jsonData['next_upgrade'], 
        roundLength: "", 
        blockHeight: -1, 
        timestamp: "",
        );;
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.node.ip}:${widget.node.port}'),
        
      ),
      body: Center(
        child: FutureBuilder<NodeData?>(
          future: getNodeData(),
          builder: (context, snapshot){
            if(snapshot.data == null) {
              return const Center(child: Text("Loading..."));
            } else {
              if (snapshot.data!.blockHeight != -1) {
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
                        title: const Text("Status", style: styleBold),
                        trailing: Text('Active', style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold)),
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
                      title: const Text("Status", style: styleBold),
                      trailing: Text('Inactive', style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: ListTile(
                      title: const Text("Error", style: styleBold),
                      trailing: Text(snapshot.data!.uptime),
                    ),
                  ),
                ],
              );
              }
            },
          )
      ),
    );
  }
}
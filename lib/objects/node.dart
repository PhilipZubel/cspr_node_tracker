import 'package:regexed_validator/regexed_validator.dart';

import 'package:hive/hive.dart';
part 'node.g.dart';

@HiveType(typeId: 0)
class Node {
  Node({required this.ip, required this.port, required this.favorite});
  @HiveField(0)
  String ip;
  @HiveField(1)
  int port;
  @HiveField(2)
  bool favorite;
}

  bool isValidIP(String s){
    if (s.isEmpty) return false;
    return validator.ip(s);
  }

  bool isNumeric(String s) {
    return int.parse(s)>=0;
  }
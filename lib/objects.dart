import 'package:regexed_validator/regexed_validator.dart';

class Node {
  Node({required this.IP, required this.port, required this.favorite});
  // List<int> IP;
  String IP;
  int port;
  bool favorite;
}


  bool isValidIP(String s){
    if (s.isEmpty) return false;
    return validator.ip(s);
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return int.parse(s) != null && int.parse(s)>0;
  }
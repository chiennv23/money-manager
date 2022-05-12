import 'package:coresystem/Core/userService.dart';

class Header {
  static Map<String, String> GetheaderBase() {
    var token = UserService.userInfo.token;
    if (token != null) {
      return <String, String>{
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'cApiKey': '19001111'
      };
    } else {
      return <String, String>{
        'Content-type': 'application/json',
        'cApiKey': '19001111'
      };
    }
  }
}

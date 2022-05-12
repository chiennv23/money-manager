import 'dart:convert';

import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/user_info.dart';

Future<UserInfo> parseJwt(String token) async {
  try {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    final payload = _decodeBase64(parts[1]);
    final payloadMap = UserInfo.fromJson(json.decode(payload));
    return payloadMap;
  } catch (e) {
    await SnackBarCore.fail(title: e.toString(), isBottom: true);

    return null;
  }
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

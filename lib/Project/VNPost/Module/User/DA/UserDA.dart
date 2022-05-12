import 'package:coresystem/Core/userService.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/AccountItem.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/SpitAddressItem.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/registerItem.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/verifySuccessItem.dart';

import '../../../../../Core/BaseDA.dart';
import '../../../../../Core/BaseResponse.dart';
import '../../../../../Core/ConfigAPI.dart';
import '../../../../../Utils/Crypto/cryptojs_aes_encryption_helper.dart';
import '../Model/UserResponse.dart';

class UserDA {
  static Future<BasicResponse<UserResponse>> login(
      String userName, String password) async {
    final obj = {
      'username': userName,
      'password': password,
      'isEmployee': false
    };
    final response = await BaseDA.post(
        ConfigAPI.urlLogin, obj, (json) => UserResponse.fromJson(json),
        showError: false);
    return response;
  }

  static Future<BasicResponse<registerSuccessItem>> register(
      registerItem obj) async {
    final response = await BaseDA.post(ConfigAPI.registerAPI, obj,
        (json) => registerSuccessItem.fromJson(json),
        showError: false);
    return response;
  }

  static Future<BasicResponse<List<SpitAddressItem>>> addresssearch(
      String input) async {
    final url =
        '${ConfigAPI.addresssearch}?inputStr=$input&maxResult=1&minscore=0&textType=VN';
    final response = await BaseDA.get(
      url,
      (json) => SpitAddressItem.fromJsonToList(json),
    );
    return response;
  }

  static Future<BasicResponse<verifySuccessItem>> Verify(
      String username, String otp, String type) async {
    final url =
        '${ConfigAPI.verify}?username=$username&otp=$otp&verifyType=$type';
    final response = await BaseDA.put(
      url,
      (json) => verifySuccessItem.fromJson(json),
    );
    return response;
  }

  static Future<BasicResponse<verifySuccessItem>> resendOtp(
      String username, String type) async {
    final url = '${ConfigAPI.resendOtp}?username=$username&verifyType=$type';
    final response = await BaseDA.put(
      url,
      (json) => verifySuccessItem.fromJson(json),
    );
    return response;
  }

  static Future<BasicResponse> logout() async {
    UserService.removeUser();
  }
}

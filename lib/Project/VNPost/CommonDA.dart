import 'package:coresystem/Core/userService.dart';
import 'package:coresystem/Project/VNPost/Model/PaymentResponse.dart';
import 'package:coresystem/Project/VNPost/Module/User/Model/LocationItem.dart';

import '../../../../../Core/BaseDA.dart';
import '../../../../../Core/BaseResponse.dart';
import '../../../../../Core/ConfigAPI.dart';
import 'Model/ConfigSearch.dart';
import 'Model/DrodownItem.dart';

class CommonDA {
  static int dateNumber = 50;
  static Future<BasicResponse<List<LocationItem>>> GetUnit() async {
    final response = await BaseDA.get(
        ConfigAPI.finalallunit, (json) => LocationItem.fromJsonToList(json));
    return response;
  }

  static Future<BasicResponse> validateEmail(String email) async {
    final response = await BaseDA.post(
        '${ConfigAPI.urlValidateEmail}',
        [
          {'FieldID': 'C05', 'FieldType': 'STR', 'Value': email}
        ],
        (json) => BasicResponse.fromJson(json));
    return response;
  }

  // static Future<BasicResponse<PaymentResponse>> getPaymentDetail(
  //     String auditNumber) async {
  //   final url = ConfigAPI.urlPayment
  //       .replaceAll('{SessionID}', UserService.userInfo.session);

  //   final response = await BaseDA.post(
  //       '${url}',
  //       [
  //         {'FieldID': 'C01', 'FieldType': 'STR', 'Value': auditNumber}
  //       ],
  //       (json) => PaymentResponse.fromJson(json));
  //   return response;
  // }

  // static Future<BasicResponse<ConfigSearch>> getConfigSearch() async {
  //   final url = ConfigAPI.urlConfigSearch
  //       .replaceAll('{SessionID}', UserService.userInfo.session);

  //   final response =
  //       await BaseDA.post('${url}', [], (json) => ConfigSearch.fromJson(json));
  //   if (response.code == 200) {
  //     dateNumber = response.data.varValue != null
  //         ? int.parse(response.data.varValue)
  //         : 50;
  //   }
  //   return response;
  // }
}

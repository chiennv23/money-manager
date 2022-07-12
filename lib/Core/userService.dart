import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Core/storageKeys_helper.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';

class UserService {

  static void setUserToken(
    String token,
  ) {
    SharedPreferencesHelper.instance.setString(key: 'token', val: token);
  }

  // static void setUser(String codeTax, String username, String password) {
  //   SharedPreferencesHelper.instance.setString(
  //     key: 'userInfo.mst',
  //     val: codeTax,
  //   );
  //   SharedPreferencesHelper.instance.setString(
  //     key: 'userInfo.name',
  //     val: username,
  //   );
  // }

  static String get getAvtUsername {
    return SharedPreferencesHelper.instance.getString(key: 'userInfo.avatar');
  }

 static Future<void> setAvtUsername(String value) {
    return SharedPreferencesHelper.instance.setString(key: 'userInfo.avatar',val: value);
  }

  // static AccountItem getUser() {
  //   final tmp = SharedPreferencesHelper.instance.getString(key: 'UserItem');
  //   if (tmp != null) {
  //     return AccountItem.fromJson(
  //       jsonDecode(
  //         SharedPreferencesHelper.instance.getString(key: 'UserItem'),
  //       ),
  //     );
  //   } else {
  //     return AccountItem();
  //   }
  // }

  // static void setCovidResultTest({
  //   AnalysisResultItem resultItem,
  // }) {
  //   SharedPreferencesHelper.instance.setString(
  //     key: 'CovidTestResult',
  //     val: jsonEncode(resultItem ?? {}),
  //   );
  // }

  // static void setCovidScheduleTest({
  //   AnalysisScheduleItem scheduleItem,
  // }) {
  //   SharedPreferencesHelper.instance.setString(
  //     key: 'CovidTestSchedule',
  //     val: jsonEncode(scheduleItem ?? {}),
  //   );
  // }

  // static AnalysisResultItem getTestResult() {
  //   final tmp = SharedPreferencesHelper.instance.getString(
  //     key: 'CovidTestResult',
  //   );
  //   if (tmp != null) {
  //     return AnalysisResultItem.fromJson(
  //       jsonDecode(
  //         SharedPreferencesHelper.instance.getString(
  //           key: 'CovidTestResult',
  //         ),
  //       ),
  //     );
  //   } else {
  //     return AnalysisResultItem();
  //   }
  // }

  // static AnalysisScheduleItem getTestSchedule() {
  //   final tmp =
  //       SharedPreferencesHelper.instance.getString(key: 'CovidTestSchedule');
  //   if (tmp != null) {
  //     return AnalysisScheduleItem.fromJson(
  //       jsonDecode(
  //         SharedPreferencesHelper.instance.getString(key: 'CovidTestSchedule'),
  //       ),
  //     );
  //   } else {
  //     return AnalysisScheduleItem();
  //   }
  // }

  static void setCustomerID({int ID}) {
    SharedPreferencesHelper.instance.setInt(key: 'CustomerID', val: ID);
  }

  static int getCustomerID() {
    return SharedPreferencesHelper.instance.getInt(key: 'CustomerID');
  }

  static void setToken({String token, String refreshToken}) {
    SharedPreferencesHelper.instance.setString(key: 'token', val: token);
    SharedPreferencesHelper.instance.setString(
      key: 'refreshToken',
      val: refreshToken,
    );
    setTimeRefresh();
  }

  static String getToken() {
    return SharedPreferencesHelper.instance.getString(key: 'userInfo.token');
  }

  static String getRefreshToken() {
    return SharedPreferencesHelper.instance.getString(key: 'refreshToken');
  }

  static String getKeyStore() {
    return SharedPreferencesHelper.instance.getString(key: 'KeyStore');
  }

  static String getTypeLogin() {
    return SharedPreferencesHelper.instance.getString(key: 'typeLogin');
  }

  // số điện thoại kiểm tra khai báo y tế
  static void setLookupPhone(String phone) {
    SharedPreferencesHelper.instance.setString(key: 'lookupPhone', val: phone);
  }

  static String getLookupPhone() {
    return SharedPreferencesHelper.instance.getString(key: 'lookupPhone');
  }

  // tư cách đăng nhập khách hàng/nhân viên y tế
  static void setRole(int selected) {
    SharedPreferencesHelper.instance
        .setString(key: 'RolePlay', val: selected == 2 ? 'staff' : 'customer');
  }

  static String getRole() {
    return SharedPreferencesHelper.instance.getString(key: 'RolePlay');
  }

  // số điện thoại đăng nhập
  static void setPhone(String phone) {
    SharedPreferencesHelper.instance.setString(key: 'phone', val: phone);
  }

  static String getPhone() {
    return SharedPreferencesHelper.instance.getString(key: 'phone');
  }

  // permission location
  static void setPermissionLocation(bool check) {
    SharedPreferencesHelper.instance
        .setBool(key: 'permissionLocation', val: check);
  }

  static bool getPermissionLocation() {
    return SharedPreferencesHelper.instance.getBool(key: 'permissionLocation');
  }

  // email đăng nhập
  static void setEmail(String email) {
    SharedPreferencesHelper.instance.setString(key: 'email', val: email);
  }

  static String getEmail() {
    return SharedPreferencesHelper.instance.getString(key: 'email');
  }

  // thời gian refresh token
  static void setTimeRefresh() {
    var now = DateTime.now();
    now = now.add(Duration(minutes: 9));
    SharedPreferencesHelper.instance.setInt(
      key: 'timeRefresh',
      val: now.totalSeconds(),
    );
  }

  static int getTimeRefresh() {
    return SharedPreferencesHelper.instance.getInt(key: 'timeRefresh');
  }

  // header của request socket
  // static Map<String, String> headerSocket() {
  //   final timeRefresh = getTimeRefresh() ?? 0;
  //   final now = DateTime.now().totalSeconds();
  //   if (timeRefresh != 0 && timeRefresh <= now) {
  //     AccountDA.refreshToken();
  //     return {
  //       'token': getToken(),
  //       'refreshToken': getRefreshToken(),
  //       'Content-Type': 'application/json'
  //     };
  //   } else {
  //     return {
  //       'token': getToken(),
  //       'Content-Type': 'application/json',
  //     };
  //   }
  // }

  /// hearder of refresh token socket
  static Map<String, String> headerRefreshSocket() {
    getToken();
    return {
      'refreshToken': getRefreshToken(),
      'Content-Type': 'application/json'
    };
  }
}

class UserTokenItem {
  String token;
  String refreshtoken;

  UserTokenItem({this.token, this.refreshtoken});

  UserTokenItem.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshtoken = json['refreshtoken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['refreshtoken'] = refreshtoken;
    return data;
  }
}

class UserInfo2 {
  String codeTax;
  String username;
  String password;
}

import 'dart:math';
import 'package:coresystem/Components/base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:coresystem/Utils/AppUtils.dart';

class AppUtils {
  static const int km = 10000;
  static const int kmUse = 5000;
  static const int timeKm = 5;

  static showMBS(
    BuildContext context, {
    double height,
    Widget leading,
    String title,
    List<Widget> actions,
    Widget body,
  }) {
    showModalBottomSheet(
      elevation: 0,
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => Container(
        height: height,
        child: Scaffold(
          backgroundColor: FColors.transparent,
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            backgroundColor: FColors.grey1,
            centerTitle: true,
            toolbarHeight: 48,
            elevation: 0,
            // leading: Container(
            //   child: FIconButton(
            //     size: FButtonSize.size48,
            //     backgroundColor: FColors.transparent,
            //     child: FIcon(icon: FOutlined.close),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            title: Text(
              title,
              style: FTextStyle.semibold16_24.copyWith(color: FColors.grey10),
            ),
            actions: actions,
          ),
          body: body,
        ),
      ),
    );
  }

  // static Future<String> getDeviceId() async {
  //   if (_deviceId != null) {
  //     return _deviceId;
  //   }
  //   final deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     final iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor ??
  //         'undefined'; // unique ID on iOS
  //   } else {
  //     final androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId ?? 'undefined'; // unique ID on Android
  //   }
  // }

  //km
  static double rangeMap(double la1, double lo1, double la2, double lo2) {
    double dLat = (la1 - la2) * (pi / 180);
    double dLon = (lo1 - lo2) * (pi / 180);
    double la1ToRad = la1 * (pi / 180);
    double la2ToRad = la2 * (pi / 180);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(la1ToRad) * cos(la2ToRad) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double d = 6371000 * c;
    return d / 1000; //km
  }

  // static String rangeToTime(double km) {
  //   return (timeKm * km).wToMoney(0);
  // }

  // static Future<PackageInfo> getPackageInfo() async {
  //   if (_info != null) {
  //     return _info;
  //   }
  //   final info = await PackageInfo.fromPlatform();
  //   return info;
  // }

  // static String dateReturn(double date) {
  //   var d = date - DateTime.now().totalSeconds();
  //   if (d < 86400)
  //     return (d / 3600).floor().toString() + " giờ nữa - Đơn vị:";
  //   else
  //     return (d / 86400).floor().toString() + " ngày nữa - Đơn vị:";
  // }

  static void console(dynamic log) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(log);
    }
  }

  static void error(dynamic log) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(log);
    }
  }

  static const ENVIRONMENT =
      String.fromEnvironment('Environment', defaultValue: 'development');

  static checkMaxNumDouble(List<dynamic> list) {
    if (list != null && list.isNotEmpty) {
      return list.map<double>((e) => e.total).reduce(max);
    }
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild.context.widget is! EditableText);
  }
}

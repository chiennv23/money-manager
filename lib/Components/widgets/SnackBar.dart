import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../base_component.dart';

class WSnackBar {
  Duration duration;
  Color backgroundColor;
  FIcon icon;
  Function onTap;
  Widget action;
  Widget message;
  double borderRadius;

  EdgeInsets margin;

  WSnackBar({
    this.duration,
    this.backgroundColor,
    this.icon,
    this.onTap,
    this.action,
    this.message,
    this.borderRadius,
    this.margin,
  });
}

Material coreUISnackBar(WSnackBar snackBar) {
  return Material(
    color: FColors.transparent,
    child: Container(
      height: 48,
      margin: snackBar.margin ??
          EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      decoration: BoxDecoration(
          color: snackBar.backgroundColor,
          borderRadius: BorderRadius.circular(snackBar.borderRadius ?? 8.0)),
      child: Center(
        child: ListTile(
          minVerticalPadding: 0.0,
          minLeadingWidth: 0.0,
          horizontalTitleGap: 13.0,
          leading: snackBar.icon,
          title: snackBar.message,
          onTap: snackBar.onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(snackBar.borderRadius ?? 8.0),
          ),
          trailing: snackBar.action,
          dense: true,
        ),
      ),
    ),
  );
}

BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;
Duration animatedDurationDefault = Duration(milliseconds: 850);
Duration durationDefault = Duration(milliseconds: 2500);

void wSnackBarInTop(WSnackBar snackBar) => BotToast.showCustomNotification(
    animationDuration: animatedDurationDefault,
    animationReverseDuration: animatedDurationDefault,
    duration: snackBar.duration ?? durationDefault,
    backButtonBehavior: backButtonBehavior,
    toastBuilder: (cancel) {
      return coreUISnackBar(snackBar);
    },
    enableSlideOff: false,
    onlyOne: false,
    crossPage: false);

void wSnackBarInBottom(WSnackBar snackBar) => BotToast.showCustomText(
      animationDuration: animatedDurationDefault,
      animationReverseDuration: animatedDurationDefault,
      duration: snackBar.duration ?? durationDefault,
      backButtonBehavior: backButtonBehavior,
      toastBuilder: (cancel) {
        return coreUISnackBar(snackBar);
      },
      align: Alignment(-1.0, 0.90),
    );

Future<void> wCustomSnackBar({
  @required String title,
  String icon,
  Color backColor,
  Color iconColor,
  VoidCallback onTap,
  Duration duration,
  bool isBottom = false,
  Widget action,
  double radius,
}) async {
  isBottom
      ? wSnackBarInBottom(
          WSnackBar(
            duration: duration,
            backgroundColor: backColor,
            borderRadius: radius,
            onTap: onTap,
            icon: icon == null
                ? null
                : FIcon(
                    icon: icon,
                    size: 24,
                    color: iconColor,
                  ),
            message: Text(
              title,
              style: TextStyle(
                color: FColors.grey1,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            action: action,
          ),
        )
      : wSnackBarInTop(
          WSnackBar(
            duration: duration,
            backgroundColor: backColor,
            borderRadius: radius,
            onTap: onTap,
            icon: icon == null
                ? null
                : FIcon(
                    icon: icon,
                    size: 24,
                    color: iconColor,
                  ),
            message: Text(
              title,
              style: TextStyle(
                color: FColors.grey1,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            action: action,
          ),
        );
}

class SnackBarCore {
  static Future<void> internet(
      {String title = 'Không thấy kết nối mạng, vui lòng thử lại',
      VoidCallback onTap,
      bool isBottom = false,
      Widget action}) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColors.red6,
        icon: FOutlined.thunderbolt,
        iconColor: FColors.grey1,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> customSnackBar(
      {String title = 'Custom messenger',
      VoidCallback onTap,
      bool isBottom = false,
      Color backColor,
      Color iconColor,
      String icon,
      Widget action}) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: backColor,
        icon: icon,
        iconColor: iconColor,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> info(
      {String title = 'Info message',
      VoidCallback onTap,
      bool isBottom = false,
      Widget action}) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColors.blue6,
        icon: FFilled.info_circle,
        iconColor: FColors.grey1,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> success(
      {String title = 'Thành công',
      VoidCallback onTap,
      String iconSnackBar = FFilled.check_circle,
      bool isBottom = true,
      Widget action}) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColors.green6,
        icon: iconSnackBar,
        iconColor: FColors.grey1,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> fail(
      {String title = 'Thất bại',
      VoidCallback onTap,
      String iconSnackBar = FFilled.close_circle,
      Color colorSnackBar = FColors.red6,
      bool isBottom = false,
      Widget action}) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: colorSnackBar,
        icon: iconSnackBar,
        iconColor: FColors.grey1,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> warning(
      {String title = 'Cảnh báo có lỗi',
      VoidCallback onTap,
      bool isBottom = false,
      Widget action}) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColors.orange6,
        icon: FOutlined.warning,
        iconColor: FColors.grey1,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> copyContent(
      {@required String content,
      String title = 'Đã sao chép',
      VoidCallback onTap,
      bool isBottom = false,
      Widget action}) async {
    await FlutterClipboard.copy(content);
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColors.green6,
        icon: FFilled.check_circle,
        iconColor: FColors.grey1,
        isBottom: isBottom,
        action: action);
  }
}

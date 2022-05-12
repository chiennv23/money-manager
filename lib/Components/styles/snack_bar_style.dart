import 'package:flutter/material.dart';

import 'color.dart';
import 'icon_data.dart';

class FSnackBarStatus {
  const FSnackBarStatus({
    @required this.primaryColor,
    @required this.secondaryColor,
    @required this.icon,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final String icon;

  static const normal = FSnackBarStatus(
    primaryColor: FColors.grey9,
    secondaryColor: FColors.grey1,
    icon: FFilled.info_circle,
  );
  static const infor = FSnackBarStatus(
    primaryColor: FColors.blue6,
    secondaryColor: FColors.grey1,
    icon: FFilled.info_circle,
  );
  static const warning = FSnackBarStatus(
    primaryColor: FColors.orange6,
    secondaryColor: FColors.grey1,
    icon: FFilled.warning,
  );
  static const error = FSnackBarStatus(
    primaryColor: FColors.red6,
    secondaryColor: FColors.grey1,
    icon: FFilled.close_circle,
  );
  static const success = FSnackBarStatus(
    primaryColor: FColors.green6,
    secondaryColor: FColors.grey1,
    icon: FFilled.check_circle,
  );
}

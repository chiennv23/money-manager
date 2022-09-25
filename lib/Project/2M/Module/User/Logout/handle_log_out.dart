import 'dart:async';
import 'package:coresystem/Core/CacheService.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dialog_log_out.dart';

class PickerLogoutHandler {
  PickerLogoutDialog PickerAction;
  final AnimationController _controller;

  PickerLogoutHandler(
    this._controller,
  );

  Future LogoutAction() async {
    // PickerAction.dismissDialog();

  }

  void init() {
    PickerAction = PickerLogoutDialog(this, _controller);
    PickerAction.initState();
  }

  void showDialog(BuildContext context) {
    PickerAction.getDialog(context);
  }
}

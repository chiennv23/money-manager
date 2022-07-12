import 'dart:async';
import 'package:coresystem/Core/routes.dart';
import 'package:flutter/material.dart';

import 'dialog_log_out.dart';

class PickerLogoutHandler {
  PickerLogoutDialog PickerAction;
  final AnimationController _controller;

  PickerLogoutHandler(
    this._controller,
  );

  Future LogoutAction() {
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

import 'dart:async';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/typo_skin.dart';
import 'package:coresystem/Project/2M/Module/User/DA/UserDA.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'handle_log_out.dart';

// ignore: must_be_immutable
class PickerLogoutDialog extends StatelessWidget {
  final PickerLogoutHandler _listener;
  final AnimationController _controller;
  BuildContext context;

  PickerLogoutDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  void getDialog(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => SlideTransition(
        position: _drawerDetailsPosition,
        child: FadeTransition(
          opacity: ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  Future<Timer> startTime() async {
    final _duration = Duration(milliseconds: 200);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  void dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Material(
      color: FColors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FColorSkin.grey1_background,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                    ),
                    child: Center(
                      child: Text(
                        'Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng?',
                        style: FTypoSkin.title6
                            .copyWith(color: FColorSkin.secondaryText),
                      ),
                    ),
                  ),
                  Divider(
                    color: FColorSkin.grey3_background,
                    height: 0.0,
                    thickness: 1.0,
                  ),
                  roundedButton('Đăng xuất ngay',
                      radius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0)),
                      titleColor: FColorSkin.errorPrimary, onTap: () async {
                    // await UserDA.logout();
                    // context
                    //     .read<TransactionBloc>()
                    //     .add(TransactionReloadEvent());
                    // context.read<CommissionBloc>().add(CommissionReloadEvent());
                    await _listener.LogoutAction();
                  }),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            roundedButton(
              'Ở lại',
              radius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              titleColor: FColorSkin.infoPrimary,
              onTap: dismissDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget roundedButton(String buttonLabel,
      {BorderRadius radius, Function onTap, Color titleColor = FColors.blue6}) {
    final loginBtn = Material(
      color: FColors.grey1,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: 48,
          padding: EdgeInsets.all(10.0),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: <BoxShadow>[FElevation.elevation2],
          ),
          child: Text(
            buttonLabel,
            style: FTypoSkin.title4.copyWith(color: titleColor),
          ),
        ),
      ),
    );
    return loginBtn;
  }
}

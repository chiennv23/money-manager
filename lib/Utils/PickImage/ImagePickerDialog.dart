import 'dart:async';
import 'package:coresystem/Components/base_component.dart';
import 'package:flutter/material.dart';

import 'imagePickerHandler.dart';

class ImagePickerDialog extends StatelessWidget {
  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

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

  getImage(BuildContext context) {
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

  startTime() async {
    var _duration = Duration(milliseconds: 200);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
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
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FColors.grey1,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
              ),
              child: Text(
                'Lựa chọn thao tác',
                style: FTextStyle.regular14_22.copyWith(color: FColors.grey5),
              ),
            ),
            roundedButton(
              'Chọn ảnh từ thư viện',
              onTap: () => _listener.openGallery(),
            ),
            roundedButton(
              'Chụp ảnh',
              radius: BorderRadius.only(
                bottomRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              onTap: () => _listener.openCamera(),
            ),
            const SizedBox(height: 15.0),
            roundedButton(
              'Huỷ',
              radius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              onTap: dismissDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget roundedButton(String buttonLabel,
      {BorderRadius radius, Function onTap}) {
    var loginBtn = Material(
      color: FColors.grey1,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: 48,
          padding: EdgeInsets.all(15.0),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: FColors.grey1,
            boxShadow: <BoxShadow>[FElevation.elevation2],
          ),
          child: Text(
            buttonLabel,
            style: TextStyle(
                color: FColors.blue6,
                fontSize: 14.0,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
    return loginBtn;
  }
}

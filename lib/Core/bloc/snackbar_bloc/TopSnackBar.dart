import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../ScreenUtils.dart';
import 'SnackBarBloc.dart';
import 'TopSnackBarRoute.dart';

typedef TopSnackBarStatusCallBack = void Function(TopSnackBarStatus status);

const String topSnackBarRouteName = '/topSnackBarRoute';

// ignore: must_be_immutable
class TopSnackBar<T extends Object> extends StatefulWidget {
  final BuildContext context;
  final String title;
  final SnackBarType type;
  TopSnackBarStatusCallBack onStatusChanged;

  TopSnackBar(
      {Key key, this.context, this.title, this.type = SnackBarType.error})
      : super(key: key) {
    onStatusChanged = onStatusChanged ?? (status) {};
  }

  int duration = 4;

  TopSnackBarRoute<T> _topSnackBarRoute;

  Future<T> show(BuildContext context) async {
    _topSnackBarRoute = showSnackBar<T>(context: context, topSnackBar: this);

    return Navigator.of(context, rootNavigator: false).push(_topSnackBarRoute);
  }

  Future<T> showWithNavigator(
      NavigatorState navigator, BuildContext context) async {
    _topSnackBarRoute = showSnackBar<T>(context: context, topSnackBar: this);
    return navigator.push(_topSnackBarRoute);
  }

  Future<T> dismiss([T result]) async {
    if (_topSnackBarRoute == null) {
      return null;
    }

    return null;
  }

  /// Checks if the top snack bar is visible
  bool isShowing() =>
      _topSnackBarRoute?.currentStatus == TopSnackBarStatus.showing;

  /// Checks if the top snack bar is dismissed
  bool isDismissed() =>
      _topSnackBarRoute?.currentStatus == TopSnackBarStatus.dismissed;

  @override
  State createState() {
    return _TopSnackBarState<T>();
  }
}

class _TopSnackBarState<K extends Object> extends State<TopSnackBar>
    with TickerProviderStateMixin {
  FocusScopeNode _focusScopeNode;
  FocusAttachment _focusAttachment;

  TopSnackBarStatus currentStatus;

  GlobalKey backgroundBoxKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _focusScopeNode = FocusScopeNode();
    _focusAttachment = _focusScopeNode.attach(context);
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _focusAttachment.detach();
    super.dispose();
  }

  Widget _buildIcon() {
    if (widget.type == SnackBarType.success) {
      return Container(
          key: const Key('success_container_icon_key'),
          child: Icon(Icons.check));
    } else {
      return Container(
          key: const Key('close_container_icon_key'), child: Icon(Icons.error));
    }
  }

  Widget _buildTitleText() {
    return Text(
      widget.title ?? '',
      maxLines: 2,
      key: const ValueKey('snackbar_title_key'),
      style: Theme.of(context).snackBarTheme.contentTextStyle,
    );
  }

  List<Widget> _buildRowLayout() {
    return <Widget>[
      ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 41.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: _buildIcon(),
          )),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(
              left: 16.0, right: 0.0, top: 0.0, bottom: 0.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 4.0, right: 8.0),
            child: _buildTitleText(),
          ),
        ),
      )
    ];
  }

  BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25.0),
      boxShadow: [
        BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.5, 0.5))
      ]);

  Widget _buildSnackBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            key: backgroundBoxKey,
            decoration: boxDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: _buildRowLayout(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 20),
      child: Material(type: MaterialType.transparency, child: _buildSnackBar()),
    );
  }
}

enum TopSnackBarStatus { showing, dismissed, isHiding, isAppearing }

/// Indicates if snack bar is going to start at the [top]
enum TopSnackBarPosition { top }

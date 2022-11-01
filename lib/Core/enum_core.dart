import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Core/storageKeys_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Components/widgets/SnackBar.dart';
import '../main.dart';

class EnumCore {
  static CancelFunc loadingCustom(Future a) => BotToast.showCustomLoading(
      clickClose: false,
      // duration: Duration(milliseconds: 10000),
      toastBuilder: (void Function() cancelFunc) {
        a.then((value) => cancelFunc.call());
        return LoadingCustom();
      });
}

String langApp = 'en';


Future loadingEN(BuildContext context) async {
  if (SharedPreferencesHelper.instance.getString(key: 'languageApp') == 'en') {
    await SnackBarCore.info(title: 'You are already in english?!');
  } else {
    await MyApp.setLocale(context, Locale('en'));
    await SharedPreferencesHelper.instance
        .setString(key: 'languageApp', val: 'en');
    langApp = 'en';

    // RestartWidget.restartApp(context);
    await Future.delayed(Duration(milliseconds: 500));
  }
}

Future loadingVI(BuildContext context) async {
  if (SharedPreferencesHelper.instance.getString(key: 'languageApp') == 'vi') {
    await SnackBarCore.info(title: 'Bạn đang ở ngôn ngữ tiếng việt?!');
  } else {
    await MyApp.setLocale(context, Locale('vi'));
    await SharedPreferencesHelper.instance
        .setString(key: 'languageApp', val: 'vi');
    langApp = 'vi';
    // RestartWidget.restartApp(context);
    await Future.delayed(Duration(milliseconds: 500));
  }
}
class LoadingCustom extends StatefulWidget {
  const LoadingCustom({Key key}) : super(key: key);

  @override
  _LoadingCustomState createState() => _LoadingCustomState();
}

class _LoadingCustomState extends State<LoadingCustom>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double x = 85;
    double y = 45.0;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(2 * 3.14 * _animation.value),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SpinKitRipple(
                    color: FColors.grey1,
                    size: x,
                    borderWidth: 20.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

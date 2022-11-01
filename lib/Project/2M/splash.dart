import 'dart:async';

import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/Module/Introduction/introduction.dart';
import 'package:coresystem/Project/2M/Module/TabIndex/Index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Core/storageKeys_helper.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isfirst;

  @override
  void initState() {
    _isfirst =
        SharedPreferencesHelper.instance.getBool(key: 'first_run') ?? true;
    initView();
    super.initState();
  }

  void deleteAllDataFirstInstall() {
    if (_isfirst) {
      print('first run app......');
      StorageHelper.instance.deleteAll();

      SharedPreferencesHelper.instance.setBool(key: 'first_run', val: false);
    }
  }

  void initView() {
    Timer(Duration(milliseconds: 2800), () async {
      // if (kReleaseMode) {
      if (_isfirst) {
        deleteAllDataFirstInstall();
        await CoreRoutes.instance.navigateAndRemoveFade(IntroduceApp());
      } else {
        await CoreRoutes.instance.navigateAndRemoveFade(PageIndex());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'lib/Assets/IconApp/processing.json',
          ),
          Text(
            'Monage',
            style: FTypoSkin.title1.copyWith(color: FColorSkin.title),
          ),
          Text(
            'Money Note',
            style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
          ),
        ],
      )),
    );
  }
}

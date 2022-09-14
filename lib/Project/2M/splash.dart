import 'dart:async';

import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/Contains/constants.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/2M/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/2M/Module/Introduction/introduction.dart';
import 'package:coresystem/Project/2M/Module/TabIndex/Index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  void initView() {
    Timer(Duration(milliseconds: 2360), () async {
      if (kReleaseMode) {
        await CoreRoutes.instance.navigateAndRemoveFade(PageIndex());
      } else {
        // await CoreRoutes.instance.navigateAndRemoveFade(IntroduceApp());
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
          Lottie.asset('lib/Assets/IconApp/processing.json', onLoaded: (vl) {
            initView();
          }),
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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(StringImage.on_boarding),
      ),
    );
  }
}

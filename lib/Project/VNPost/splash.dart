import 'dart:async';

import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/color_skin.dart';
import 'package:coresystem/Project/VNPost/Module/TabIndex/Index.dart';
import 'package:coresystem/Project/VNPost/Module/User/DA/UserDA.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Core/userService.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // final user = UserService.getwelcome();

  @override
  void initState() {
    // Timer(Duration(milliseconds: 1000), () {
    //   UserService.getwelcome();
    //   if (UserService.userInfo != null &&
    //       UserService.userInfo.username != null) {
    //     CoreRoutes.instance.navigateAndRemoveFade(HomeIndex());
    //   } else {
    //     CoreRoutes.instance.navigateAndRemoveFade(Login());
    //   }
    // });
    // UserService.getwelcome();

    initView();
    // getData();
    super.initState();
  }

  void initView() {
    Timer(Duration(milliseconds: 1000), () async {
      if (kReleaseMode) {
        await CoreRoutes.instance.navigateAndRemoveFade(Login(
          type: 0,
        ));
      } else {
        // Will be tree-shaked on release builds.
        if (UserService.userInfo != null &&
            UserService.userInfo.token != null) {
          // await getAccountDetail();
          await CoreRoutes.instance.navigateAndRemoveFade(PageIndex());
        } else {
          await CoreRoutes.instance.navigateAndRemoveFade(Login(
            type: 0,
          ));
        }
      }
    });
  }

  // Future<void> getAccountDetail() async {
  //   final data = await UserDA.getInfo();
  //   if (data.code == 200) {
  //     UserService.userInfo.branchName = data.data.bRANCHNAME;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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

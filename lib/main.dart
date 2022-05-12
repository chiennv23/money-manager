import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Core/storageKeys_helper.dart';
import 'package:coresystem/Core/userService.dart';
import 'package:coresystem/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  await SharedPreferencesHelper.instance.init();
  HttpOverrides.global = MyHttpOverrides();

  runZoned(() {
    runApp(
      MyApp(),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final token = UserService.getToken();

  void deleteAllDataFirstInstall() {
    if (SharedPreferencesHelper.instance.getBool(key: 'first_run') ?? true) {
      print('first run app......');
      StorageHelper.instance.deleteAll();

      SharedPreferencesHelper.instance.setBool(key: 'first_run', val: false);
    }
  }

  final botToastBuilder = BotToastInit();

  @override
  void initState() {
    // deleteAllDataFirstInstall();
    super.initState();
  }

  // final user = UserService.getToken();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      navigatorKey: CoreRoutes.instance.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute:
          token == null ? CoreRouteNames.SPLASH : CoreRouteNames.PAGE_INDEX,
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: const {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child);
      },
    );
  }
}

// class RestartWidget extends StatefulWidget {
//   RestartWidget({this.child});
//
//   final Widget child;
//
//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
//   }
//
//   @override
//   _RestartWidgetState createState() => _RestartWidgetState();
// }
//
// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();
//
//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(
//       key: key,
//       child: widget.child,
//     );
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Core/storageKeys_helper.dart';
import 'package:coresystem/Core/userService.dart';
import 'package:coresystem/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Config/AppConfig.dart';
import 'Project/2M/LocalDatabase/Models/user_info.dart';
import 'generated/l10n.dart';

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
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(UserItemAdapter());
  Hive.registerAdapter(CareerItemAdapter());
  runZoned(() {
    runApp(
      MyApp(),
    );
  });
}

class MyApp extends StatefulWidget {
  static Future<void> setLocale(BuildContext context, Locale newLocale) async {
    final state = context.findAncestorStateOfType<_MyAppState>();
    await state.changeLanguage(newLocale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale defaultLanguage;

  void takeLanguage() {
    final localeCode =
    SharedPreferencesHelper.instance.getString(key: 'languageApp');
    ConfigApp.langApp = localeCode ?? 'vi';
    defaultLanguage = Locale(localeCode ?? 'vi');
  }

  Future<void> changeLanguage(Locale locale) async {
    setState(() {
      S.load(locale);
      defaultLanguage = locale;
    });
    return;
  }

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
    deleteAllDataFirstInstall();
    takeLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      navigatorKey: CoreRoutes.instance.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute:
         CoreRouteNames.SPLASH,
      locale: defaultLanguage,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
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

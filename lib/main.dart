import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Core/storageKeys_helper.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Core/enum_core.dart';
import 'generated/l10n.dart';

String defaultImg = 'lib/Assets/Images/walletTheme.png';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await SharedPreferencesHelper.instance.init();

  // initHive
  await HiveDB().initHive();
  // get controllers
  await GetControl().startGetData();
  runZoned(() {
    runApp(
      RestartWidget(child: MyApp()),
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
    langApp = localeCode ?? 'vi';
    defaultLanguage = Locale(localeCode ?? 'vi');
  }
  Future<void> changeLanguage(Locale locale) async {
    setState(() {
      S.load(locale);
      defaultLanguage = locale;
    });
    return;
  }
  final botToastBuilder = BotToastInit();
  @override
  void initState() {
    takeLanguage();
    super.initState();
  }
  @override
  void dispose() {
    print('Dispose Hive');
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      debugShowCheckedModeBanner: false,
      navigatorKey: CoreRoutes.instance.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: CoreRouteNames.SPLASH,
      // locale: defaultLanguage,
      locale: Locale('en'),
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

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

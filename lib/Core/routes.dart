import 'package:flutter/material.dart';

class CoreRouteNames {
  // ignore: constant_identifier_names
  static const String LOGIN = '/LOGIN';
  static const String REGISTER_INFO_FORM = '/REGISTER_INFO_FORM';
  static const String SPLASH = '/SPLASH';
  static const String PAGE_INDEX = '/PAGE_INDEX';
  static const String HOME = '/HOME';
  static const String NOTIFICATION = '/NOTIFICATION';
  static const String NOTIFICATION_DETAIL = '/NOTIFICATION_DETAIL';
  static const String ACCOUNT = '/ACCOUNT';
  static const String ACCOUNT_INFO = '/ACCOUNTINFO';
}

///// Custom transition Fade navigation.
Route createFadeRouteWidget({Widget pageNavigate, int timeMilliseconds}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: timeMilliseconds),
    pageBuilder: (context, animation, secondaryAnimation) => pageNavigate,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

///// Custom transition Fade navigation.
Route createDownToUpRouteWidget({Widget pageNavigate, int timeMilliseconds}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: timeMilliseconds),
    pageBuilder: (context, animation, secondaryAnimation) => pageNavigate,
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class CoreRoutes {
  // CoreRoutes.instance + Navigator..

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory CoreRoutes() => _instance;

  CoreRoutes._internal();

  static final CoreRoutes _instance = CoreRoutes._internal();

  static CoreRoutes get instance => _instance;

  String currentRoutes = '';

  // Material RouteString
  Future<dynamic> navigateToRouteString(String routeName,
          {Object arguments}) async =>
      navigatorKey.currentState.pushNamed(routeName, arguments: arguments);

  Future<dynamic> navigateAndRemove(String routeName,
          {Object arguments}) async =>
      navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
        arguments: arguments,
      );

  Future<dynamic> navigateAndReplaceRouteString(String routeName,
          {Object arguments}) async =>
      navigatorKey.currentState
          .pushReplacementNamed(routeName, arguments: arguments);

  dynamic pop({dynamic result}) => navigatorKey.currentState.pop(result);

  dynamic popUntil({bool Function(Route) func}) =>
      navigatorKey.currentState.popUntil(func);

  // Material Routes
  Future<dynamic> navigateAndRemoveRoutes(
    route,
  ) async =>
      navigatorKey.currentState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => route),
        (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushRoutes(
    route,
  ) async =>
      navigatorKey.currentState.push(
        MaterialPageRoute(builder: (context) => route),
      );

  Future<dynamic> navigatorPushReplacementRoutes(
    route,
  ) async =>
      navigatorKey.currentState.pushReplacement(
        MaterialPageRoute(builder: (context) => route),
      );

  // Fade Routes
  Future<dynamic> navigateAndRemoveFade(route,
          {int timeMillisecond = 350}) async =>
      navigatorKey.currentState.pushAndRemoveUntil(
        createFadeRouteWidget(
            pageNavigate: route, timeMilliseconds: timeMillisecond),
        (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushFade(route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState.push(createFadeRouteWidget(
          pageNavigate: route, timeMilliseconds: timeMillisecond));

  Future<dynamic> navigatorPushReplacementFade(route,
          {int timeMillisecond = 350}) async =>
      navigatorKey.currentState.pushReplacement(createFadeRouteWidget(
          pageNavigate: route, timeMilliseconds: timeMillisecond));

  // Slide Routes
  Future<dynamic> navigateAndRemoveDownToUp(route,
          {int timeMillisecond = 350}) async =>
      navigatorKey.currentState.pushAndRemoveUntil(
        createDownToUpRouteWidget(
            pageNavigate: route, timeMilliseconds: timeMillisecond),
        (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushDownToUp(route,
          {int timeMillisecond = 350}) async =>
      navigatorKey.currentState.push(createDownToUpRouteWidget(
          pageNavigate: route, timeMilliseconds: timeMillisecond));

  Future<dynamic> navigatorPushReplacementDownToUp(route,
          {int timeMillisecond = 350}) async =>
      navigatorKey.currentState.pushReplacement(createDownToUpRouteWidget(
          pageNavigate: route, timeMilliseconds: timeMillisecond));
}

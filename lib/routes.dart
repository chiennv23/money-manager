import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/VNPost/Module/TabIndex/Index.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/account_info.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/login.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/sign_up.dart';
import 'package:coresystem/Project/VNPost/splash.dart';
import 'package:flutter/material.dart';

class Routes extends CoreRoutes {
  factory Routes() => CoreRoutes.instance;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case CoreRouteNames.PAGE_INDEX:
        return MaterialPageRoute(
          builder: (context) => PageIndex(),
        );
      case CoreRouteNames.SPLASH:
        return MaterialPageRoute(
          builder: (context) => Splash(),
        );
      case CoreRouteNames.LOGIN:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );
      case CoreRouteNames.REGISTER_INFO_FORM:
        return MaterialPageRoute(
          builder: (context) => SignUp(),
        );
      case CoreRouteNames.ACCOUNT_INFO:
        return MaterialPageRoute(
          builder: (context) => AccountInfo(),
        );

      default:
        return _emptyRoute(settings);
    }
  }

  // ignore: unused_element
  static MaterialPageRoute _emptyRoute(RouteSettings settings) =>
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Center(
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
}

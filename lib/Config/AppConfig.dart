class ConfigApp {
  static String version = '0.0.1';
  static int versionNumber = 3;
  static String langApp = 'vi';
}

class StatusApi {
  /// status code = 401
  static const token = 401;

  /// status code = 800
  static const refreshToken = 800;

  /// status code = 200
  static const complete = 200;

  /// status code = 500
  static const error = 500;

  /// status code = 402
  static const exist = 402;
}

class TypeProduct {
  static int view = 1;
  static int order = 2;
  static int comingsoom = 3;
  static int cart = 4;
}

class WMessage {
  bool isError = false;
  int id = 0;
  int code = 0;
  int type = 0;
  String message = '';

  WMessage({this.isError, this.id, this.type, this.code, this.message});
}

class WMessages {
  static List<WMessage> list = [
    WMessage(id: 1, message: "", type: 1, code: 500),
    WMessage(),
    WMessage(),
    WMessage(),
  ];

  static wAlert(WMessage obj) {
    switch (obj.type) {
      case 1:
        // do something
        break;
      case 2:
        // do something else
        break;
    }
  }
}

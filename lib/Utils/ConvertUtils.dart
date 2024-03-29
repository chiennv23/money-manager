import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';

class ImageHelper {
  static Future<Uint8List> compressImage(File image) async {
    final lst = await FlutterImageCompress.compressWithFile(
      image.absolute.path,
      minHeight: 1280,
      minWidth: 1980,
      quality: 40,
    );
    return lst;
  }
}

class WConvert {
  static DateTime dateDefault = DateTime(2019, 1, 1);

  static String hiddenString(String str) {
    final lastTwoDigits = str.substring(str.length - 4, str.length);
    return lastTwoDigits.padLeft(9, '•');
  }

  static String month(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
    }
  }

  static String money(double value, int a) {
    var ze = '.00000000000000';
    if (a < 11) {
      ze = ze.substring(0, a + 1);
    }
    if (a == 0) {
      ze = '';
    }
    final format = NumberFormat('#,###,###$ze');
    return format.format(value);
  }

  static double toDouble(dynamic unicode) {
    try {
      return unicode != null ? double.parse(unicode.toString()) : 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  static int toInt(dynamic unicode) {
    try {
      return unicode != null ? int.parse(unicode.toString()) : 0;
    } catch (e) {
      return 0;
    }
  }

  static int totalSeconds(DateTime date) {
    final diffDt = date.difference(dateDefault);
    return diffDt.inSeconds;
  }

  static int remainingTime(double dateProcessReceive, DateTime now) {
    final timeZone = dateProcessReceive.toInt().dateTime();
    final timeRemaining = timeZone.difference(now).inMinutes;
    return timeRemaining;
  }

  // ignore: missing_return
  static String moneyShort(double value) {
    final a = value.toInt();
    // ignore: unused_local_variable
    var money = '';
    if (a >= 1000000000 || a < -1000000000) {
      return money = '${a / 1000000000}B';
    }
    if (a >= 1000000 || a < -1000000) {
      return money = '${a / 1000000}M';
    }
    if (a >= 1000 || a < -1000) {
      return money = '${a / 1000}K';
    }
    // ignore: invariant_booleans
    if (a < 1000 || a < -1000) {
      return money = (a).toString();
    }
  }

  static String decimalToString(double totalSeconds, String format) {
    return totalSeconds != null
        ? DateFormat(format)
            .format(dateDefault.add(Duration(seconds: totalSeconds.round())))
        : '';
  }

  ///Bỏ khoảng trắng thừa
  static String trim(String input) {
    return input.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
  }

  static String interpolate(String string, List<dynamic> params) {
    var result = string;
    for (var i = 0; i < params.length; i++) {
      result = result.replaceAll('\$$i\$', '${params[i]}');
    }
    return result;
  }
}

extension StringExtension on String {
  String format(List<dynamic> params) => WConvert.interpolate(this, params);
}

class FDate {
  // dd/MM/yyy -> 21/09/1997
  static String dMy(dynamic date) {
    if (date == null) {
      return '';
    }
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd/MM/yyyy').format(tmp);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String hm_dMy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('hh:mm - dd/MM/yyyy').format(tmp);
    } else {
      return DateFormat('hh:mm - dd/MM/yyyy').format(date);
    }
  }

  static String dMy_hm(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd/MM/yyyy - hh:mm').format(tmp);
    } else {
      return DateFormat('dd/MM/yyyy - hh:mm').format(date);
    }
  }

  /// dd.MM.yyy -> 21.09.1997
  static String dot_dMy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd.MM.yyyy').format(tmp);
    } else {
      return DateFormat('dd.MM.yyyy').format(date);
    }
  }

  /// yyyy-MM-dd -> 1997-09-21
  static String yMd(dynamic date) {
    if (date.runtimeType == String) {
      return DateFormat('yyyy-MM-dd').format(DateTime.tryParse(date));
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  /// MM-dd-yyy -> 09-21-1997
  static String Mdy(dynamic date) {
    if (date.runtimeType == String) {
      return DateFormat('yyyy-MM-dd').format(DateTime.tryParse(date));
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  static String weekday_dMy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('EEE, dd/MM/yyyy').format(tmp);
    } else {
      return DateFormat('EEE, dd/MM/yyyy').format(date);
    }
  }

  static const Map<int, String> weekdayName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};

  static String onlyDayWeek(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('EEEE').format(tmp);
    } else {
      return DateFormat('EEEE').format(date);
    }
  }

  static String My(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('MMMM, yyyy').format(tmp);
    } else {
      return DateFormat('MMMM, yyyy').format(date);
    }
  }

  // hh:mm:ss
  static String hms(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    final second = date.second;
    return '$hour:$minute:$second';
  }

  // hh:mm:ss
  static String hm(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    return '$hour:$minute';
  }

  static String countdown(int seconds) {
    final h = (seconds / 3600).floor();
    final m = ((seconds - h * 3600) / 60).floor();
    final s = seconds - h * 3600 - m * 60;
    if (h == 0) {
      return '${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}';
    } else {
      return '${h < 10 ? '0$h' : h}:${m < 10 ? '0$m' : m}';
    }
  }
}

extension FDateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMy(DateTime other) {
    return year == other.year && month == other.month;
  }

  String format(String pattern) {
    try {
      if (this == null) {
        return '';
      }

      return DateFormat(pattern).format(this);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }

  static DateTime dateDefault = DateTime(2019, 1, 1);

  int totalSeconds() => difference(dateDefault).inSeconds;
}

extension WDoubleExtension on double {
  // a số ký tự sau dấu . String: #,###.###
  String wToMoney(int a) => NumberFormat(
          '#,###,###${this < 1 && this >= 0 ? '0' : ''}${a == 0 ? "" : '.00000000000000'.substring(0, a + 1)}')
      .format(this);

  int wDoubleToInt() => toInt();
}

extension WIntExtension on int {
  static DateTime dateDefault = DateTime(2019, 1, 1);

  DateTime dateTime() => dateDefault.add(Duration(seconds: this));

  double wIntToDouble() => toDouble();

  String dateToString(String formatDate) =>
      DateFormat(formatDate).format(dateTime());

  String wToMoney(int a) {
    if (this == null) {
      return '';
    }
    return NumberFormat(
            '#,###,###${this < 1 && this >= 0 ? '0' : ''}${a == 0 ? "" : '.00000000000000'.substring(0, a + 1)}')
        .format(this);
  }
}

extension WStringExtension on String {
  String wUnicodeToAscii() => toLowerCase()
      .replaceAll(
        RegExp(r'[đ]', caseSensitive: false),
        'd',
      )
      .replaceAll(
        RegExp(r'[í|ì|ỉ|ĩ|ị]', caseSensitive: false),
        'i',
      )
      .replaceAll(
        RegExp(r'[ý|ỳ|ỷ|ỹ|ỵ]', caseSensitive: false),
        'y',
      )
      .replaceAll(
        RegExp(r'[á|à|ả|ã|ạ|â|ă|ấ|ầ|ẩ|ẫ|ậ|ắ|ằ|ẳ|ẵ|ặ]', caseSensitive: false),
        'a',
      )
      .replaceAll(
        RegExp(r'[é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ]', caseSensitive: false),
        'e',
      )
      .replaceAll(
        RegExp(r'[ú|ù|ủ|ũ|ụ|ü|ư|ứ|ừ|ử|ữ|ự]', caseSensitive: false),
        'u',
      )
      .replaceAll(
        RegExp(r'[ó|ò|ỏ|õ|ọ|ô|ơ|ố|ồ|ổ|ỗ|ộ|ớ|ờ|ở|ỡ|ợ]', caseSensitive: false),
        'o',
      )
      .toLowerCase()
      .trim();

  String wVietNam() {
    return TiengVietCore.removeDiacritics(this);
  }
}

class TiengVietCore {
  static String removeDiacritics(String str) {
    if (str == null) {
      return '';
    }
    var withDia =
        'àáâãèéêếìíòóôõùúăđĩũơưăạảấầẩẫậắằẳẵặẹẻẽềềểễệỉịọỏốồổỗộớờởỡợụủứừửữựỳỵỷỹ';
    var withoutDia =
        'aaaaeeeeiioooouuadiuouaaaaaaaaaaaaaeeeeeeeeiioooooooooooouuuuuuuyyyy';
    var tmp = "";
    for (int i = 0; i < str.length; i++) {
      var a = str[i];
      if (a.codeUnits[0] != 768 && a.codeUnits[0] != 803) {
        tmp += a;
      }
    }
    str = tmp;
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str.toLowerCase().trim();
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat('#,###');
      final number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

extension WListExtension<T> on Iterable<T> {
  Iterable<T> filterCheckDuplicateItem([Function(T) f]) {
    List<T> filterList = [];
    if (f != null) {
      for (var e in this) {
        if (!filterList.any((item) => f(item) == f(e))) filterList.add(e);
      }
    } else
      for (var e in this) {
        if (!filterList.any((item) => item == e)) filterList.add(e);
      }
    return filterList;
  }
}

import 'package:coresystem/Components/widgets/form.dart';
import 'package:coresystem/Core/storageKeys_helper.dart';
import 'package:coresystem/Core/userService.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';

class Validate {
  ///Số lần khóa

  static bool validateCodeTax(String codeTax) {
    final codeTaxRegExp = new RegExp(r'^[0-9]{10}$|^[0-9]{10}\-[0-9]{3}$');
    if (!codeTaxRegExp.hasMatch(codeTax)) {
      return false;
    }

    int ms1 = int.parse(codeTax[0]);

    int ms2 = int.parse(codeTax[1]);
    int ms3 = int.parse(codeTax[2]);
    int ms4 = int.parse(codeTax[3]);
    int ms5 = int.parse(codeTax[4]);
    int ms6 = int.parse(codeTax[5]);
    int ms7 = int.parse(codeTax[6]);
    int ms8 = int.parse(codeTax[7]);
    int ms9 = int.parse(codeTax[8]);
    int ms10 = int.parse(codeTax[9]);

    final a = 31 * ms1 +
        29 * ms2 +
        23 * ms3 +
        19 * ms4 +
        17 * ms5 +
        13 * ms6 +
        7 * ms7 +
        5 * ms8 +
        3 * ms9;
    if (ms10 != 10 - (a % 11))
      return false;
    else
      return true;
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  // validate FormField

  /// Ma so thue
  static FTextFieldStatus CodeTaxValidator(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    } else if (!validateCodeTax(value)) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Mã số thuế không hợp lệ.');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }

  /// Email
  static FTextFieldStatus EmailValidator(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    } else if (!isValidEmail(value)) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Email không hợp lệ.');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }

  /// validation date from
  static FTextFieldStatus dateFromValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Vui lòng chọn ngày.');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }

  /// validation date too
  static FTextFieldStatus dateToValidate(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return FTextFieldStatus(
          status: TFStatus.error, message: 'Vui lòng chọn ngày.');
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }
}

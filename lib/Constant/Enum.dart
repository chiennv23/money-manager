import 'package:flutter/material.dart';

class EnumItem {
  static BuildContext context;
  static bool isLoading = false;
}

/// lựa chọn Event
class EnumEvent {
  static const registor = 1;
  static const login = 2;
  static const signup_phoneNumber = 99;
  static const login_otp = 3;
  static const resend_otp = 98;
  static const resend_otp_email = 97;
  static const log_out = 100;
  static const edit_user_info = 111;

  // static const updateAcount = 3;
  static const add = 4;
  static const edit = 5;
  static const delete = 6;
  static const init = 7;
  static const lookup_info = 8;
  static const lookup_info_otp = 9;
  static const lookup_info_resend_otp = 112;

  static const flight_future = 10;
  static const flight_started = 11;

  static const refreshToken = 12;
  static const get_data = 13;
  static const search_rule = 14;

  static const booking = 15;

  // ROLE STAFF
  static const scan_qr = 11;
  static const get_by_id = 70;
  static const submit_user_info = 12;

  static const showPopup=1;
}

/// lựa chọn Module
class EnumObj {
  static const customer = 1;
  static const staff = 2;
  static const noti = 2;
  static const map = 3;
  static const portal_medical = 4;
  static const medical_lookup = 5;
  static const flight_condition = 6;
  static const flight = 7;
  static const test_schedule = 8;
  static const ariport = 8;

  static const analysis = 9;
  static const lab = 10;
}

class TypeLogin {
  static const phone = 'phone';
  static const email = 'email';
}

class ArilinesName {
  static const VN = 'Vietnam Airlines';
  static const HQ = 'Bamboo airways';
  static const VJ = 'Viet';
}

class CityCode {
  static const HAN = 'TP.Hà Nội';
  static const SGN = 'TP.Hồ Chí Minh';
}

class TestStatus {
  /// Đã có kết quả âm tính
  static const haveResult = 0;

  /// Đã có kết quả âm tính
  static const cant_Flight = 4;

  /// Đang có lịch xét nghiệm
  static const haveSchedule = 1;

  /// Đang chờ kết quả xét nghiệm
  static const waitingResult = 2;

  /// Chưa có kết quả âm tính
  static const haventResult = 3;
}

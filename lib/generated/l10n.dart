// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `i'm Chien pro vip`
  String get welcome {
    return Intl.message(
      'i\'m Chien pro vip',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an iACV account yet ? Sign up`
  String get check_signup {
    return Intl.message(
      'Don\'t have an iACV account yet ? Sign up',
      name: 'check_signup',
      desc: '',
      args: [],
    );
  }

  /// `Or sign in with`
  String get check_signup2 {
    return Intl.message(
      'Or sign in with',
      name: 'check_signup2',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account ?`
  String get check_signup3 {
    return Intl.message(
      'Don\'t have account ?',
      name: 'check_signup3',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number !`
  String get validator_phone {
    return Intl.message(
      'Please enter your phone number !',
      name: 'validator_phone',
      desc: '',
      args: [],
    );
  }

  /// `You have entered a missing number ! Please try again`
  String get validator_missingPhone {
    return Intl.message(
      'You have entered a missing number ! Please try again',
      name: 'validator_missingPhone',
      desc: '',
      args: [],
    );
  }

  /// `You have entered too many numbers ! Please try again`
  String get validator_manyPhone {
    return Intl.message(
      'You have entered too many numbers ! Please try again',
      name: 'validator_manyPhone',
      desc: '',
      args: [],
    );
  }

  /// `Email account`
  String get email_account {
    return Intl.message(
      'Email account',
      name: 'email_account',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Email to continue`
  String get validator_email {
    return Intl.message(
      'Please enter your Email to continue',
      name: 'validator_email',
      desc: '',
      args: [],
    );
  }

  /// `You have entered the wrong email format ! Please try again`
  String get validator_noFormatEmail {
    return Intl.message(
      'You have entered the wrong email format ! Please try again',
      name: 'validator_noFormatEmail',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the registered phone number iACV \nto sign in to the system.`
  String get note_sign_in {
    return Intl.message(
      'Please enter the registered phone number iACV \nto sign in to the system.',
      name: 'note_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Register an account`
  String get signup_an_account {
    return Intl.message(
      'Register an account',
      name: 'signup_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get note_sign_up {
    return Intl.message(
      'Please enter your phone number',
      name: 'note_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with phone`
  String get signup_with_phone {
    return Intl.message(
      'Sign up with phone',
      name: 'signup_with_phone',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Email`
  String get signup_with_email {
    return Intl.message(
      'Sign up with Email',
      name: 'signup_with_email',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to iACV, \nplease provide information \nto complete registration`
  String get welcome_register_title {
    return Intl.message(
      'Welcome to iACV, \nplease provide information \nto complete registration',
      name: 'welcome_register_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter personal information manually or \nscan CMND/CCCD/Passport`
  String get welcome_register_subTitle {
    return Intl.message(
      'Enter personal information manually or \nscan CMND/CCCD/Passport',
      name: 'welcome_register_subTitle',
      desc: '',
      args: [],
    );
  }

  /// `Nhập thông tin thủ công`
  String get welcome_register_btnTyping {
    return Intl.message(
      'Nhập thông tin thủ công',
      name: 'welcome_register_btnTyping',
      desc: '',
      args: [],
    );
  }

  /// `Scan CMND/CCCD`
  String get welcome_register_btnScan {
    return Intl.message(
      'Scan CMND/CCCD',
      name: 'welcome_register_btnScan',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Flight medical lookup`
  String get medical_lookup {
    return Intl.message(
      'Flight medical lookup',
      name: 'medical_lookup',
      desc: '',
      args: [],
    );
  }

  /// `Allow location access when using the app`
  String get permission_title_map {
    return Intl.message(
      'Allow location access when using the app',
      name: 'permission_title_map',
      desc: '',
      args: [],
    );
  }

  /// `Allows us to use your location to recommend more accurate airport and \nlaboratory options.`
  String get permission_subTitle_map {
    return Intl.message(
      'Allows us to use your location to recommend more accurate airport and \nlaboratory options.',
      name: 'permission_subTitle_map',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Flight itinerary`
  String get flight_itinerary {
    return Intl.message(
      'Flight itinerary',
      name: 'flight_itinerary',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Policy lookup`
  String get policy_lookup {
    return Intl.message(
      'Policy lookup',
      name: 'policy_lookup',
      desc: '',
      args: [],
    );
  }

  /// `Medical requirements vary by airport policy. Knowing the policy will help you qualify to fly.`
  String get note_in_medical_lookup {
    return Intl.message(
      'Medical requirements vary by airport policy. Knowing the policy will help you qualify to fly.',
      name: 'note_in_medical_lookup',
      desc: '',
      args: [],
    );
  }

  /// `Choose Address`
  String get choose_address {
    return Intl.message(
      'Choose Address',
      name: 'choose_address',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Điều kiện y tế tại điểm đi`
  String get medical_conditions_from {
    return Intl.message(
      'Điều kiện y tế tại điểm đi',
      name: 'medical_conditions_from',
      desc: '',
      args: [],
    );
  }

  /// `Điều kiện y tế tại điểm đến`
  String get medical_conditions_to {
    return Intl.message(
      'Điều kiện y tế tại điểm đến',
      name: 'medical_conditions_to',
      desc: '',
      args: [],
    );
  }

  /// `Tiêm Vắc-xin 2 mũi`
  String get done_vaccine_2 {
    return Intl.message(
      'Tiêm Vắc-xin 2 mũi',
      name: 'done_vaccine_2',
      desc: '',
      args: [],
    );
  }

  /// `Xét nghiệm âm tính Covid-19`
  String get done_test_covid19 {
    return Intl.message(
      'Xét nghiệm âm tính Covid-19',
      name: 'done_test_covid19',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã đạt đủ điều kiện y tế`
  String get done_medical_conditions {
    return Intl.message(
      'Bạn đã đạt đủ điều kiện y tế',
      name: 'done_medical_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa đạt đủ điều kiện y tế`
  String get notDone_medical_conditions {
    return Intl.message(
      'Bạn chưa đạt đủ điều kiện y tế',
      name: 'notDone_medical_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Quét mã vé máy bay để đồng bộ thông tin và\nhoàn tất thủ tục bay`
  String get scan_ticket_code_for_information {
    return Intl.message(
      'Quét mã vé máy bay để đồng bộ thông tin và\nhoàn tất thủ tục bay',
      name: 'scan_ticket_code_for_information',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật kết quả xét nghiệm âm tính để đạt đủ\nđiều kiện y tế`
  String get update_results_check_covid {
    return Intl.message(
      'Cập nhật kết quả xét nghiệm âm tính để đạt đủ\nđiều kiện y tế',
      name: 'update_results_check_covid',
      desc: '',
      args: [],
    );
  }

  /// `Khai báo y tế và cập nhật kết quả xét nghiệm âm tính\nđể đạt đủ điều kiện y tế`
  String get update_health_dec_and_check_covid {
    return Intl.message(
      'Khai báo y tế và cập nhật kết quả xét nghiệm âm tính\nđể đạt đủ điều kiện y tế',
      name: 'update_health_dec_and_check_covid',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Not done`
  String get not_done {
    return Intl.message(
      'Not done',
      name: 'not_done',
      desc: '',
      args: [],
    );
  }

  /// `No require`
  String get no_require {
    return Intl.message(
      'No require',
      name: 'no_require',
      desc: '',
      args: [],
    );
  }

  /// `Kết quả xét nghiệm có hiệu lực trong vòng 72 tiếng và có thể sử dụng cho nhiều chuyến bay.`
  String get note_results_check {
    return Intl.message(
      'Kết quả xét nghiệm có hiệu lực trong vòng 72 tiếng và có thể sử dụng cho nhiều chuyến bay.',
      name: 'note_results_check',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lịch xét nghiệm`
  String get schedule_test {
    return Intl.message(
      'Đặt lịch xét nghiệm',
      name: 'schedule_test',
      desc: '',
      args: [],
    );
  }

  /// `Khai báo y tế`
  String get health_declaration {
    return Intl.message(
      'Khai báo y tế',
      name: 'health_declaration',
      desc: '',
      args: [],
    );
  }

  /// `Quét mã vé máy bay`
  String get scan_ticket_plane {
    return Intl.message(
      'Quét mã vé máy bay',
      name: 'scan_ticket_plane',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
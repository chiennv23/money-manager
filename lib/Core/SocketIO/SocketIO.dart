// import 'dart:async';

// import 'package:coresystem/Components/widgets/SnackBar.dart';
// import 'package:coresystem/Config/AppConfig.dart';
// import 'package:coresystem/Constant/Enum.dart';
// import 'package:coresystem/Core/ConfigAPI.dart';
// import 'package:coresystem/Core/routes.dart';
// import 'package:coresystem/Core/storageKeys_helper.dart';
// import 'package:coresystem/Project/iACV/Module/Account/DA/AcountDA.dart';
// import 'package:coresystem/Project/iACV/Module/Account/Event/CustomerEvent.dart';
// import 'package:coresystem/Project/iACV/Module/Account/Item/AcountItem.dart';
// import 'package:coresystem/Project/iACV/Module/Account/Login/login_masterPage.dart';
// import 'package:coresystem/Project/iACV/Module/Bloc/BlocEvent.dart';
// import 'package:coresystem/Project/iACV/Module/DayWorkInStaff/DA/day_work_DA.dart';
// import 'package:coresystem/Project/iACV/Module/DayWorkInStaff/Item/day_work_item.dart';
// import 'package:coresystem/Project/iACV/Module/Flight/DA/FlightDA.dart';
// import 'package:coresystem/Project/iACV/Module/Flight/Item/FlightItem.dart';
// import 'package:coresystem/Project/iACV/Module/Flight/View/flight_detail.dart';
// import 'package:coresystem/Project/iACV/Module/HistoryTest/DA/history_list_DA.dart';
// import 'package:coresystem/Project/iACV/Module/HistoryTest/Item/history_test_item.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/DA/FlightJourneyDA.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/DA/medical_lookup_DA.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/Item/Airport.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/Item/City.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/Item/TestModel.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/Item/medical_lookup_item.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/MedicalLookup/PortalMedical/covid_certificate.dart';
// import 'package:coresystem/Project/iACV/Module/MedicalLookup/MedicalLookup/PortalMedical/otp_portal_medical.dart';
// import 'package:coresystem/Project/iACV/Module/Scan/result_customer_info_roleStaff.dart';
// import 'package:coresystem/Project/iACV/Module/TabIndex/Index.dart';
// import 'package:coresystem/Project/iACV/Module/TestSchedule/DA/TestScheduleDA.dart';
// import 'package:coresystem/Project/iACV/Module/TestSchedule/Item/LabItem.dart';
// import 'package:coresystem/Project/iACV/Module/TestSchedule/Item/analysisResult.dart';
// import 'package:coresystem/Project/iACV/Module/TestSchedule/Item/analysisSchedule.dart';
// import 'package:coresystem/Project/iACV/Module/TestSchedule/schedule_detail.dart';
// import 'package:coresystem/Project/iACV/Module/TestSchedule/test_result_roleStaff.dart';
// import 'package:coresystem/Utils/ValidateOTP.dart';

// // ignore: library_prefixes
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../userService.dart';
// import 'SocketItem.dart';

// // STEP1:  Stream setup
// class StreamSocket {
//   factory StreamSocket() => _instance;

//   StreamSocket._internal();

//   static final StreamSocket _instance = StreamSocket._internal();

//   static StreamSocket get instance => _instance;

//   final _socketResponse = StreamController<IOItem>.broadcast();

//   void Function(IOItem) get addResponse => _socketResponse.sink.add;

//   Stream<IOItem> get getResponse => _socketResponse.stream;

//   void dispose() {
//     _socketResponse.close();
//   }
// }

// class SocketIO {
//   static IO.Socket socket = IO.io(
//     ConfigAPI.url_socketIO,
//     IO.OptionBuilder().setTransports(['websocket']).build(),
//   );

//   static void connect() {
//     onHomeData();
//   }

//   static void onHomeData() {
//     socket.onConnect((_) async {});
//     socket.on('server-log', (data) {
//       print('log - $data');
//       switch (data['Code']) {
//         case StatusApi.error:
//           print(data);
//           break;
//         case StatusApi.exist:
//           print(data);
//           break;
//         default:
//       }
//     });
//     socket.onDisconnect((_) => print('disconnect'));

//     //! SOCKET GET
//     /// function hứng sự kiện get
//     socket.on('server-get', (data) async {
//       // if (UserService.getToken() != null &&
//       //     data['headers']['token'] == UserService.getToken()) {}
//       print(data);
//       switch (data['enumObj']) {
//         case EnumObj.flight:
//           switch (data['enumEvent']) {
//             case EnumEvent.flight_future:
//               FlightDA.futureFlights = [
//                 for (var e in data['data']) FlightItem.fromJson(e)
//               ];
//               homeReload();
//               break;
//             case EnumEvent.flight_started:
//               FlightDA.startedFlights = [
//                 for (var e in data['data']) FlightItem.fromJson(e)
//               ];
//               homeReload();
//               break;
//           }
//           break;
//         case EnumObj.customer:
//           switch (data['enumEvent']) {
//             case EnumEvent.log_out:
//               if (data['Code'] != 200) {
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 await SharedPreferencesHelper.instance.clearAllKeys();
//                 FlightJourneyDA.clearData();
//                 FlightDA.clearData();
//                 await CoreRoutes.instance
//                     .navigateAndRemoveRoutes(LoginMasterPage());
//               }
//               homeReload();
//               break;
//             case EnumEvent.get_data:
//               if (data['Code'] != 200) {
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 HistoryTestDA.list = [
//                   for (var e in data['data']) HistoryTestItem.fromJson(e)
//                 ];
//               }
//               homeReload();
//               break;
//           }
//           break;
//       }
//     });

//     /// function hứng sự kiện post
//     socket.on('server-post', (data) async {
//       print(data);
//       switch (data['enumObj']) {
//         case EnumObj.customer:
//           switch (data['enumEvent']) {
//             case EnumEvent.refreshToken:
//               CustomerEvent.refreshToken(data);
//               break;

//             case EnumEvent.login:
//               CustomerEvent.login(data);
//               break;

//             case EnumEvent.signup_phoneNumber:
//               CustomerEvent.signup_phoneNumber(data);
//               break;

//             case EnumEvent.login_otp:
//               CustomerEvent.login_otp(data);
//               break;
//             case EnumEvent.resend_otp:
//               if (data['Code'] != 200) {
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 await SnackBarCore.info(
//                   title: 'OTP đã được yêu cầu gửi lại. Hãy đợi',
//                 );
//               }
//               break;
//             case EnumEvent.resend_otp_email:
//               if (data['Code'] != 200) {
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 await SnackBarCore.success(
//                     title: 'OTP đã được yêu cầu gửi lại. Hãy đợi');
//               }
//               break;

//             case EnumEvent.registor:
//               CustomerEvent.registor(data);
//               break;

//             case EnumEvent.lookup_info:
//               if (data['Code'] != 200) {
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 await CoreRoutes.instance.navigatorPushRoutes(
//                   OtpPortalMedical(
//                     numberPhone: UserService.getPhone(),
//                   ),
//                 );
//               }
//               homeReload();
//               break;
//             case EnumEvent.lookup_info_resend_otp:
//               if (data['Code'] != 200) {
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 await SnackBarCore.success(title: 'Yêu cầu gửi lại thành công');
//               }
//               homeReload();
//               break;
//             case EnumEvent.lookup_info_otp:
//               if (data['Code'] != 200) {
//                 ValidateOTP.incorrectAuthenticator();
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 MedicalLookupDA.list = [
//                   for (var e in data['data']) MedicalLookupInfoItem.fromJson(e)
//                 ];
//                 AccountDA.user.Vaccien = MedicalLookupDA.list.length;
//                 UserService.setUser(userItem: AccountDA.user);
//                 ValidateOTP.correctAuthenticator();
//                 await CoreRoutes.instance.navigatorPushRoutes(
//                   CovidCertificate(),
//                 );
//               }
//               homeReload();
//               break;
//             case EnumEvent.edit_user_info:
//               if (data['Code'] != 200) {
//                 await SnackBarCore.fail(title: '${data['Message']}');
//               } else {
//                 AccountDA.user = AccountItem.fromJson(data['data']);
//                 UserService.setUser(userItem: AccountDA.user);
//                 await CoreRoutes.instance.pop();
//                 await SnackBarCore.success(
//                     title: 'Thay đổi thông tin cá nhân thành công',
//                     isBottom: true);
//               }
//               homeReload();
//               break;
//           }
//           break;
//         case EnumObj.flight:
//           print(data);
//           switch (data['enumEvent']) {
//             case EnumEvent.add:
//               if (data['Code'] == 200) {
//                 FlightDA.listTab[FlightDA.selectTab] = FlightItem.fromJson(
//                   data['data'],
//                 );
//                 FlightDA.selectObj = FlightItem.fromJson(
//                   data['data'],
//                 );

//                 // }
//               } else {
//                 await SnackBarCore.warning(
//                     title: data['Message'], isBottom: true);
//               }
//               break;
//             case EnumEvent.delete:
//               if (data['Code'] == 200) {
//                 if (FlightDA.index == 0) {
//                   FlightDA.futureFlights
//                       .removeWhere((e) => e == FlightDA.selectObj);
//                   CoreRoutes.instance.pop();
//                   CoreRoutes.instance.pop();
//                   Timer(Duration(milliseconds: 300), () {
//                     SnackBarCore.success(
//                         title: 'Đã xoá thông tin chuyến bay', isBottom: true);
//                   });
//                 } else {
//                   FlightDA.startedFlights
//                       .removeWhere((e) => e == FlightDA.selectObj);
//                 }
//                 homeReload();
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               break;
//             case EnumEvent.edit:
//               if (data['Code'] == 200) {
//                 FlightDA.listTab[FlightDA.selectTab] = FlightItem.fromJson(
//                   data['data'],
//                 );
//                 var oldSticket = FlightDA.selectObj;
//                 FlightDA.selectObj = FlightItem.fromJson(data['data']);
//                 if (FlightDA.index == 0) {
//                   FlightDA.futureFlights.add(
//                     FlightItem.fromJson(data['data']),
//                   );
//                   if (!FlightDA.selectObj.isPass && oldSticket.isPass) {
//                     Timer(Duration(milliseconds: 500), () {
//                       StreamSocket.instance.addResponse(IOItem(
//                           data: FlightDA.selectObj,
//                           key: EnumObj.flight,
//                           event: EnumEvent.showPopup));
//                     });
//                   }
//                 } else {
//                   FlightDA.startedFlights.add(
//                     FlightItem.fromJson(data['data']),
//                   );
//                 }

//                 await SnackBarCore.success(
//                     title: 'Đã thay đổi thành công mã máy bay', isBottom: true);
//                 Timer(Duration(milliseconds: 100), () {
//                   CoreRoutes.instance.navigateAndRemoveRoutes(
//                     PageIndex(
//                       indexTab: 3,
//                       noShowPortal2nd: true,
//                     ),
//                   );
//                 });
//                 Timer(Duration(milliseconds: 100), () {
//                   CoreRoutes.instance.navigatorPushRoutes(FlightDetail(
//                     flightIt: FlightDA.selectObj,
//                   ));
//                 });
//                 homeReload();
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               break;
//           }
//           homeReload();
//           break;
//         case EnumObj.ariport:
//           switch (data['enumEvent']) {
//             case EnumEvent.get_data:
//               print(data['data']);
//               if (data['Code'] == 200) {
//                 FlightJourneyDA.listAirport = [
//                   for (var e in data['data']) Airport.fromJson(e)
//                 ];
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               homeReload();
//               break;
//             case EnumEvent.search_rule:
//               print(data['data']);
//               if (data['Code'] == 200) {
//                 FlightJourneyDA.cites = [
//                   for (var e in data['data']['Citys']) City.fromJson(e)
//                 ];
//                 FlightJourneyDA.VaccineUser = data['data']['Vaccine'];
//                 FlightJourneyDA.TestVirus = data['data']['TestVirus'] ?? false;

//                 FlightJourneyDA.testModel =
//                     TestModel.fromJson(data['data']['TestModel']);
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               homeReload();
//               break;
//           }
//           break;
//         case EnumObj.analysis:
//           switch (data['enumEvent']) {
//             case EnumEvent.get_data:
//               if (data['data']['analysisResult'] != null) {
//                 TestScheduleDA.result = AnalysisResultItem.fromJson(
//                   data['data']['analysisResult'],
//                 );
//                 UserService.setCovidResultTest(
//                   resultItem: TestScheduleDA.result,
//                 );
//               } else {
//                 TestScheduleDA.result = AnalysisResultItem.fromJson({});
//               }
//               if (data['data'] != null && data['data']['analysis'] != null) {
//                 TestScheduleDA.schedule = AnalysisScheduleItem.fromJson(
//                   data['data']['analysis'],
//                 );
//               } else {
//                 TestScheduleDA.schedule = AnalysisScheduleItem.fromJson({});
//               }

//               UserService.setCovidScheduleTest(
//                 scheduleItem: TestScheduleDA.schedule,
//               );

//               homeReload();
//               break;
//             case EnumEvent.booking:
//               if (data['Code'] == 200) {
//                 TestScheduleDA.schedule = AnalysisScheduleItem.fromJson(
//                   data['data'],
//                 );
//                 UserService.setCovidScheduleTest(
//                   scheduleItem: TestScheduleDA.schedule,
//                 );
//                 await CoreRoutes.instance.navigatorPushRoutes(ScheduleDetail(
//                   backCondition: true,
//                   warning: 'Đặt lịch xét nghiệm thành công',
//                 ));
//               } else {
//                 await SnackBarCore.fail(title: data['Message'], isBottom: true);
//               }
//               homeReload();
//               break;
//             case EnumEvent.delete:
//               if (data['Code'] == 200) {
//                 CoreRoutes.instance.pop();
//                 CoreRoutes.instance.pop();
//                 await SnackBarCore.success(
//                     title: 'Bạn đã hủy lịch xét nghiệm', isBottom: true);
//                 Timer(Duration(milliseconds: 500), () {
//                   TestScheduleDA.schedule = AnalysisScheduleItem();
//                   UserService.setCovidScheduleTest(
//                     scheduleItem: TestScheduleDA.schedule,
//                   );
//                 });
//               } else {
//                 await SnackBarCore.fail(title: data['Message']);
//               }
//               // homeReload();
//               break;
//           }
//           break;
//         case EnumObj.lab:
//           switch (data['enumEvent']) {
//             case EnumEvent.get_data:
//               if (data['data'] != null) {
//                 TestScheduleDA.labAddress = [
//                   for (var e in data['data']) LabItem.fromJson(e)
//                 ];
//               }
//               homeReload();
//               break;
//           }
//           break;
//         ////////////
//         // ROLE STAFF
//         case EnumObj.staff:
//           print(data);
//           switch (data['enumEvent']) {
//             case EnumEvent.get_data:
//               if (data['Code'] == 200) {
//                 if (data['status'] == false) {
//                   if (DayWorkDA.pageNotTest == 1) {
//                     DayWorkDA.total_listNotTest = data['data']['TotalRecord'];
//                     DayWorkDA.listNotTest = [
//                       for (var e in data['data']['analysis'])
//                         DayWorkItem.fromJson(e)
//                     ];
//                   } else {
//                     DayWorkDA.total_listNotTest = data['data']['TotalRecord'];
//                     DayWorkDA.listNotTest.addAll([
//                       for (var e in data['data']['analysis'])
//                         DayWorkItem.fromJson(e)
//                     ]);
//                   }
//                 } else {
//                   if (DayWorkDA.pageTested == 1) {
//                     DayWorkDA.total_listTested = data['data']['TotalRecord'];

//                     DayWorkDA.listTested = [
//                       for (var e in data['data']['analysis'])
//                         DayWorkItem.fromJson(e)
//                     ];
//                   } else {
//                     DayWorkDA.total_listTested = data['data']['TotalRecord'];

//                     DayWorkDA.listTested.addAll([
//                       for (var e in data['data']['analysis'])
//                         DayWorkItem.fromJson(e)
//                     ]);
//                   }
//                 }
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               homeReload();
//               break;
//             case EnumEvent.search_rule:
//               if (data['Code'] == 200) {
//                 DayWorkDA.listSearch = [
//                   for (var e in data['data']) DayWorkItem.fromJson(e)
//                 ];
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               break;
//             case EnumEvent.get_by_id:
//               if (data['Code'] == 200) {
//                 DayWorkDA.item = DayWorkItem.fromJson(data['data']);
//                 Timer(Duration(milliseconds: 300), () {
//                   CoreRoutes.instance
//                       .navigatorPushRoutes(ResultCustomerInfoRoleStaff(
//                     oneBack: true,
//                   ));
//                 });
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               break;
//             case EnumEvent.scan_qr:
//               if (data['Code'] == 200) {
//                 DayWorkDA.item = DayWorkItem.fromJson(data['data']);
//                 CoreRoutes.instance.pop();
//                 Timer(Duration(milliseconds: 300), () {
//                   CoreRoutes.instance
//                       .navigatorPushRoutes(ResultCustomerInfoRoleStaff(
//                     oneBack: true,
//                   ));
//                 });
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               break;
//             case EnumEvent.edit:
//               if (data['Code'] == 200) {
//                 await CoreRoutes.instance.navigatorPushRoutes(TestResult(
//                   value: DayWorkDA.status,
//                   item: DayWorkDA.item,
//                 ));
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               break;
//             case EnumEvent.submit_user_info:
//               if (data['Code'] == 200) {
//                 await CoreRoutes.instance.navigatorPushRoutes(TestResult(
//                   value: DayWorkDA.status,
//                   itemCustomerInForm: DayWorkDA.itemInForm,
//                   checkSubmitForm: true,
//                 ));
//               } else {
//                 await SnackBarCore.warning(
//                   title: data['Message'],
//                 );
//               }
//               break;
//           }
//           homeReload();
//           break;
//       }
//     });

//     /// function hứng sự kiện noti
//     socket.on('server-noti', (data) async {
//       print('server-noti');
//       print(data);
//     });
//   }

//   static void emitGet(String url, int enumObj, int enumEvent) {
//     socket.emit(
//       'client-get',
//       {
//         'headers': UserService.headerSocket(),
//         'url': '${ConfigApp.langApp}/$url',
//         'enumObj': enumObj,
//         'enumEvent': enumEvent,
//       },
//     );
//   }

//   static void emitPost(
//       Map<String, dynamic> json, String url, int enumObj, int enumEvent,
//       {bool status}) {
//     socket.emit(
//       'client-post',
//       {
//         'headers': UserService.headerSocket(),
//         'body': json,
//         'url': '${ConfigApp.langApp}/$url',
//         'enumEvent': enumEvent,
//         'enumObj': enumObj,
//         'status': status,
//       },
//     );
//   }

//   static void emitRefreshToken(String url, int enumObj, int enumEvent) {
//     socket.emit(
//       'client-post',
//       {
//         'url': '${ConfigApp.langApp}/$url',
//         'enumEvent': enumEvent,
//         'enumObj': enumObj,
//       },
//     );
//   }
// }

// import 'package:connectivity/connectivity.dart';
// import 'package:coresystem/Components/widgets/SnackBar.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// Future<bool> checkInternet(context) async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     // I am connected to a mobile network, make sure there is actually a net connection.
//     popUpCheckInternet(context);
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     // I am connected to a WIFI network, make sure there is actually a net connection.
//     popUpCheckInternet(context);
//   } else {
//     // Neither mobile data or WIFI detected, not internet connection found.
//     SnackBarCore.internet();
//     return false;
//   }
//   return true;
// }

// Future<void> popUpCheckInternet(context) async {
//   if (await DataConnectionChecker().hasConnection) {
//     // Mobile data detected & internet connection confirmed.
//     return true;
//   } else {
//     // Mobile data detected but no internet connection found.
//     SnackBarCore.internet(
//       title:
//           'Đường truyền mạng chậm, vui lòng kiểm tra lại dữ liệu mạng của bạn.',
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;

// class authLocal {
//   static final _localAuthentication = LocalAuthentication();

//   // To check if any type of biometric authentication
//   // hardware is available.
//   static Future<bool> isBiometricAvailable(mounted) async {
//     bool isAvailable = false;
//     try {
//       isAvailable = await _localAuthentication.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     if (!mounted) return isAvailable;
//     if (isAvailable) {
//       print('Biometric is available!');
//     } else {
//       print('Biometric is Unavailable!');
//     }

//     return isAvailable;
//   }

//   static Future<void> getListOfBiometricTypes(
//     mounted,
//   ) async {
//     List<BiometricType> listOfBiometrics;
//     try {
//       listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     if (!mounted) return;
//     print('list Bio' + listOfBiometrics.toString());
//   }

//   static Future<void> authenticateUser(mounted, context,
//       {checkDone, checkFail, checkException}) async {
//     bool isAuthenticated = false;
//     try {
//       isAuthenticated = await _localAuthentication.authenticate(
//           localizedReason: 'Request to authenticate for app.',
//           useErrorDialogs: false,
//           stickyAuth: true,
//           biometricOnly: true);
//     } on PlatformException catch (e) {
//       if (e.code == auth_error.notAvailable) {
//         // The device does not have fingerprint or Touch ID. Handle this error condition here.
//         SnackBarCore.SnackBar(
//           iconColor: null,
//           icon: null,
//           backColor: FColors.error,
//           context: context,
//           title: Platform.isAndroid
//               ? 'Thiết bị không sử dụng bảo mật, xin thử lại sau.'
//               : 'Đã xảy ra lỗi gì đó, xin hãy thử lại sau.',
//         );
//       }
//       if (e.code == auth_error.passcodeNotSet) {
//         // The device does not have fingerprint or Touch ID. Handle this error condition here.
//         SnackBarCore.SnackBar(
//           iconColor: null,
//           icon: null,
//           backColor: FColors.error,
//           context: context,
//           title: 'Thiết bị không sử dụng bảo mật, xin thử lại sau.',
//         );
//       }
//       if (e.code == auth_error.lockedOut) {
//         // The device does not have fingerprint or Touch ID. Handle this error condition here.
//         SnackBarCore.SnackBar(
//           iconColor: null,
//           icon: null,
//           backColor: FColors.error,
//           context: context,
//           title: 'Đã xảy ra lỗi gì đó, xin hãy thử lại sau.',
//         );
//       }
//     }

//     if (!mounted) return;

//     if (isAuthenticated) {
//       checkDone();
//     } else {
//       checkFail();
//     }
//   }

//   static Future<bool> cancelAuthentication() async {
//     bool cancelAndroid = await _localAuthentication.stopAuthentication();
//     return cancelAndroid;
//   }
// }

// import 'package:coresystem/Core/storageKeys_helper.dart';
// import 'package:coresystem/Core/userService.dart';
// import 'package:coresystem/Utils/ConvertUtils.dart';

// class ValidateOTP {
//   ///Số lần khóa
//   static int countFail = 0;

//   /// Số lần nhập sai
//   static int falseTimes = SharedPreferencesHelper.instance.getInt(
//         key: 'falseTimes_${UserService.getKeyStore()}',
//       ) ??
//       0;

//   /// thời điểm khóa
//   static int lockTime = SharedPreferencesHelper.instance.getInt(
//         key: 'lockTime_${UserService.getKeyStore()}',
//       ) ??
//       0;

//   /// thời gian tăng thêm 1 lần khỏa
//   static int secondPerLock = 30;

//   static void timeout() {
//     falseTimes = 0;
//     SharedPreferencesHelper.instance.setInt(
//       key: 'countFail_${UserService.getKeyStore()}',
//       val: 0,
//     );
//     SharedPreferencesHelper.instance.setInt(
//       key: 'lockTime_${UserService.getKeyStore()}',
//       val: 0,
//     );
//     homeReload();
//   }

//   static void correctAuthenticator() {
//     SharedPreferencesHelper.instance.setInt(
//       key: 'falseTimes_${UserService.getKeyStore()}',
//       val: 0,
//     );
//     SharedPreferencesHelper.instance.setInt(
//       key: 'countFail_${UserService.getKeyStore()}',
//       val: 0,
//     );
//     SharedPreferencesHelper.instance.setInt(
//       key: 'lockTime_${UserService.getKeyStore()}',
//       val: 0,
//     );
//     homeReload();
//   }

//   static void incorrectAuthenticator() {
//     // tăng số lần nhập sai lên 1
//     falseTimes = falseTimes + 1;
//     SharedPreferencesHelper.instance.setInt(
//       key: 'falseTimes_${UserService.getKeyStore()}',
//       val: falseTimes,
//     );
//     if (falseTimes == 5) {
//       // tăng số lần bị khóa lên 1
//       countFail = countFail + 1;
//       SharedPreferencesHelper.instance.setInt(
//         key: 'countFail_${UserService.getKeyStore()}',
//         val: countFail,
//       );
//       // ghi lại thời điểm mở khóa khóa
//       lockTime = DateTime.now().totalSeconds() + countFail * secondPerLock;
//       SharedPreferencesHelper.instance.setInt(
//         key: 'lockTime_${UserService.getKeyStore()}',
//         val: lockTime,
//       );
//       homeReload();
//     }
//   }
// }

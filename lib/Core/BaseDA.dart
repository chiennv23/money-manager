// import 'dart:convert';
// import 'package:coresystem/Components/widgets/SnackBar.dart';
// import 'package:coresystem/Core/BaseResponse.dart';
// import 'package:coresystem/Core/Header.dart';
// import 'package:coresystem/Core/routes.dart';
// import 'package:coresystem/Core/userService.dart';
// import 'package:coresystem/routes.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
//
// import 'ConfigAPI.dart';
//
// class BaseDA {
//   static Future<BasicResponse<T>> post<T>(
//       String url, dynamic obj, T Function(Object json) fromJson,
//       {bool showError, String token}) async {
//     obj ??= {};
//     try {
//       var headers = Header.GetheaderBase();
//       final jsonObj = obj == null ? null : json.encode(obj);
//       print(url);
//       print(jsonObj);
//       final responsefinal = BasicResponse<T>();
//
//       final response = await http
//           .post(Uri.parse(url), headers: headers, body: jsonObj)
//           .timeout(
//         const Duration(seconds: 30),
//         onTimeout: () {
//           print('Time out $url');
//           // Time has run out, do what you wanted to do.
//           return http.Response(
//               'Time out', 408); // Request Timeout response status code
//         },
//       );
//       if (response.statusCode == 500) {
//         await SnackBarCore.fail(title: 'Đã có lỗi xảy ra', isBottom: true);
//
//         responsefinal.code = response.statusCode;
//         responsefinal.message = 'Đã có lỗi xảy ra';
//         return responsefinal;
//       } else if (response.statusCode == 401) {
//         // await SnackBarCore.fail(title: response.body, isBottom: true);
//         if (response.statusCode == 401 || response.statusCode == 403) {
//           UserService.removeUser();
//           await CoreRoutes.instance.navigateAndRemove(CoreRouteNames.LOGIN);
//         }
//
//         responsefinal.code = response.statusCode;
//         responsefinal.message = response.body;
//         return responsefinal;
//       } else if (response.statusCode == 422) {
//         var tmp = jsonDecode(utf8.decode(response.bodyBytes));
//         responsefinal.code = response.statusCode;
//         responsefinal.message = tmp['message'];
//         await SnackBarCore.fail(title: tmp['message'], isBottom: true);
//         return responsefinal;
//       } else {
//         responsefinal.code = response.statusCode;
//         var tmp = jsonDecode(utf8.decode(response.bodyBytes));
//         responsefinal.data = fromJson(tmp);
//
//         print(tmp);
//         // responsefinal.code =  200;
//         // if (responsefinal.code != 200) {
//         //   responsefinal.errorCode = tmp['Error']['ErrorCode'];
//         //   responsefinal.errorData = tmp['Error']['MessageDetail'];
//         //   if (showError == null || showError) {
//         //     await SnackBarCore.fail(
//         //         title: '${responsefinal.errorCode} ${responsefinal.errorData}',
//         //         isBottom: true);
//         //   }
//         // } else {
//         //   responsefinal.data = fromJson(tmp);
//         //   if (tmp['Result'] != null &&
//         //       tmp['Result'] is Map &&
//         //       tmp['Result']['TotalRow'] != null) {
//         //     responsefinal.totalRow = tmp['Result']['TotalRow'];
//         //   }
//         // }
//
//         return responsefinal;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   static Future<BasicResponse<T>> get<T>(
//       String url, T Function(Object json) fromJson,
//       {bool showError, String token}) async {
//     try {
//       var headers = Header.GetheaderBase();
//
//       print(url);
//
//       final responsefinal = BasicResponse<T>();
//
//       final response = await http.get(Uri.parse(url), headers: headers).timeout(
//         const Duration(seconds: 30),
//         onTimeout: () {
//           print('Time out $url');
//           // Time has run out, do what you wanted to do.
//           return http.Response(
//               'Time out', 408); // Request Timeout response status code
//         },
//       );
//       if (response.statusCode == 500) {
//         await SnackBarCore.fail(title: 'Đã có lỗi xảy ra', isBottom: true);
//
//         responsefinal.code = response.statusCode;
//         responsefinal.message = 'Đã có lỗi xảy ra';
//         return responsefinal;
//       } else if (response.statusCode == 401) {
//         // await SnackBarCore.fail(title: response.body, isBottom: true);
//         if (response.statusCode == 401 || response.statusCode == 403) {
//           UserService.removeUser();
//           await CoreRoutes.instance.navigateAndRemove(CoreRouteNames.LOGIN);
//         }
//
//         responsefinal.code = response.statusCode;
//         responsefinal.message = response.body;
//         return responsefinal;
//       } else if (response.statusCode == 422) {
//         var tmp = jsonDecode(utf8.decode(response.bodyBytes));
//         responsefinal.code = response.statusCode;
//         responsefinal.message = tmp['message'];
//         await SnackBarCore.fail(title: tmp['message'], isBottom: true);
//         return responsefinal;
//       } else {
//         responsefinal.code = response.statusCode;
//         var tmp = jsonDecode(utf8.decode(response.bodyBytes));
//         print(response.body);
//         responsefinal.data = fromJson(tmp);
//
//         print(tmp);
//         return responsefinal;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   static Future<BasicResponse<T>> put<T>(
//       String url, T Function(Object json) fromJson,
//       {bool showError, String token}) async {
//     try {
//       var headers = Header.GetheaderBase();
//
//       print(url);
//
//       final responsefinal = BasicResponse<T>();
//
//       final response = await http.put(Uri.parse(url), headers: headers).timeout(
//         const Duration(seconds: 30),
//         onTimeout: () {
//           print('Time out $url');
//           // Time has run out, do what you wanted to do.
//           return http.Response(
//               'Time out', 408); // Request Timeout response status code
//         },
//       );
//       if (response.statusCode == 500) {
//         await SnackBarCore.fail(title: 'Đã có lỗi xảy ra', isBottom: true);
//
//         responsefinal.code = response.statusCode;
//         responsefinal.message = 'Đã có lỗi xảy ra';
//         return responsefinal;
//       } else if (response.statusCode == 401) {
//         // await SnackBarCore.fail(title: response.body, isBottom: true);
//         if (response.statusCode == 401 || response.statusCode == 403) {
//           UserService.removeUser();
//           await CoreRoutes.instance.navigateAndRemove(CoreRouteNames.LOGIN);
//         }
//
//         responsefinal.code = response.statusCode;
//         responsefinal.message = response.body;
//         return responsefinal;
//       } else if (response.statusCode == 422) {
//         var tmp = jsonDecode(utf8.decode(response.bodyBytes));
//         responsefinal.code = response.statusCode;
//         responsefinal.message = tmp['message'];
//         await SnackBarCore.fail(title: tmp['message'], isBottom: true);
//         return responsefinal;
//       } else {
//         responsefinal.code = response.statusCode;
//         var tmp = jsonDecode(utf8.decode(response.bodyBytes));
//         print(response.body);
//         responsefinal.data = fromJson(tmp);
//
//         print(tmp);
//
//         return responsefinal;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   static Future<BasicResponse<T>> getList<T>(
//       String url, T Function(Object json) fromJson,
//       {String version, String token}) async {
//     try {
//       var headers = Header.GetheaderBase();
//       print(url);
//       final response = await http.get(Uri.parse(url), headers: headers);
//       if (response.statusCode != 200) {
//         await SnackBarCore.fail(title: response.body, isBottom: true);
//         if (response.statusCode == 401) {
//           UserService.removeUser();
//           await CoreRoutes.instance.navigateAndRemove(CoreRouteNames.LOGIN);
//         }
//         var responseFail = BasicResponse();
//         responseFail.code = response.statusCode;
//         responseFail.message = response.body;
//         return responseFail;
//       } else {
//         var b = BasicResponse<T>();
//         b.data = fromJson(jsonDecode(response.body));
//         b.code = 200;
//         return b;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
// // static Future<BaseResponse> postFile(
// //     String filename,
// //     String url,
// //     Map<String, String> obj,
// //     BaseResponse baseResponse,
// //     String fieldname) async {
// //   try {
// //     var headers = <String, String>{};
// //     final storage = FlutterSecureStorage();
// //     final checkLogin = await storage.read(key: 'IsLogin');
// //     if (checkLogin == null || checkLogin == 'False') {
// //       headers = <String, String>{
// //         'Content-type': 'application/json',
// //         'Api-Version': '1.0',
// //       };
// //     } else {
// //       headers = <String, String>{
// //         'Content-type': 'application/json',
// //         'Api-Version': '1.0',
// //       };
// //     }
// //     final request = http.MultipartRequest('POST', Uri.parse(url));
// //     if (filename != null && filename != '') {
// //       request.files
// //           .add(await http.MultipartFile.fromPath(fieldname, filename));
// //     }
// //     request.fields.addAll(obj);
//
// //     request.headers.addAll(headers);
// //     final response = await request.send();
// //     final res = await http.Response.fromStream(response);
//
// //     if (res.statusCode == 200 || res.statusCode == 201) {
// //       baseResponse.fromJson(json.decode(res.body));
// //     } else {
// //       baseResponse.code = res.statusCode;
// //     }
// //   } catch (e) {
// //     print(e);
// //   }
// //   return baseResponse;
// // }
//
// // static Future<BaseResponse> postListFile(List<File> lstImages, String url,
// //     Map<String, String> obj, BaseResponse baseResponse,
// //     {String imagesNameJson}) async {
// //   obj ??= {};
// //   try {
// //     var headers = <String, String>{};
// //     final storage = FlutterSecureStorage();
// //     final checkLogin = await storage.read(key: 'IsLogin');
// //     if (checkLogin == null || checkLogin == 'False') {
// //       headers = <String, String>{
// //         'Content-type': 'application/json',
// //         'Api-Version': '1.0',
// //       };
// //     } else {
// //       headers = <String, String>{
// //         'Content-type': 'application/json',
// //         'Api-Version': '1.0',
// //       };
// //     }
// //     final request = http.MultipartRequest('POST', Uri.parse(url));
// //     if (null != lstImages) {
// //       for (var image in lstImages) {
// //         request.files.add(await http.MultipartFile.fromPath(
// //             imagesNameJson ?? 'fileAvatar', image.path));
// //       }
// //     }
// //     request.fields.addAll(obj);
// //     request.headers.addAll(headers);
// //     final response = await request.send();
// //     final res = await http.Response.fromStream(response);
//
// //     if (res.statusCode == 200 || res.statusCode == 201) {
// //       baseResponse.fromJson(json.decode(res.body));
// //     } else {
// //       baseResponse.code = res.statusCode;
// //     }
// //   } catch (e) {
// //     print(e);
// //   }
// //   return baseResponse;
// // }
//
// // static Future<BaseResponse> get(String url, BaseResponse baseResponse) async {
// //   try {
// //     var headers = <String, String>{};
// //     final storage = FlutterSecureStorage();
// //     final checkLogin = await storage.read(key: 'IsLogin');
// //     if (checkLogin == null || checkLogin == 'False') {
// //       headers = <String, String>{
// //         'Content-type': 'application/json',
// //         'Api-Version': '1.0',
// //       };
// //     } else {
// //       headers = <String, String>{
// //         'Content-type': 'application/json',
// //         'Api-Version': '1.0',
// //       };
// //     }
// //     final response = await http.get(Uri.parse(url), headers: headers);
// //     if (response.statusCode == 200 || response.statusCode == 201) {
// //       baseResponse.fromJson(json.decode(response.body));
// //     } else {
// //       baseResponse.code = response.statusCode;
// //     }
// //   } catch (e) {
// //     print(e);
// //     baseResponse.code = 500;
// //     baseResponse.message = e.toString();
// //     return baseResponse;
// //   }
// //   return baseResponse;
// // }
// }

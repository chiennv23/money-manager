// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../../Constant/topic_notifications.dart';
//
// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//   print('onBackgroundMessage: $message');
//   return Future<void>.value();
// }
//
// /// Define a top-level named handler which background/terminated messages will
// /// call.
// ///
// /// To verify things are working, check out the native platform logs.
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   print('_firebaseMessagingBackgroundHandler');
// }
//
// /// Create a [AndroidNotificationChannel] for heads up notifications
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
//
// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// class FirebaseWrapper {
//   static void init() async {
//     await Firebase.initializeApp();
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('onMessage');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('onMessageOpenedApp');
//     });
//
//     await FirebaseMessaging.instance
//         .subscribeToTopic(TopicNotifications.ALLAPPDEVICES);
//     // Set the background messaging handler early on, as a named top-level function
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // _firebaseMessaging
//     //     .requestNotificationPermissions(const IosNotificationSettings(
//     //   sound: true,
//     //   badge: true,
//     //   alert: true,
//     // ));
//     // _firebaseMessaging.subscribeToTopic(TopicNotifications.ALLDEVICES);
//     // _firebaseMessaging.getToken().then((value) {
//     //   print("token FireB: $value");
//     // });
//
//     // _firebaseMessaging.configure(
//     //   onMessage: (message) {
//     //     print('onMessage $message');
//     //     return;
//     //   },
//     //   onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
//     //   onLaunch: (Map<String, dynamic> message) async {
//     //     print("onLaunch: $message");
//     //   },
//     //   onResume: (Map<String, dynamic> message) async {
//     //     print("onResume: $message");
//     //   },
//     // );
//
//   }
//
//   // static void init() {
//   //   _fire();
//   // }
//
//   static Future<void> subscribetoTopic(String topic) async {
//     await FirebaseMessaging.instance.subscribeToTopic(topic);
//   }
//
//   static Future<String> gettokenDevice() async {
//     try {
//       final token = await FirebaseMessaging.instance.getToken();
//       return token ?? '';
//     } catch (_) {
//       return '';
//     }
//   }
// }

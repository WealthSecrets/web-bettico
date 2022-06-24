// import 'package:bitmap/bitmap.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void doSomething() async {
//     // Navigating to next screen
//   }

//   // initialize
//   Future<void> initialize() async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('ic_launcher');

//     const IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings();

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onClickNotification);
//   }

//   Future<void> onClickNotification(String? payload) {
//     return Future<void>.value();
//   }

//   // instant notifications
//   Future<void> instantNotification(String title, String summaryText,
//       {String? payload}) async {
//     const AndroidNotificationDetails android = AndroidNotificationDetails(
//       'id',
//       'channel',
//       channelDescription: 'description',
//     );

//     // not working on ios for now
//     const IOSNotificationDetails ios = IOSNotificationDetails();

//     const NotificationDetails platform =
//         NotificationDetails(android: android, iOS: ios);

//     await _flutterLocalNotificationsPlugin.show(1, title, summaryText, platform,
//         payload: payload ?? '');
//   }

//   // image notification
//   Future<void> imageNotification(
//       String title, String summaryText, Bitmap bitmap,
//       {String? payload}) async {
//     final BigPictureStyleInformation bigPicture = BigPictureStyleInformation(
//       ByteArrayAndroidBitmap(bitmap.content),
//       largeIcon: ByteArrayAndroidBitmap(bitmap.content),
//       contentTitle: title,
//       summaryText: summaryText,
//       htmlFormatContent: true,
//       htmlFormatContentTitle: true,
//     );

//     final AndroidNotificationDetails android = AndroidNotificationDetails(
//         'id', 'channel',
//         channelDescription: 'description', styleInformation: bigPicture);

//     final NotificationDetails platform = NotificationDetails(android: android);

//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       summaryText,
//       platform,
//       payload: payload,
//     );
//   }

//   // Stylish Notification
//   Future<void> stylishNotification() async {
//     const AndroidNotificationDetails android = AndroidNotificationDetails(
//       'id',
//       'channel',
//       channelDescription: 'description',
//       color: Colors.deepOrange,
//       enableLights: true,
//       enableVibration: true,
//       largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
//       styleInformation: MediaStyleInformation(
//         htmlFormatContent: true,
//         htmlFormatTitle: true,
//       ),
//     );

//     const NotificationDetails platform = NotificationDetails(android: android);

//     await _flutterLocalNotificationsPlugin.show(
//         0, 'Demo Stylish notification', 'Tap to do something', platform);
//   }

//   // Scheduled notification

//   Future<void> scheduleNotifications() async {
//     const RepeatInterval interval = RepeatInterval.everyMinute;
//     const BigPictureStyleInformation bigPicture = BigPictureStyleInformation(
//       DrawableResourceAndroidBitmap('ic_launcher'),
//       largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
//       contentTitle: 'Demo image notification',
//       summaryText: 'This is some text',
//       htmlFormatContent: true,
//       htmlFormatContentTitle: true,
//     );

//     const AndroidNotificationDetails android = AndroidNotificationDetails(
//       'id',
//       'channel',
//       channelDescription: 'description',
//       styleInformation: bigPicture,
//     );

//     const NotificationDetails platform = NotificationDetails(android: android);

//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         0,
//         'Demo Scheduled notification',
//         'Tap to do something',
//         interval,
//         platform);
//   }

//   // Cancel notification
//   Future<void> cancelNotification() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

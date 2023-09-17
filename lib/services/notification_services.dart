import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/ui/pages/notification_screen.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
class NotifyHelper {

  initializeNotification() async {

    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('appicon');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );


    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse? payload) async{selectNotification(payload!.toString());
        });
  }

  Future selectNotification(String Payload) async{
    if(Payload!=null){
      debugPrint('notification payload : $Payload');
    }
    await Get.to(NotificationScreen(payload: Payload));
  }

  requestiospermissions(){
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
    <IOSFlutterLocalNotificationsPlugin>(
    )?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  displaynotification({required String title,required String body}){
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id','your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        showWhen: false);

    DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS:iosNotificationDetails);

    flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails,payload: 'item x');
  }

  scheduledNotification()async{
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }


  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(Text(body!));
  }
}

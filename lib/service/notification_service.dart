import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:managemen_task_app/models/task_model.dart';
import 'package:managemen_task_app/ui/notifikasi_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/src/date_time.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    _configureLocalTimeZone();
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificatonResponse) {
      selectNotification(notificatonResponse.payload);
    });
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  scheduledNotification(int hour, int minutes, TaskModel taskModel) async {
    // int newTime = 5;
    await flutterLocalNotificationsPlugin.zonedSchedule(
      taskModel.id!.toInt(),
      taskModel.title,
      taskModel.note,
      // tz.FlutterNativeTimezone().getLocalTimezone() as TZDateTime,
      _convertTime(hour, minutes),
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android:
            AndroidNotificationDetails('your channel id', 'your channel name'),
      ),
      // androidScheduleMode: AndroidScheduleMode.alarmClock,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${taskModel.title}|" +
          "${taskModel.note}|" +
          "${taskModel.startTime}|",
    );
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> requestNotificationPermission() async {
    // Memeriksa apakah channel notifikasi sudah dibuat
    // var notificationChannels = await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.getNotificationChannels();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    // Jika channel notifikasi belum dibuat, tampilkan permintaan izin notifikasi
    // if (notificationChannels == null || notificationChannels.isEmpty) {
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //           AndroidFlutterLocalNotificationsPlugin>()
    //       ?.requestPermission();
    // }
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    } else {
      print('Notification Done');
    }

    if (payload == "You change your theme") {
      print('Tidak ada Navigasi Notifikasi');
    } else {
      Get.to(
        () => NotifikasiScreen(
          label: payload,
        ),
      );
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(
      Text('Welcome Task Management App'),
    );
  }
}

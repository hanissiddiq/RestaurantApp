import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class NotificationHelper {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static Future<void> initTimezone() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
}

  static Future<void> scheduleDaily() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime schedule =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);

    await _plugin.zonedSchedule(
      0,
      'Lunch Reminder',
      'Jangan lupa makan siang 🍱',
      schedule.isBefore(now)
          ? schedule.add(const Duration(days: 1))
          : schedule,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily',
          'Daily Reminder',
          importance: Importance.high,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancel() async {
    await _plugin.cancel(0);
  }
}

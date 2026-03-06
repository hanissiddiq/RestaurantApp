import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../utils/notification_helper.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isActive = false;
  bool get isActive => _isActive;

  Future<void> loadReminder() async {
    final prefs = await SharedPreferences.getInstance();
    _isActive = prefs.getBool('dailyReminder') ?? false;
    notifyListeners();
  }

  Future<void> setReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dailyReminder', value);
    _isActive = value;

    value
        ? NotificationHelper.scheduleDaily()
        : NotificationHelper.cancel();

    notifyListeners();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyNotif = 'DAILY_NOTIF';

  Future<bool> get isDailyNotif async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyNotif) ?? false;
  }

  void setDailyNotif(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyNotif, value);
  }
}

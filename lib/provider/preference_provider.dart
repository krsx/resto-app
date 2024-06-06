import 'package:flutter/material.dart';
import 'package:flutter_resto_app/data/local/preferences/preference_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferenceProvider({required this.preferencesHelper}) {
    _getDailyNotif();
  }

  bool _isDailyNotif = false;
  bool get isDailyNotif => _isDailyNotif;

  void _getDailyNotif() async {
    _isDailyNotif = await preferencesHelper.isDailyNotif;
    notifyListeners();
  }

  void _setDailyNotif(bool value) {
    preferencesHelper.setDailyNotif(value);
    _getDailyNotif();
  }

  void setDailyNotif(bool value) {
    _setDailyNotif(value);
  }
}

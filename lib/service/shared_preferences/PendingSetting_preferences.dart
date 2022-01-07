part of 'shared_preferences.dart';

class PendingSettings {
  static const String expired_time_str = "expired_time_treshold";
  //

  static int _days = 30; //default 30 days
  static int getExpiredDayThreshold() {
    return _days ?? 30;
  }

  static Future<void> clearToDefault() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String nodata = '30';
    pref.setString(PendingSettings.expired_time_str, nodata);
    await getPref();
  }

  static Future<void> setExpiredDays({@required String newDays}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(PendingSettings.expired_time_str, newDays);
    await getPref();
  }

  static Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(expired_time_str) != null) {
      _days = int.parse(pref.getString(expired_time_str));
    } else {
      _days = 30;
    }
  }
}

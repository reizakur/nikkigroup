part of 'shared_preferences.dart';

class TimeStampUpdate {
  static const String locatorUpdate = "locator_timestamp";
  static const String productUpdate = "product_timestamp";
  static const String operatorUpdate = "operator_timestamp";
  static const String rejectUpdate = "reject_timestamp";
  //
  static String _locatorUpdateTime = 'No Sync';
  static String _productUpdateTime = 'No Sync';
  static String _rejectUpdateTime = 'No Sync';

  static String getLocatorUpdateTimeStamp() {
    return _locatorUpdateTime;
  }

  static String getProductUpdateTimeStamp() {
    return _productUpdateTime;
  }

  static String getControlRejectUpdateTimeStamp() {
    return _rejectUpdateTime;
  }

  static void printdevinfo() {
    print("\n\n======[timestamp]=======]");
    print("Locator   : $_locatorUpdateTime");
    // print("Operator   : $_locatorUpdateTime");
    print("Product   : $_productUpdateTime");
    print("Reject   : $_rejectUpdateTime");
    print("============================]\n\n");
  }

  static Future<void> clearAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String nodata = 'No Sync';
    pref.setString(TimeStampUpdate.locatorUpdate, nodata);
    pref.setString(TimeStampUpdate.productUpdate, nodata);
    pref.setString(TimeStampUpdate.rejectUpdate, nodata);
    await getPref();
    printdevinfo();
    return;
  }

  static Future<void> updateTimeStamp(
      {@required String key, @required String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
    await getPref();
    printdevinfo();
    return;
  }

  static Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _locatorUpdateTime = pref.getString(locatorUpdate).toString();
    _productUpdateTime = pref.getString(productUpdate).toString();
    _rejectUpdateTime = pref.getString(rejectUpdate).toString();
    return;
  }
}

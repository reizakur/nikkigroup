part of 'shared_preferences.dart';

class ProductQCUserPreferences {
  static const String productQCUserPreferences_str =
      "productQC_user_preferences";
  static bool _enabledSetting = false;

  static const String productQClocatorRemember_str = "productQC_Loc_remember";
  static const String productQClocator_str = "productQC_Loc_value";
  static const String productQCOperatorRemember_str = "productQC_Op_remember";
  static const String productQCOperator_str = "productQC_Op_value";
  static const String productQCProductRemember_str =
      "productQC_Product_remember";
  static const String productQCProduct_str = "productQC_Product_value";
  static const String productQCRejectRemember_str = "productQC_Reject_remember";
  static const String productQCReject_str = "rejectQC_Reject_value";
  //
  static bool _productQCLocatorRemember = false;
  static String _productQCLocatorValue = 'No Data available';
  static bool _productQCOperatorRemember = false;
  static String _productQCOperatorValue = 'No Data available';
  static bool _productQCProductRemember = false;
  static String _productQCProductValue = 'No Data available';
  static bool _productQCRejectRemember = false;
  static String _productQCRejectValue = 'No Data available';

  static bool getSettings() {
    return _enabledSetting;
  }

  static bool rememberLocator() {
    return _productQCLocatorRemember;
  }

  static String getrememberLocator() {
    return _productQCLocatorValue;
  }

  static bool rememberOperator() {
    return _productQCOperatorRemember;
  }

  static String getrememberOperator() {
    return _productQCOperatorValue;
  }

  static bool rememberProduct() {
    return _productQCProductRemember;
  }

  static String getrememberProduct() {
    return _productQCProductValue;
  }

  static bool rememberReject() {
    return _productQCRejectRemember;
  }

  static String getrememberReject() {
    return _productQCRejectValue;
  }

  static Future<void> clearAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String nodata = 'No Sync';
    const bool disabled = false;
    pref.setBool(
        ProductQCUserPreferences.productQCUserPreferences_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQClocatorRemember_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQCOperatorRemember_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQCProductRemember_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQCRejectRemember_str, disabled);
    pref.setString(ProductQCUserPreferences._productQCLocatorValue, nodata);
    pref.setString(ProductQCUserPreferences._productQCProductValue, nodata);
    pref.setString(ProductQCUserPreferences._productQCOperatorValue, nodata);

    pref.setString(ProductQCUserPreferences._productQCRejectValue, nodata);
    await getPref();
    print('[productQCSettings] : Data wiped out');
  }

  static Future<void> updateChoice({
    @required String locator,
    @required String operator,
    @required String product,
    @required String reject,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    PrintDebug.printDialog(id: productQCSetting, msg: 'updating..');
    //

    if (ProductQCUserPreferences.rememberLocator()) {
      PrintDebug.printDialog(id: productQCSetting, msg: 'change to $locator');
      pref.setString(ProductQCUserPreferences.productQClocator_str, locator);
    }
    //
    if (ProductQCUserPreferences.rememberOperator()) {
      PrintDebug.printDialog(id: productQCSetting, msg: 'change to $operator');
      pref.setString(ProductQCUserPreferences.productQCOperator_str, operator);
    }
    if (ProductQCUserPreferences.rememberProduct()) {
      PrintDebug.printDialog(id: productQCSetting, msg: 'change to $product');
      pref.setString(ProductQCUserPreferences.productQCProduct_str, product);
    }
    if (ProductQCUserPreferences.rememberReject()) {
      PrintDebug.printDialog(id: productQCSetting, msg: 'change to $reject');
      pref.setString(ProductQCUserPreferences.productQCProduct_str, reject);
    }
    await getPref();
    print('[productQCSettings] : setting changed');
    PrintDebug.printDialog(
        id: productQCSetting,
        msg: 'check LOC ${ProductQCUserPreferences.getrememberLocator()}');
    PrintDebug.printDialog(
        id: productQCSetting,
        msg: 'check OP ${ProductQCUserPreferences.getrememberOperator()}');
    PrintDebug.printDialog(
        id: productQCSetting,
        msg: 'check PROD ${ProductQCUserPreferences.getrememberProduct()}');
    PrintDebug.printDialog(
        id: productQCSetting,
        msg: 'check Reject ${ProductQCUserPreferences.getrememberReject()}');
  }

  static Future<void> enableSetting({
    @required bool locator,
    @required bool operator,
    @required bool product,
    @required bool reject,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const bool enable = true;
    const bool disabled = false;
    pref.setBool(ProductQCUserPreferences.productQCUserPreferences_str, enable);
    pref.setBool(ProductQCUserPreferences.productQClocatorRemember_str,
        locator ? enable : disabled);
    pref.setBool(ProductQCUserPreferences.productQCOperatorRemember_str,
        operator ? enable : disabled);
    pref.setBool(ProductQCUserPreferences.productQCProductRemember_str,
        product ? enable : disabled);
    pref.setBool(ProductQCUserPreferences.productQCRejectRemember_str,
        reject ? enable : disabled);
    await getPref();
    print('[productQCSettings] : setting changed');
  }

  static Future<void> disabledSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const bool disabled = false;
    pref.setBool(
        ProductQCUserPreferences.productQCUserPreferences_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQClocatorRemember_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQCOperatorRemember_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQCProductRemember_str, disabled);
    pref.setBool(
        ProductQCUserPreferences.productQCRejectRemember_str, disabled);
    await getPref();
    print('[productQCSettings] : setting turned off');
  }

  static Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool(ProductQCUserPreferences.productQCUserPreferences_str) ==
            null ||
        pref.getBool(ProductQCUserPreferences.productQCUserPreferences_str) ==
            false) {
      _enabledSetting = false;
    } else {
      _enabledSetting = true;
    }
    if (pref.getBool(ProductQCUserPreferences.productQClocatorRemember_str) ==
            null ||
        pref.getBool(ProductQCUserPreferences.productQClocatorRemember_str) ==
            false) {
      _productQCLocatorRemember = false;
    } else {
      _productQCLocatorRemember = true;
    }
    if (pref.getBool(ProductQCUserPreferences.productQCOperatorRemember_str) ==
            null ||
        pref.getBool(ProductQCUserPreferences.productQCOperatorRemember_str) ==
            false) {
      _productQCOperatorRemember = false;
    } else {
      _productQCOperatorRemember = true;
    }
    if (pref.getBool(ProductQCUserPreferences.productQCProductRemember_str) ==
            null ||
        pref.getBool(ProductQCUserPreferences.productQCProductRemember_str) ==
            false) {
      _productQCProductRemember = false;
    } else {
      _productQCProductRemember = true;
    }
    if (pref.getBool(ProductQCUserPreferences.productQCRejectRemember_str) ==
            null ||
        pref.getBool(ProductQCUserPreferences.productQCRejectRemember_str) ==
            false) {
      _productQCRejectRemember = false;
    } else {
      _productQCRejectRemember = true;
    }
    _productQCLocatorValue =
        pref.getString(ProductQCUserPreferences.productQClocator_str);
    _productQCOperatorValue =
        pref.getString(ProductQCUserPreferences.productQCOperator_str);
    _productQCProductValue =
        pref.getString(ProductQCUserPreferences.productQCProduct_str);
    _productQCRejectValue =
        pref.getString(ProductQCUserPreferences.productQCReject_str);
    return;
  }
}

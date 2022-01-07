part of 'shared_preferences.dart';

class ChipsPreferences {
  static const locatorKey = 'LocatorChips';
  static const operatorKey = 'OperatorChips';
  static const productKey = 'ProductChips';
  static const rejectKey = 'RejectChips';
  static final List<String> titles = [
    locatorKey,
    operatorKey,
    productKey,
    rejectKey,
  ];
  static final int dataLength = 3;

  Future<int> loadData() async {
    var result = await readAll();
    if (result != 0) {
      await initialization();
      await readAll();
    }
    return 0;
  }

  Future<int> readAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < titles.length; i++) {
      for (int d = 0; d < dataLength; d++) {
        var data = pref.getString('${titles[i]}_$d').toString();
        print('Data : $data');
        if (data == null) return 1;
        var keyPair = titles[i].split('_');
        switch (keyPair[0]) {
          case locatorKey:
            if (data != 'No Data')
              Chips.locator.add(Chips.createData(locatorKey, data));
            break;
          case operatorKey:
            if (data != 'No Data')
              Chips.operator.add(Chips.createData(operatorKey, data));
            break;
          case productKey:
            if (data != 'No Data')
              Chips.production.add(Chips.createData(productKey, data));
            break;
          case rejectKey:
            if (data != 'No Data')
              Chips.production.add(Chips.createData(rejectKey, data));
            break;
          default:
            break;
        }
      }
    }
    // Chips.locator = Chips.locator.reversed.toList();
    // Chips.operator = Chips.operator.reversed.toList();
    // Chips.production = Chips.production.reversed.toList();
    print('Data length for locator is : ${Chips.locator.length}');
    print('Data length for operator is : ${Chips.operator.length}');
    print('Data length for product is : ${Chips.production.length}');
    print('Data length for product is : ${Chips.reject.length}');
    Chips.showData();
    return 0;
  }

  Future<int> initialization() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < titles.length; i++) {
      for (int d = 0; d <= dataLength; d++) {
        pref.setString('${titles[i]}_$d', 'No Data');
      }
    }
    return 0;
  }

  Future<int> writeAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    for (int i = 0; i < titles.length; i++) {
      for (int d = 0; d < dataLength; d++) {
        switch (titles[i]) {
          case locatorKey:
            pref.setString('${locatorKey}_$d', Chips.locator[d].value);
            break;
          case operatorKey:
            pref.setString('${operatorKey}_$d', Chips.operator[d].value);
            break;
          case productKey:
            pref.setString('${productKey}_$d', Chips.production[d].value);
            break;
          case rejectKey:
            pref.setString('${rejectKey}_$d', Chips.reject[d].value);
            break;
          default:
            break;
        }
      }
    }
    return 0;
  }
}

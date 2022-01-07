part of 'models.dart';

class Chips {
  Chips();
  ChipsPreferences _chipsPreferences = ChipsPreferences();
  String title;
  String value;
  static List<Chips> locator = [];
  static List<Chips> operator = [];
  static List<Chips> production = [];
  static List<Chips> reject = [];

  Chips.createData(this.title, this.value);

  static void showData() {
    for (int i = 0; i < ChipsPreferences.titles.length; i++) {
      for (int d = 0; d < ChipsPreferences.dataLength; d++) {
        print('Loop at $d');
        switch (ChipsPreferences.titles[i]) {
          case ChipsPreferences.locatorKey:
            print('Chips : ${ChipsPreferences.locatorKey}@${locator[d].value}');
            break;
          case ChipsPreferences.operatorKey:
            print(
                'Chips : ${ChipsPreferences.operatorKey}@${operator[d].value}');

            break;
          case ChipsPreferences.productKey:
            print(
                'Chips : ${ChipsPreferences.productKey}@${production[d].value}');
            break;
          case ChipsPreferences.rejectKey:
            print('Chips : ${ChipsPreferences.rejectKey}@${reject[d].value}');
            break;
          default:
            break;
        }
      }
    }
  }

  Future<int> addData(String newTitle, String newValue) async {
    print('Test');
    switch (newTitle) {
      case ChipsPreferences.locatorKey:
        if (locator.where((element) => element.value == newValue).length > 0) {
          print('Detected');
          return 1;
        }
        if (locator[ChipsPreferences.dataLength - 1].value != 'No Data' &&
            locator[ChipsPreferences.dataLength - 1].value != null) {
          print('apa ini ${locator[ChipsPreferences.dataLength - 1].value}');
          locator.removeAt(ChipsPreferences.dataLength - 1);
        }
        locator.insert(
            0, Chips.createData(ChipsPreferences.locatorKey, newValue));
        break;
      case ChipsPreferences.operatorKey:
        if (operator.where((element) => element.value == newValue).length > 0) {
          return 1;
        }
        if (operator[ChipsPreferences.dataLength - 1].value != 'No Data' &&
            operator[ChipsPreferences.dataLength - 1].value != null) {
          operator.removeAt(ChipsPreferences.dataLength - 1);
        }
        operator.insert(
            0, Chips.createData(ChipsPreferences.operatorKey, newValue));
        break;
      case ChipsPreferences.productKey:
        if (production.where((element) => element.value == newValue).length >
            0) {
          return 1;
        }
        if (production[ChipsPreferences.dataLength - 1].value != 'No Data' &&
            production[ChipsPreferences.dataLength - 1].value != null) {
          production.removeAt(ChipsPreferences.dataLength - 1);
        }
        production.insert(
            0, Chips.createData(ChipsPreferences.productKey, newValue));
        break;
      case ChipsPreferences.rejectKey:
        if (reject.where((element) => element.value == newValue).length > 0) {
          return 1;
        }
        if (reject[ChipsPreferences.dataLength - 1].value != 'No Data' &&
            reject[ChipsPreferences.dataLength - 1].value != null) {
          reject.removeAt(ChipsPreferences.dataLength - 1);
        }
        reject.insert(
            0, Chips.createData(ChipsPreferences.rejectKey, newValue));
        break;
    }
    _chipsPreferences.writeAll();
    return 0;
  }

  Future<int> removeData(String newTitle, String newValue) async {
    return 0;
  }
}

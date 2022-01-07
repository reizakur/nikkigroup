part of 'jsonCodec.dart';

class ShipmentJsonCodec {
  static List<dynamic> jsonList = [];
  ShipmentDBHelper shipmentDBHelper = ShipmentDBHelper();
  DateTime colSubmitTime;
  // sampe sini
  // ignore: non_constant_identifier_names
  String SP_ID = 'default';
  // ignore: non_constant_identifier_names
  String SP_Optional = 'default';
  // ignore: non_constant_identifier_names
  String SP_Content = 'default';
  // ignore: non_constant_identifier_names
  String SP_ProductionID = 'default';
  // ignore: non_constant_identifier_names
  String SP_ProductionOptional = 'default';
  // ignore: non_constant_identifier_names
  String SP_ProductionContent = 'default';
  String colStatus = 'status';
  ShipmentJsonCodec();
  ShipmentJsonCodec.createData({
    @required Shipment data,
  }) {
    this.SP_ID = data.SP_ID;
    this.SP_Optional = data.SP_Optional;
    this.SP_Content = data.SP_Content;
    this.SP_ProductionID = data.SP_ProductionID;
    this.SP_ProductionOptional = data.SP_ProductionOptional;
    this.SP_ProductionContent = data.SP_ProductionContent;
    this.colSubmitTime = data.colSubmitTime;
    this.colStatus = data.colStatus;
  }

  Future<Map> getData() async {
    Shipment.listofdata = await shipmentDBHelper.getShipmentList();
    print('cek length ori ${Shipment.listofdata.length}');
    return await _getHeaderLayer();
  }

  Future<Map> _getHeaderLayer() async {
    var map = Map<String, dynamic>();
    map['form'] = "Shipment";
    map['data'] = await _getDataLayer();
    return map;
  }

  Future<Map> _getDataLayer() async {
    var map = Map<String, dynamic>();
    ShipmentJsonCodec.jsonList = [];
    ShipmentJsonCodec.jsonList = await _getScannerDataLayer();
    print(ShipmentJsonCodec.jsonList);
    map['user_id'] = UserData.getUserID();
    map['DocumentNo'] = this.SP_Content;
    map['scanner'] = ShipmentJsonCodec.jsonList;
    for (int i = 0; i < ShipmentJsonCodec.jsonList.length; i++) {
      print('Cek typeee : ${ShipmentJsonCodec.jsonList[i]['type']}');
    }
    return map;
  }

  Future<dynamic> _getScannerDataLayer() async {
    int counter = 0;
    for (int i = 0; i < Shipment.listofdata.length; i++) {
      if (Shipment.listofdata[i].SP_ID == this.SP_ID) {
        var map = Map<String, dynamic>();
        if (counter == 0) {
          map['id'] = Shipment.listofdata[i].SP_ID;
          map['type'] = 'shipment';
          map['code'] = Shipment.listofdata[i].SP_Content;
          map['image'] = await _getImageShipment(Shipment.listofdata[i]);
        } else {
          map['id'] = Shipment.listofdata[i].SP_ProductionID;
          map['type'] = 'product';
          map['code'] = Shipment.listofdata[i].SP_ProductionContent;
          map['image'] = await _getImageProduct(Shipment.listofdata[i]);
        }
        print('ini apa sih type nya :${map['type']}');
        print('ini loh hasil map ke $i adalah : ${map}');
        counter++;
        for (int a = 0; a < jsonList.length; a++) {
          print('cek map semua adalah ${jsonList[a]}');
        }
        print('Jumlah length sebelum adalah ${jsonList.length}');
        jsonList.add(map);
        print('Jumlah length setelah ditambah adalah ${jsonList.length}');
        for (int a = 0; a < jsonList.length; a++) {
          print('cek map semua adalah setelah ${jsonList[a]}');
        }
      }
    }
    return jsonList;
  }

  dynamic _getImageShipment(Shipment model) async {
    if (model.SP_Optional == 'IMG') {
      return await model.readFileByte(model.SP_Content);
    } else {
      return 'No IMG';
    }
  }

  dynamic _getImageProduct(Shipment model) async {
    if (model.SP_ProductionOptional == 'IMG') {
      return await model.readFileByte(model.SP_ProductionContent);
    } else {
      return 'No IMG';
    }
  }
}

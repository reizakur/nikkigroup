import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Shipment {
  static List<Shipment> hasil = [];
  Shipment();
  //colnames and table static
  static const String table_qr_shipment = 'shipment'; //text
  static const String col_id = 'id_shipment'; //text  //primary key
  static const String col_qr_shipment = 'qr_shipment';
  static const String col_qr_produk = 'qr_produk';

  //col
  int _id;
  String _qr_shipment;
  String _qr_produk;

  //getter
  int get id => _id;
  String get qr_shipment => _qr_shipment;
  String get qr_produk => _qr_produk;

  //construct to create obj
  Shipment.createwithid(this._id, this._qr_shipment, this._qr_produk) {
    print('Create a new Shipment obj');
  }
  Shipment.create(this._qr_shipment, this._qr_produk) {
    print('Create a new Shipment obj with id autoincrement');
  }
  //construct to import from map
  Shipment.frommap(Map<String, dynamic> frommap) {
    this._id = frommap[col_id];
    this._qr_shipment = frommap[col_qr_shipment];
    this._qr_produk = frommap[col_qr_produk];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (this.id != null) {
      map[col_id] = this.id;
    }
    map[col_qr_shipment] = this._qr_shipment;
    map[col_qr_produk] = this._qr_produk;
    return map;
  }

  //setter

  void setId(int newid) {
    this._id = newid;
  }

  void setQr_Shipment(String newname) {
    this._qr_shipment = newname;
  }

  void serQr_Produk(String user) {
    this._qr_produk = user;
  }
}

class Shipmentdbcontroller {
  static Shipmentdbcontroller classdb;
  static Database _database;
  Shipmentdbcontroller.createinstance() {
    print(
        'creating instance of Shipment db controller [should displayed once]');
  }
  factory Shipmentdbcontroller() {
    if (classdb == null) {
      classdb = Shipmentdbcontroller.createinstance();
    }
    return classdb;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initdb();
    }
    return _database;
  }

  Future<Database> initdb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Shipments.db';
    var Shipmentdatabase =
        await openDatabase(path, version: 1, onCreate: _createdb);
    return Shipmentdatabase;
  }

  void _createdb(Database db, int newVersion) async {
    String buattabel =
        'CREATE TABLE ${Shipment.table_qr_shipment}(${Shipment.col_id} INTEGER PRIMARY KEY AUTOINCREMENT,${Shipment.col_qr_shipment} TEXT,${Shipment.col_qr_produk}  TEXT)';
    await db.execute(buattabel);
  }

  Future<int> deleteShipment(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${Shipment.table_qr_shipment} WHERE ${Shipment.col_id}=$id');
    var batch = db.batch();
    batch.commit();
    return result;
  }

  Future<int> purgeallShipments() async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM ${Shipment.table_qr_shipment}');
    var batch = db.batch();
    batch.commit();
    return result;
  }

  Future<List<Map<String, dynamic>>> getShipmentmaplist() async {
    Database db = await this.database;
    List<Map<String, dynamic>> hasil = new List<Map<String, dynamic>>();
    hasil = await db.query(Shipment.table_qr_shipment);
    var batch = db.batch();
    batch.commit();
    //print(hasil);
    return hasil;
  }

  Future<List<Shipment>> getShipmentlist() async {
    var Shipmentmaplist = await getShipmentmaplist();
    int count = Shipmentmaplist.length;
    List<Shipment> akunlist = List<Shipment>();
    for (int i = 0; i < count; i++) {
      akunlist.add(Shipment.frommap(Shipmentmaplist[i]));
    }
    return akunlist;
  }

  Future<Shipment> getanShipmenttosee(String user) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Shipment.table_qr_shipment} WHERE ${Shipment.col_qr_produk}='$user'");
    var batch = db.batch();
    batch.commit();
    if (result.length > 0) {
      return Shipment.frommap(result[0]);
    } else {
      return Shipment.create('Shipment NOT FOUND', 'SYSTEM FAILED');
    }
  }

  Future<Shipment> getsingleShipment(String user, String pass) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "SELECT * FROM ${Shipment.table_qr_shipment} WHERE ${Shipment.col_qr_produk}='$user'");
    var batch = db.batch();
    batch.commit();
    if (result.length > 0) {
      return Shipment.frommap(result[0]);
    } else {
      return Shipment.create('SYSTEM FAILED', 'SYSTEM FAILED');
    }
  }

  Future<int> insertnewShipment(Shipment akun) async {
    Database db = await this.database;
    print('memasukan .. ');
    print(akun.toMap());
    print('inserting ');
    var result = await db.insert(Shipment.table_qr_shipment, akun.toMap());

    var batch = db.batch();
    batch.commit();
    return result;
  }
}

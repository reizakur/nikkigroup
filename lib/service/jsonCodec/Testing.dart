part of 'jsonCodec.dart';

class TestingCodec {
  static var data;
  Map getData() {
    return _getHeaderData();
  }

  Map _getHeaderData() {
    var map = Map<String, dynamic>();
    map['store'] = _getStore();
    map['deviceInfo'] = _getDeviceInfo();
    map['packageInfo'] = _getPackageInfo();
    return map;
  }

  Map _getDeviceInfo() {
    var map = Map<String, dynamic>();
    map['version.securityPatch'] = data.version.securityPatch.toString();
    map['version.sdkInt'] = data.version.sdkInt.toString();
    map['version.release'] = data.version.release.toString();
    map['version.previewSdkInt'] = data.version.previewSdkInt.toString();
    map['version.incremental'] = data.version.incremental.toString();
    map['version.codename'] = data.version.codename.toString();
    map['version.baseOS'] = data.version.baseOS.toString();
    map['board'] = data.board.toString();
    map['bootloader'] = data.bootloader.toString();
    map['brand'] = data.brand.toString();
    map['device'] = data.device.toString();
    map['display'] = data.display.toString();
    map['fingerprint'] = data.fingerprint.toString();
    map['hardware'] = data.hardware.toString();
    map['host'] = data.host.toString();
    map['id'] = data.id.toString();
    map['manufacturer'] = data.manufacturer.toString();
    map['model'] = data.model.toString();
    map['product'] = data.product.toString();
    map['supported32BitAbis'] = data.supported32BitAbis.toString();
    map['supported64BitAbis'] = data.supported64BitAbis.toString();
    map['supportedAbis'] = data.supportedAbis.toString();
    map['tags'] = data.tags.toString();
    map['type'] = data.type.toString();
    map['isPhysicalDevice'] = data.isPhysicalDevice.toString();
    map['androidId'] = data.androidId.toString();
    map['systemFeatures'] = data.systemFeatures.toString();
    map['lat'] = 'test';
    map['lng'] = 'test';
    return map;
  }

  Map _getStore() {
    var map = Map<String, dynamic>();
    map['storeName'] = 'Toko Jaya Abadi';
    map['lat'] = '106.70095145702363';
    map['lng'] = '106.70095145702363';
    map['surveyorID'] = '106.70095145702363';
    map['dateInput'] = '1000000';
    map['imageIDs'] = '2021-12-20T15:48:07.221447';
    return map;
  }

  Map _getPackageInfo() {
    var map = Map<String, dynamic>();
    map['appName'] = 'Penguin Survey App';
    map['packageName'] = 'com.example.pg_survey_app';
    map['version'] = '1.0.0';
    map['buildNumber'] = '1';
    map['buildSignature'] = 'DDA35A0EC00959B872DB5638ED771FDA95B45EAC';
    return map;
  }
}

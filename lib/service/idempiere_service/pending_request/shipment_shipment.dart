part of '../idempiere_service.dart';

class PendingShipmentService {
  Future<int> uploadToServerShipment({Shipment model}) async {
    LoginRequest _login;
    WebServiceConnection _client;
    _login = new LoginRequest();
    _login.setUser = 'mobile.app';
    _login.setPass = 'penguin';
    _login.setClientID = 1000000;
    _login.setRoleID = int.parse('1000037');
    _login.setOrgID = 0;
    _login.setStage = 0;

    _client = new WebServiceConnection();
    _client.setAttempts = 3;
    _client.setTimeout = 5000;
    _client.setAttemptsTimeout = 5000;
    _client.setUrl = 'http://101.255.95.211:41';
    _client.setAppName = 'Java Test WS Client';
    CreateDataRequest createImage = CreateDataRequest();
    createImage.setWebServiceType = 'CU_MobileTransactionLog';
    createImage.setLogin = _login;
    idem.DataRow data = new idem.DataRow();

    //var file = await _readFileByte(model.colImagePath);
    ShipmentJsonCodec shipmentJsonCodec =
        ShipmentJsonCodec.createData(data: model);

    data.addField("Log", json.encode(await shipmentJsonCodec.getData()));
    print('Hasil Encode :${json.encode(await shipmentJsonCodec.getData())}');
    createImage.setDataRow = data;
    WebServiceConnection client = _client;
    try {
      StandardResponse response = await client.sendRequest(createImage);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 3;
    }
  }
}

part of '../idempiere_service.dart';

class PendingProductionBranchService {
  Future<Uint8List> _readFileByte(String filePath) async {
    File imageFile = new File(filePath);
    Uint8List bytes;
    await imageFile
        .readAsBytes()
        .then((value) =>
            {bytes = Uint8List.fromList(value), print('reading of bytes')})
        .catchError((onError) {
      print('object' + onError.toString());
    });
    return bytes;
  }

  Future<int> uploadToServerQC({
    PendingProductQCBranch model,
  }) async {
    LoginRequest _login;
    WebServiceConnection _client;
    _login = new LoginRequest();
    _login.setUser = model.colUserName;
    _login.setPass = model.colPass;
    _login.setClientID = 1000000;
    _login.setRoleID = int.parse(model.colRoleID);
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
    var file;
    if (model.colImagePath == 'No Image') {
      file = 'No Image';
    } else {
      file = await _readFileByte(model.colImagePath);
    }
    data.addField("Log",
        '{"data" : {"locator_id" : ${model.locator.locatorID},"product_id" : ${model.product.productID},"operator_id" : ${model.operator.operatorID},"status_release" : ${model.colProductStatus == 'Rejected' ? 'N' : 'Y'},"date_scan": "","rfid": "","barcode": "${model.colProductRegistration}","images" : [{"id": ${model.colID},"name": "${model.colImagePath}","binaryData": "$file"}]}}');

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

  Future<int> uploadToServerInOutBranch({PendingInOutBranch model}) async {
    LoginRequest _login;
    WebServiceConnection _client;
    _login = new LoginRequest();
    _login.setUser = model.colUserName;
    _login.setPass = model.colPass;
    _login.setClientID = 1000000;
    _login.setRoleID = int.parse(model.colRoleID);
    _login.setOrgID = 0;
    _login.setStage = 0;

    _client = new WebServiceConnection();
    _client.setAttempts = 3;
    _client.setTimeout = 5000;
    _client.setAttemptsTimeout = 5000;
    _client.setUrl = 'http://101.255.95.211:41';
    _client.setAppName = 'Java Test WS Client';
    CreateDataRequest createImage = CreateDataRequest();
    createImage.setWebServiceType = 'createDataTranste_Log';
    createImage.setLogin = _login;
    idem.DataRow data = new idem.DataRow();

    //var file = await _readFileByte(model.colImagePath);

    data.addField('read_by', '${model.colUserID}'); //user id not USERNAME
    data.addField('read_date', '${model.colSubmitTime.toString()}');
    data.addField("content",
        'form: ${model.colRoleType} ${model.colActionType}, locator_id:${model.locator.locatorID}, scanner:${model.colProductRegistration}');
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

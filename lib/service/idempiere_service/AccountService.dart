part of 'idempiere_service.dart';

class AccountService extends AccountWS {
  String keysearch = 'default key';
  void setnamakey({@required String keySearch}) {
    keysearch = keySearch;
  }

  String getWebServiceType() => '$keysearch';

  @override
  Future<void> testPerformed() async {}

  Future<int> getUserRoles({@required String username}) async {
    AccountRoles.clearall();
    GetListRequest getListRequest = new GetListRequest();
    getListRequest.setWebServiceType = getWebServiceType();
    getListRequest.setLogin = getLogin;
    getListRequest.setFilter =
        "LDAPUser = '$username' AND AD_Client_ID = '1000000' ";
    WebServiceConnection client = getClient;
    try {
      dynamic response = await client.sendRequest(getListRequest);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
        return 3;
      } else if (response.getStatus == WebServiceResponseStatus.Unsuccessful) {
        print('Unsuccessful');
        return 2;
      } else {
        print('Total Rows: ${response.getNumRows}');
        print('');
        AccountRoles.clearall();
        var tempRoleName, tempRoleId;
        for (int i = 0; i < response.getDataSet.getRowsCount(); i++) {
          print('Row: ${i + 1}');
          for (int j = 0;
              j < response.getDataSet.getRow(i).getFieldsCount();
              j++) {
            Field field = response.getDataSet.getRow(i).getFields.elementAt(j);
            print('Column: ${field.getColumn} = ${field.getValue}');
            switch (field.getColumn) {
              case 'AD_Role_ID':
                tempRoleId = '${field.getValue}';
                break;
              case 'Name':
                tempRoleName = '${field.getValue}';
                break;
            }
          }
          AccountRoles currentRole = new AccountRoles();
          currentRole.adRoleID = tempRoleId;
          currentRole.roleName = tempRoleName;
          AccountRoles.listofdata.add(currentRole);
        }
        await AccountRoles.updateDatabase();
        PrintDebug.printDialog(
            id: idempiereAccountService,
            msg: 'Total AccountRoles   :${AccountRoles.listofdata.length}');
        AccountRoles.displayAllRoles();
        return 0;
      }
    } on Exception {
      print('Connection Error');
      return 3;
    }
  }

  // ignore: missing_return
  Future<int> getAdUserId({@required String username}) async {
    QueryDataRequest ws = QueryDataRequest();
    ws.setWebServiceType = 'getLoginUser';
    ws.setLogin = getLogin;
    ws.setOffset = 0;
    ws.setFilter = "LDAPUser = '$username' AND AD_Client_ID = '1000000'";
    WebServiceConnection client = getClient;

    try {
      WindowTabDataResponse response = await client.sendRequest(ws);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
        return 4;
      } else {
        print('Total rows: ${response.getTotalRows}');
        print('Num rows: ${response.getNumRows}');
        print('Start row: ${response.getStartRow}');
        print('');
        for (int i = 0; i < response.getDataSet.getRowsCount(); i++) {
          print('Row: ${i + 1}');
          for (int j = 0;
              j < response.getDataSet.getRow(i).getFieldsCount();
              j++) {
            Field field = response.getDataSet.getRow(i).getFields.elementAt(j);
            print('Column: ${field.getColumn} = ${field.getValue}');
            switch (field.getColumn) {
              /*dari idem */
              case 'AD_User_ID':
                await UserData.setUserID(id: '${field.getValue}');
                if (UserData.getUserID() != 'No Data avail') {
                  return 0;
                } else {
                  return 5;
                }
                break;
              default:
                return 1;
            }
          }
        }
      }
    } on Exception {
      print('Connection Error');
      return 3;
    }
  }

  Future<int> loginToAccount({
    @required String username,
    @required String pass,
  }) async {
    print('Testing login');
    QueryDataRequest ws = QueryDataRequest();
    ws.setWebServiceType = 'getLoginProduction';
    WebServiceConnection _clientku;
    LoginRequest userlogin;
    userlogin = new LoginRequest();
    userlogin.setUser = '$username';
    userlogin.setPass = '$pass';
    userlogin.setClientID = 1000000;
    userlogin.setRoleID = 1000037; //production
    userlogin.setOrgID = 0;
    userlogin.setStage = 0;

    _clientku = new WebServiceConnection();
    _clientku.setAttempts = 3;
    _clientku.setTimeout = 5000;
    _clientku.setAttemptsTimeout = 5000;
    _clientku.setUrl = 'http://101.255.95.211:41';
    _clientku.setAppName = 'Koneksi Idempiere';
    ws.setLogin = userlogin; //LoginRequest
    ws.setLimit = 1;
    ws.setOffset = 0;

    WebServiceConnection client = _clientku;
    try {
      dynamic response = await client.sendRequest(ws);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        //Jika gagal fetch data (pass salah)
        print(response.getErrorMessage);
        print('GetErrorMessage !');
        return 1;
      } else {
        //jika berhasil
        print('Corect');
        return 0;
      }
    } catch (e) {
      print('Catch');
      print(e);
      return 3;
    }
  }
}

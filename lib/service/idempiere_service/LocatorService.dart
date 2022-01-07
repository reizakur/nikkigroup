part of 'idempiere_service.dart';

class LocatorService extends GeneralWS {
  String keysearch = 'default key';
  void setnamakey({@required String keySearch}) {
    keysearch = keySearch;
  }

  String getWebServiceType() => '$keysearch';
  //Tanpa filter
  Future<int> getLocatorData() async {
    GetListRequest getListRequest = new GetListRequest();
    getListRequest.setWebServiceType = 'getListLocator';
    getListRequest.setLogin = getLogin;

    WebServiceConnection client = getClient;
    var tempIfFail = Locator.listofdata;
    try {
      await Locator.clearAll();
      var tempLocatorName, tempLocatorId;
      WindowTabDataResponse response = await client.sendRequest(getListRequest);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        PrintDebug.printDialog(
            id: idempiereLocatorService,
            msg: 'ERROR : ${response.getErrorMessage}');
        Locator.listofdata = tempIfFail;
        return 3;
      } else if (response.getStatus == WebServiceResponseStatus.Unsuccessful) {
        print('Unsuccessful');
        Locator.listofdata = tempIfFail;
        return 2;
      } else {
        print('Total Rows: ${response.getNumRows}');
        print('');
        for (int i = 0; i < response.getDataSet.getRowsCount(); i++) {
          print('Row: ${i + 1}');
          for (int j = 0;
              j < response.getDataSet.getRow(i).getFieldsCount();
              j++) {
            Field field = response.getDataSet.getRow(i).getFields.elementAt(j);
            print('Column: ${field.getColumn} = ${field.getValue}');
            switch (field.getColumn) {
              case 'M_Locator_ID':
                tempLocatorId = '${field.getValue}';
                break;
              case 'Value':
                tempLocatorName = '${field.getValue}';
                break;
            }
          }
          Locator currentLocator = new Locator();
          currentLocator.locatorName = tempLocatorName;
          currentLocator.locatorID = tempLocatorId;
          Locator.listofdata.add(currentLocator);
        }
        await Locator.updateDatabase();
        PrintDebug.printDialog(
            id: idempiereLocatorService,
            msg: 'Total Locators   :${Locator.listofdata.length}');
        Locator.displayAllLocator();
        return 0;
      }
    } on Exception {
      Locator.listofdata = tempIfFail;
      PrintDebug.printDialog(
          id: idempiereLocatorService, msg: 'Connection Error');
      return 3;
    }
  }

  //pake filter
  Future<int> getLocatorBranchData({
    @required String userID,
    @required String roleID,
  }) async {
    GetListRequest getListRequest = new GetListRequest();
    getListRequest.setWebServiceType = 'getListLocatorRoleData';
    getListRequest.setLogin = getLogin;
    getListRequest.setFilter =
        "AD_Role_ID= '$roleID' AND AD_User_ID = '$userID' Order By Name ASC ";
    PrintDebug.printDialog(
        id: idempiereLocatorService,
        msg:
            "AD_Role_ID= '$roleID' AND AD_User_ID = '$userID' Order By Name ASC ");

    WebServiceConnection client = getClient;
    var tempIfFail = Locator.listofdata;
    try {
      await Locator.clearAll();
      var tempLocatorName, tempLocatorId;
      WindowTabDataResponse response = await client.sendRequest(getListRequest);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        PrintDebug.printDialog(
            id: idempiereLocatorService,
            msg: 'ERROR : ${response.getErrorMessage}');
        Locator.listofdata = tempIfFail;
        return 3;
      } else if (response.getStatus == WebServiceResponseStatus.Unsuccessful) {
        print('Unsuccessful');
        Locator.listofdata = tempIfFail;
        return 2;
      } else {
        print('Total Rows: ${response.getNumRows}');
        print('');
        for (int i = 0; i < response.getDataSet.getRowsCount(); i++) {
          print('Row: ${i + 1}');
          for (int j = 0;
              j < response.getDataSet.getRow(i).getFieldsCount();
              j++) {
            Field field = response.getDataSet.getRow(i).getFields.elementAt(j);
            print('Column: ${field.getColumn} = ${field.getValue}');
            switch (field.getColumn) {
              case 'M_Locator_ID':
                tempLocatorId = '${field.getValue}';
                break;
              case 'Name':
                tempLocatorName = '${field.getValue}';
                break;
            }
          }
          Locator currentLocator = new Locator();
          currentLocator.locatorName = tempLocatorName;
          currentLocator.locatorID = tempLocatorId;
          Locator.listofdata.add(currentLocator);
        }
        await Locator.updateDatabase();
        PrintDebug.printDialog(
            id: idempiereLocatorService,
            msg: 'Total Locators   :${Locator.listofdata.length}');
        Locator.displayAllLocator();
        return 0;
      }
    } on Exception {
      Locator.listofdata = tempIfFail;
      PrintDebug.printDialog(
          id: idempiereLocatorService, msg: 'Connection Error');
      return 3;
    }
  }
}

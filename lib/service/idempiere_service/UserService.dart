part of 'idempiere_service.dart';

class OperatorService extends GeneralWS {
  String keysearch = 'default key';
  void setnamakey({@required String keySearch}) {
    keysearch = keySearch;
  }

  String getWebServiceType() => '$keysearch';
  //Tanpa filter
  Future<int> getOperatorData() async {
    GetListRequest getListRequest = new GetListRequest();
    getListRequest.setWebServiceType = 'getListUser';
    getListRequest.setLogin = getLogin;

    WebServiceConnection client = getClient;
    var tempIfFail = Locator.listofdata;
    try {
      await Operator.clearAll();
      PrintDebug.printDialog(
          id: idempiereOperatorService,
          msg: 'Total Operator before op   :${Operator.listofdata.length}');
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
              case 'C_BPartner_ID':
                tempLocatorId = '${field.getValue}';
                break;
              case 'Name':
                tempLocatorName = '${field.getValue}';
                break;
            }
          }

          Operator currentLocator = new Operator();
          currentLocator.operatorName = tempLocatorName;
          currentLocator.operatorID = tempLocatorId;
          Operator.listofdata.add(currentLocator);
        }
        PrintDebug.printDialog(
            id: idempiereOperatorService,
            msg: 'Total Operator 2  :${Operator.listofdata.length}');
        await Locator.updateDatabase();
        PrintDebug.printDialog(
            id: idempiereOperatorService,
            msg: 'Total Operator   :${Operator.listofdata.length}');
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

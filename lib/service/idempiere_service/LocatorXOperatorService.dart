part of 'idempiere_service.dart';

class LocatorXOperatorService extends GeneralWS {
  String getWebServiceType() => 'null';

  //Tanpa filter
  Future<int> getLocatorXOperatorData() async {
    QueryDataRequest ws = QueryDataRequest();
    ws.setWebServiceType = 'getListLocatorUser';
    ws.setLogin = getLogin;
    ws.setLimit = 2;
    ws.setOffset = 0;

    WebServiceConnection client = getClient;

    var tempIfFail = LocatorXOperator.listofdata;

    try {
      await LocatorXOperator.clearAll();
      var tempLocatorName,
          tempLocatorId,
          tempOperatorName,
          tempOperatorId,
          tempClientId,
          tempClientRoleId;
      WindowTabDataResponse response = await client.sendRequest(ws);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
        LocatorXOperator.listofdata = tempIfFail;
        return 2;
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
              case 'M_Locator_ID':
                print('isi ${field.getValue}');
                tempLocatorId = '${field.getValue}';
                break;
              case 'Name':
                print('isi ${field.getValue}');
                tempLocatorName = '${field.getValue}';
                break;
              case 'c_bpartner_name':
                print('isi ${field.getValue}');
                tempOperatorName = '${field.getValue}';
                break;
              case 'c_BPartner_ID':
                print('isi ${field.getValue}');
                tempOperatorId = '${field.getValue}';
                break;
              case 'ad_client_id':
                print('isi ${field.getValue}');
                tempClientId = '${field.getValue}';
                break;
              case 'AD_Role_ID':
                print('isi ${field.getValue}');
                tempClientRoleId = '${field.getValue}';
                break;
              default:
                print('isi ${field.getValue}');
                print('salah');
                break;
            }
          }
          LocatorXOperator currentData = new LocatorXOperator();
          currentData.name = tempLocatorName;
          currentData.mLocatorId = tempLocatorId;
          currentData.cBpartnerName = tempOperatorName;
          currentData.cBpartnerId = tempOperatorId;
          currentData.adRoleId = tempClientRoleId;
          currentData.adClientId = tempClientId;
          currentData.showInfo();
          LocatorXOperator.listofdata.add(currentData);
          print('');
        }
        await LocatorXOperator.updateDatabase();
        return 0;
      }
    } catch (e) {
      print(e);
      PrintDebug.printDialog(
          id: idempiereLocatorXOperatorService, msg: 'Connection Error');
      LocatorXOperator.listofdata = tempIfFail;
      return 3;
    }
  }
}

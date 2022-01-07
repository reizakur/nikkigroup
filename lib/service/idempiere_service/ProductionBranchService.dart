part of 'idempiere_service.dart';

class ProductionBranchService extends GeneralWS {
  String keysearch = 'default key';
  void setnamakey({@required String keySearch}) {
    keysearch = keySearch;
  }

  String getWebServiceType() => 'getListProdukData';

  Future<int> getProductData() async {
    GetListRequest getListRequest = new GetListRequest();
    getListRequest.setWebServiceType = 'getListProdukData';
    getListRequest.setLogin = getLogin;
    getListRequest.setFilter =
        "Name Like '%TB%' AND iscontrolled = 'Y' AND AD_Client_ID = 1000000 Order By Name ASC";
    WebServiceConnection client = getClient;
    var tempIfFail = Production.listofdata;
    try {
      await Production.clearAll();
      var tempProductID, tempProductName, tempProductValue, tempProductIsconsig;
      WindowTabDataResponse response = await client.sendRequest(getListRequest);
      if (response.getStatus == WebServiceResponseStatus.Error) {
        PrintDebug.printDialog(
            id: idempiereProductionBranchService,
            msg: 'ERROR : ${response.getErrorMessage}');
        Production.listofdata = tempIfFail;
        return 3;
      } else if (response.getStatus == WebServiceResponseStatus.Unsuccessful) {
        print('Unsuccessful');
        Production.listofdata = tempIfFail;
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
              case 'Name':
                tempProductName = '${field.getValue}';
                break;
              case 'IsConsignment':
                tempProductIsconsig = '${field.getValue}';
                break;
              case 'Value':
                tempProductValue = '${field.getValue}';
                break;
              case 'M_Product_ID':
                tempProductID = '${field.getValue}';
                break;
            }
          }
          Production currentProduct = new Production();
          currentProduct.productID = tempProductID;
          currentProduct.productName = tempProductName;
          currentProduct.productValue = tempProductValue;
          currentProduct.productIsConsignment = tempProductIsconsig;
          Production.listofdata.add(currentProduct);
        }
        await Production.updateDatabase();
        PrintDebug.printDialog(
            id: idempiereProductionBranchService,
            msg: 'Total Product   :${Production.listofdata.length}');
        return 0;
      }
    } on Exception {
      Production.listofdata = tempIfFail;
      PrintDebug.printDialog(
          id: idempiereProductionBranchService, msg: 'Connection Error');
      return 3;
    }
  }
}

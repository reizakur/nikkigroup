part of '../../../screens.dart';

class WarehouseInBranchScreen extends StatelessWidget {
  const WarehouseInBranchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputOutputPage(
        titleRole: 'Warehouse In',
        subtitleRole: 'Warehouse',
        onSubmitButton: () => submitButton());
  }

  void submitButton() async {
    if (InputOutputPage.selectedLocator == null ||
        (InputOutputPage.rfid == null && InputOutputPage.barcode == null)) {
      Get.snackbar(
        "",
        "",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        icon: Icon(Icons.warning_amber_outlined, color: Colors.white),
        titleText: Text("Cannot submit your request",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600)),
        messageText: Text("Please fill the data correctly",
            style: GoogleFonts.poppins(
              color: Colors.white,
            )),
      );
      return;
    }
    PendingInOutWarehouse newData = PendingInOutWarehouse.insert(
      colActionType: 'in',
      colRoleType: 'Warehouse',
      colUserID: UserData.getUserID(),
      colStatus: 'pending',
      colUserName: UserData.getUsername(),
      colPass: UserData.getPassword(),
      colRoleID: UserData.getUserCurrentRoleID(),
      colLocatorDBversion: TimeStampUpdate.getLocatorUpdateTimeStamp(),
      //locator: selectedLocator,
      locator: InputOutputPage.selectedLocator,
      colProductRegistration: !InputOutputPage.useNFC
          ? 'RFID-${InputOutputPage.rfid}'
          : 'QR-${InputOutputPage.barcode}',
    );
    newData.printAllData();
    await newData.insertToDatabase();
    Get.snackbar(
      "",
      "",
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check, color: Colors.white),
      titleText: Text("Successfully added new data",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w600)),
      messageText: Text("check temporary to review your data(s)",
          style: GoogleFonts.poppins(
            color: Colors.white,
          )),
    );
  }
}
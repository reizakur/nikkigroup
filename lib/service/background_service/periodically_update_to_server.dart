import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penguin_new_version/models/models.dart';
import 'package:penguin_new_version/service/SQFlite_service/SQFlite_service.dart';
import 'package:penguin_new_version/service/idempiere_service/idempiere_service.dart';
import 'package:penguin_new_version/shared/shared.dart';

enum NetWorkStatus { isOnline, isOffline, Crash, shutDown }

class BackgroundService {
  BackgroundService(
      {@required this.onStartProcess,
      @required this.onSucess,
      @required this.onFailed}) {
    PrintDebug.printDialog(id: backgroundService, msg: 'Timer Service Started');
  }
  final Function onStartProcess;
  final Function onSucess;
  final Function onFailed;

  bool uploadInProgress = false;
  NetWorkStatus connectioncheckStatus = NetWorkStatus.isOffline;
  PendingProductQCDBhelper pendingQCDBhelper = PendingProductQCDBhelper();
  PendingInOutDbHelper pendingInOutDBhelper = PendingInOutDbHelper();
  PendingProductQCBranchDBhelper pendingQCBranchDBhelper =
      PendingProductQCBranchDBhelper();
  PendingInOutBranchDbHelper pendingInOutBranchDBhelper =
      PendingInOutBranchDbHelper();
  ShipmentDBHelper pendingShipmentDBhelper = ShipmentDBHelper();
  PendingShipmentService pendingShipmentService = PendingShipmentService();

  PendingQCRequest pendingProductionRequest = PendingQCRequest();
  PendingProductionBranchService pendingProductionBranchRequest =
      PendingProductionBranchService();
  PendingInOutWarehouseDbHelper pendingInOutWarehouseDBhelper =
      PendingInOutWarehouseDbHelper();

  PendingWarehouseService pendingWarehouseRequest = PendingWarehouseService();

  void dispose() {
    PrintDebug.printDialog(
        id: backgroundService, msg: 'Timer Service disposed');
    connectioncheckStatus = NetWorkStatus.shutDown;
  }

  //Future<bool> startService() async {
  void startService() async {
    // if (connectioncheckStatus == NetWorkStatus.isOnline) {
    //   PrintDebug.printDialog(
    //       id: backgroundService, msg: 'Timer already running');
    // } else {
    //   connectioncheckStatus = NetWorkStatus.isOnline;
    // new Timer.periodic(Duration(seconds: 12), (Timer t) {
    //   if (connectioncheckStatus == NetWorkStatus.shutDown) {
    //     PrintDebug.printDialog(id: backgroundService, msg: 'Timer shutdown');
    //     t.cancel();
    //   }
    //   if (connectioncheckStatus != NetWorkStatus.shutDown) {
    //     PrintDebug.printDialog(id: backgroundService, msg: 'Conection Check');
    //     checkconnection();
    //   }
    // });
    // await new Future.delayed(new Duration(seconds: 15), () {});
    // checkconnection();
    // }

    masterThread();
  }

  Future<void> masterThread() async {
    try {
      await compute(checkconnection(), 2000);
    } on Exception {
      PrintDebug.printDialog(id: backgroundService, msg: 'Exception');
    }
  }

  checkconnection() async {
    await new Future.delayed(new Duration(seconds: 05), () {});
    if (connectioncheckStatus == NetWorkStatus.shutDown) {
      PrintDebug.printDialog(id: backgroundService, msg: 'Timer shutdown');
    }
    print('checking status $connectioncheckStatus');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      connectioncheckStatus = NetWorkStatus.isOffline;
    } else {
      connectioncheckStatus = NetWorkStatus.isOnline;
      if (!uploadInProgress) {
        updatePeriodic();
      } else {
        PrintDebug.printDialog(
            id: backgroundService, msg: 'Upload already in progress');
      }
    }
  }

  Future<void> updatePeriodic() async {
    uploadInProgress = true;
    await new Future.delayed(new Duration(seconds: 05), () async {
      await pendingQCBlock();
      await pendingInOutBlock();
      await pendingQCBranchBlock();
      await pendingInOutBranchBlock();
      await pendingShipmentBlock();
      await pendingInOutWarehousehBlock();
//ini juga nih buat branch buat du await bya
      uploadInProgress = false;
      PrintDebug.printDialog(id: backgroundService, msg: 'Upload success');
      onSucess();
      checkconnection();
    });
  }

  Future<void> pendingShipmentBlock() async {
    Shipment.listofdata = await pendingShipmentDBhelper.getShipmentList();
    print('Panjang ${Shipment.listofdata}');
    for (int i = 0; i < Shipment.listofdata.length; i++) {
      if (Shipment.listofdata[i].colStatus.toLowerCase() != 'uploaded') {
        if (!await Shipment.listofdata[i].checkFileAvail()) {
          await pendingShipmentDBhelper.updateStatus(
              id: Shipment.listofdata[i].SP_ID,
              status: 'ERROR : File not found');
          continue;
        }
        var result = await pendingShipmentService.uploadToServerShipment(
            model: Shipment.listofdata[i]);
        print("Hasil result : $result");
        switch (result) {
          case 0:
            await pendingShipmentDBhelper.updateStatus(
                id: Shipment.listofdata[i].SP_ID, status: 'Uploaded');
            break;
          case 1:
            await pendingShipmentDBhelper.updateStatus(
                id: Shipment.listofdata[i].SP_ID,
                status: 'pending'); //error idem
            break;
          case 3:
            await pendingShipmentDBhelper.updateStatus(
                id: Shipment.listofdata[i].SP_ID,
                status: 'pending'); //error network
            break;
          default:
            await pendingShipmentDBhelper.updateStatus(
                id: Shipment.listofdata[i].SP_ID, status: 'pending');

            break;
        }
        Shipment.listofdata = await pendingShipmentDBhelper.getShipmentList();
      }
    }
    return;
  }

  Future<void> pendingQCBlock() async {
    PendingProductQC.listofdata =
        await pendingQCDBhelper.getPendingProductQCList();
    print('Panjang ${PendingProductQC.listofdata}');
    for (int i = 0; i < PendingProductQC.listofdata.length; i++) {
      if (PendingProductQC.listofdata[i].colStatus.toLowerCase() !=
          'uploaded') {
        if (!await PendingProductQC.listofdata[i].checkFileAvail()) {
          await pendingQCDBhelper.updateStatus(
              id: PendingProductQC.listofdata[i].colID,
              status: 'ERROR : File not found');
          continue;
        }
        var result = await pendingProductionRequest.uploadToServerQC(
            model: PendingProductQC.listofdata[i]);
        print("Hasil result : $result");
        switch (result) {
          case 0:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID, status: 'Uploaded');
            break;
          case 1:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID,
                status: 'pending'); //error idem
            break;
          case 3:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID,
                status: 'pending'); //error network
            break;
          default:
            await pendingQCDBhelper.updateStatus(
                id: PendingProductQC.listofdata[i].colID, status: 'pending');

            break;
        }
        PendingProductQC.listofdata =
            await pendingQCDBhelper.getPendingProductQCList();
      }
    }
    return;
  }

  Future<void> pendingQCBranchBlock() async {
    PendingProductQCBranch.listofdata =
        await pendingQCBranchDBhelper.getPendingProductQCBranchList();
    print('ngecek panjangg ${PendingProductQCBranch.listofdata.length}');
    for (int i = 0; i < PendingProductQCBranch.listofdata.length; i++) {
      if (PendingProductQCBranch.listofdata[i].colStatus.toLowerCase() ==
          'pending') {
        if (!await PendingProductQCBranch.listofdata[i].checkFileAvail()) {
          await pendingQCDBhelper.updateStatus(
              id: PendingProductQCBranch.listofdata[i].colID,
              status: 'ERROR : File not found');
          continue;
        }
        print('CEK ROLE ${PendingProductQCBranch.listofdata[i].colRoleID}');
        var result = await pendingProductionBranchRequest.uploadToServerQC(
            model: PendingProductQCBranch.listofdata[i]);
        switch (result) {
          case 0:
            await pendingQCBranchDBhelper.updateStatus(
                id: PendingProductQCBranch.listofdata[i].colID,
                status: 'Uploaded');

            break;
          default:
            await pendingQCBranchDBhelper.updateStatus(
                id: PendingProductQCBranch.listofdata[i].colID,
                status: 'ERROR : Idempiere');

            break;
        }
        PendingProductQCBranch.listofdata =
            await pendingQCBranchDBhelper.getPendingProductQCBranchList();
      }
    }
    return;
  }

  Future<void> pendingInOutBlock() async {
    PendingInOut.listofdata = await pendingInOutDBhelper.getPendingInOutList();
    for (int i = 0; i < PendingInOut.listofdata.length; i++) {
      if (PendingInOut.listofdata[i].colStatus.toLowerCase() == 'pending') {
        print('[cek] username : ${PendingInOut.listofdata[i].colUserName}');
        print('[cek] pass : ${PendingInOut.listofdata[i].colPass}');
        print('[cek] role : ${PendingInOut.listofdata[i].colRoleID}');
        var result = await pendingProductionRequest.uploadToServerInOut(
            model: PendingInOut.listofdata[i]);
        PrintDebug.printDialog(
            id: backgroundService, msg: 'Result for InOut $result');
        switch (result) {
          case 0:
            await pendingInOutDBhelper.updateStatus(
                id: PendingInOut.listofdata[i].colID, status: 'Uploaded');
            break;
          default:
            await pendingInOutDBhelper.updateStatus(
                id: PendingInOut.listofdata[i].colID,
                status: 'ERROR : Idempiere');
            break;
        }
        PendingInOut.listofdata =
            await pendingInOutDBhelper.getPendingInOutList();
      }
    }
    return;
  }

  Future<void> pendingInOutBranchBlock() async {
    PendingInOutBranch.listofdata =
        await pendingInOutBranchDBhelper.getPendingInOutBranchList();
    for (int i = 0; i < PendingInOutBranch.listofdata.length; i++) {
      if (PendingInOutBranch.listofdata[i].colStatus.toLowerCase() ==
          'pending') {
        print(
            '[cek] username : ${PendingInOutBranch.listofdata[i].colUserName}');
        print('[cek] pass : ${PendingInOutBranch.listofdata[i].colPass}');
        print('[cek] role : ${PendingInOutBranch.listofdata[i].colRoleID}');
        var result = await pendingProductionBranchRequest
            .uploadToServerInOutBranch(model: PendingInOutBranch.listofdata[i]);
        PrintDebug.printDialog(
            id: backgroundService, msg: 'Result for InOut $result');
        switch (result) {
          case 0:
            await pendingInOutBranchDBhelper.updateStatus(
                id: PendingInOutBranch.listofdata[i].colID, status: 'Uploaded');
            break;
          default:
            await pendingInOutBranchDBhelper.updateStatus(
                id: PendingInOutBranch.listofdata[i].colID,
                status: 'ERROR : Idempiere');
            break;
        }
        PendingInOutBranch.listofdata =
            await pendingInOutBranchDBhelper.getPendingInOutBranchList();
      }
    }
    return;
  }

  Future<void> pendingInOutWarehousehBlock() async {
    PendingInOutWarehouse.listofdata =
        await pendingInOutWarehouseDBhelper.getPendingInOutWarehouseList();
    for (int i = 0; i < PendingInOutWarehouse.listofdata.length; i++) {
      //ini yang di model
      if (PendingInOutWarehouse.listofdata[i].colStatus.toLowerCase() ==
          'pending') {
        print(
            '[cek] username : ${PendingInOutWarehouse.listofdata[i].colUserName}');
        print('[cek] pass : ${PendingInOutWarehouse.listofdata[i].colPass}');
        print('[cek] role : ${PendingInOutWarehouse.listofdata[i].colRoleID}');
        var result = await pendingWarehouseRequest.uploadToServerInOutWarehouse(
            //ini yang di warehouse idem
            model: PendingInOutWarehouse.listofdata[i]);
        PrintDebug.printDialog(
            id: backgroundService, msg: 'Result for InOut $result');
        switch (result) {
          case 0:
            await pendingInOutWarehouseDBhelper.updateStatus(
                id: PendingInOutWarehouse.listofdata[i].colID,
                status: 'Uploaded');
            break;
          default:
            await pendingInOutWarehouseDBhelper.updateStatus(
                id: PendingInOutWarehouse.listofdata[i].colID,
                status: 'ERROR : Idempiere');
            break;
        }
        PendingInOutWarehouse.listofdata =
            await pendingInOutWarehouseDBhelper.getPendingInOutWarehouseList();
      }
    }
    return;
  }

  // Future<void> pendingShipmentBlock() async {
  //   Shipment.listofdata = await pendingShipmentDBhelper.getShipmentList();
  //   print('Panjang ${PendingProductQC.listofdata}');
  //   for (int i = 0; i < PendingProductQC.listofdata.length; i++) {
  //     if (PendingProductQC.listofdata[i].colStatus.toLowerCase() !=
  //         'uploaded') {
  //       if (!await PendingProductQC.listofdata[i].checkFileAvail()) {
  //         await pendingShipmentDBhelper.updateStatus(
  //             id: PendingProductQC.listofdata[i].colID,
  //             status: 'ERROR : File not found');
  //         continue;
  //       }
  //       var result = await pendingProductionRequest.uploadToServerQC(
  //           model: PendingProductQC.listofdata[i]);
  //       print("Hasil result : $result");
  //       switch (result) {
  //         case 0:
  //           await pendingQCDBhelper.updateStatus(
  //               id: PendingProductQC.listofdata[i].colID, status: 'Uploaded');
  //           break;
  //         case 1:
  //           await pendingQCDBhelper.updateStatus(
  //               id: PendingProductQC.listofdata[i].colID,
  //               status: 'pending'); //error idem
  //           break;
  //         case 3:
  //           await pendingQCDBhelper.updateStatus(
  //               id: PendingProductQC.listofdata[i].colID,
  //               status: 'pending'); //error network
  //           break;
  //         default:
  //           await pendingQCDBhelper.updateStatus(
  //               id: PendingProductQC.listofdata[i].colID, status: 'pending');

  //           break;

  //       }
  //       PendingProductQC.listofdata =
  //           await pendingQCDBhelper.getPendingProductQCList();
  //     }
  //   }
  //   return;
  // }

//futur pendiungQCBlock & pendingInOutBlck dicopy buat branch

}

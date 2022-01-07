part of 'shared.dart';

//Print Tag
const String mainScreen_anim = 'MainScreen Anim';
const String idempiereAccountService = 'Idem Account Service';
const String idempiereProductionService = 'Idem Product Service';
const String idempiereShipmentService = 'Idem Shipment Service';
const String idempiereProductionBranchService = 'Idem Product Branch Service';
const String idempiereLocatorService = 'Idem Locator Service';
const String idempiereControlRejectService = 'Idem Control Reject Service';
const String idempiereOperatorService = 'Idem Operator Service';
const String splashScreen = 'SplashScreen';
const String mainScreen = 'MainScreen';
const String idempiereLocatorXOperatorService = 'Idem LocatorXLocator Service';
const String backgroundService = 'Background Service';
const String locatorSelector = 'Locator Selector screen';
const String rejectSelector = 'ControlReject Selector screen';
const String operatorSelector = 'Operator Selector screen';
const String productSelector = 'Product Selector screen';
const String productQCScreen = 'Product QC';
const String productQCSetting = 'Product QC Preferences';
const String homeScreen = 'HomeScreen';
const String loginScreen = 'LoginScreen';

const String pendingQCModel = 'Pending QC Model';
const String pendingInOutModel = 'Pending InOut Model';
const String pendingQCBranchModel = 'Pending QC Branch Model';
const String pendingInOutBranchModel = 'Pending InOut Branch Model';

const String pendingInOutWarehouseModel = 'Pending InOut Branch Model';
const String pendingInOutWarehouseBranchModel = 'Pending InOut Model';
const String ProductQCBranchScreen = 'Pending InOut BranchScreen Model';
const String pendingDeliveryModel = 'Pending Delivery Model';

class PrintDebug {
  static void printDialog({@required id, @required msg}) {
    debugPrint('[N][$id]: $msg');
  }
}

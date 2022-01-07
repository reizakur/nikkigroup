import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:penguin_new_version/service/jsonCodec/jsonCodec.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penguin_new_version/service/background_service/periodically_update_to_server.dart';
import 'package:penguin_new_version/service/shared_preferences/shared_preferences.dart';
import 'package:penguin_new_version/shared/shared.dart';
import 'package:penguin_new_version/service/SQFlite_service/SQFlite_service.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:penguin_new_version/service/idempiere_service/idempiere_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:device_info/device_info.dart';
import 'package:penguin_new_version/models/models.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_utils_class/image_utils_class.dart';
//screens part :
part 'LoginScreen.dart';
part 'IlustrationDialogScreen.dart';
part 'MainScreen.dart';
part 'SplashScreen.dart';
part 'main_screens/Home_screen.dart';
part 'main_screens/Account_screen.dart';
part 'main_screens/services_screen/production_services/productQC_screen.dart';
part 'main_screens/Temporary_screen.dart';
part 'main_screens/Temporary_Delivery.dart';
part 'main_screens/services_screen/production_services/productIn_screen.dart';
part 'main_screens/services_screen/warehouse_service/warehouseIn_screen.dart';
part 'main_screens/services_screen/warehouse_service/warehouseOut_screen.dart';
part 'main_screens/services_screen/driver_service/driver_screen.dart';
part 'main_screens/services_screen/selector_screen/locator.dart';
part 'main_screens/services_screen/selector_screen/operator.dart';
part 'main_screens/services_screen/production_services/productout_screen.dart';

part 'main_screens/services_screen/production_branch_services/productIn_screen.dart';
part 'main_screens/services_screen/production_branch_services/productQC_screen.dart';
part 'main_screens/services_screen/production_branch_services/productout_screen.dart';

part 'main_screens/services_screen/administrator/administratorUser_screen.dart';

part 'main_screens/services_screen/warehouse_branch_service/warehouseIn_screen.dart';

part 'main_screens/services_screen/warehouse_branch_service/warehouseOut_screen.dart';

part 'main_screens/services_screen/selector_screen/production.dart';
part 'main_screens/services_screen/selector_screen/keterangan.dart';
part 'main_screens/services_screen/selector_screen/nfc_scanner.dart';
part 'main_screens/services_screen/other_screens (unnused)/jsonTest.dart';
//part 'main_screens/services_screen/other_screens/productQC_confirm.dart';

part 'main_screens/services_screen/selector_screen/driver_product.dart';
part 'setting_pages/productQC_settings.dart';
part 'setting_pages/RequestExpired_setting.dart';

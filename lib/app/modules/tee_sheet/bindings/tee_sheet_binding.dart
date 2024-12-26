import 'package:get/get.dart';

import '../controllers/tee_sheet_controller.dart';

class TeeSheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeeSheetController>(
      () => TeeSheetController(),
    );
  }
}

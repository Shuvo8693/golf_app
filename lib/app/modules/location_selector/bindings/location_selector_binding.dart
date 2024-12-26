import 'package:get/get.dart';

import '../controllers/location_selector_controller.dart';

class LocationSelectorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationSelectorController>(
      () => LocationSelectorController(),
    );
  }
}

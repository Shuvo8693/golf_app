import 'package:get/get.dart';

import '../controllers/add_small_outing_controller.dart';

class AddSmallOutingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSmallOutingController>(
      () => AddSmallOutingController(),
    );
  }
}

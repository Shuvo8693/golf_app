import 'package:get/get.dart';

import '../controllers/looking_to_play_controller.dart';

class LookingToPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LookingToPlayController>(
      () => LookingToPlayController(),
    );
  }
}

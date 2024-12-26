import 'package:get/get.dart';

import '../controllers/create_looking_to_play_controller.dart';

class CreateLookingToPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateLookingToPlayController>(
      () => CreateLookingToPlayController(),
    );
  }
}

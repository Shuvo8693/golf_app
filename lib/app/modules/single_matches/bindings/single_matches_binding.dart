import 'package:get/get.dart';

import '../controllers/single_matches_controller.dart';

class SingleMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleMatchesController>(
      () => SingleMatchesController(),
    );
  }
}

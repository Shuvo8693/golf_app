import 'package:get/get.dart';

import '../controllers/golfers_controller.dart';

class GolfersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GolfersController>(
      () => GolfersController(),
    );
  }
}

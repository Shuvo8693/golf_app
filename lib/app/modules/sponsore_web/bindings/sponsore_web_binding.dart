import 'package:get/get.dart';

import '../controllers/sponsore_web_controller.dart';

class SponsoreWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SponsoreWebController>(
      () => SponsoreWebController(),
    );
  }
}

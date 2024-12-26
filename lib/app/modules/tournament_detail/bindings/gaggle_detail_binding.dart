import 'package:get/get.dart';

import '../controllers/gaggle_detail_controller.dart';

class GaggleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GaggleDetailController>(
      () => GaggleDetailController(),
    );
  }
}

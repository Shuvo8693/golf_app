import 'package:get/get.dart';

import '../controllers/top50_controller.dart';

class Top50Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Top50Controller>(
      () => Top50Controller(),
    );
  }
}

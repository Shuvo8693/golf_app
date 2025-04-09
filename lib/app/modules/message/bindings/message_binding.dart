import 'package:get/get.dart';

import '../controllers/messenger_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessengerController>(
      () => MessengerController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/assign_group_controller.dart';

class AssignGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignGroupController>(
      () => AssignGroupController(),
    );
  }
}

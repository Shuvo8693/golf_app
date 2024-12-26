import 'package:get/get.dart';

import '../controllers/create_challenge_controller.dart';

class CreateChallengeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateChallengeController>(
      () => CreateChallengeController(),
    );
  }
}

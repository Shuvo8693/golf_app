import 'package:get/get.dart';

import '../controllers/challenge_matches_controller.dart';

class ChallengeMatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengeMatchesController>(
      () => ChallengeMatchesController(),
    );
  }
}

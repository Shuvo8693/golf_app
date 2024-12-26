import 'package:get/get.dart';

import '../controllers/completed_games_controller.dart';

class CompletedGamesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedGamesController>(
      () => CompletedGamesController(),
    );
  }
}

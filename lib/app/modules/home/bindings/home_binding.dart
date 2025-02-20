import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/home/controllers/current_location_controller.dart';
import 'package:golf_game_play/app/modules/home/controllers/request_to_play_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<CurrentLocationController>(
      () => CurrentLocationController(),
    );

    Get.lazyPut<RequestSendToPlayController>(
      () => RequestSendToPlayController(),
    );
  }
}

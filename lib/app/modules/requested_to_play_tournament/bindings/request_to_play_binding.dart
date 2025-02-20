import 'package:get/get.dart';

import '../controllers/request_to_play_tournament_controller.dart';

class RequestToPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestedToPlayTournamentController>(
      () => RequestedToPlayTournamentController(),
    );
  }
}

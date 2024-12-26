import 'package:get/get.dart';

import '../controllers/add_tournament_controller.dart';

class AddTournamentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTournamentController>(
      () => AddTournamentController(),
    );
  }
}

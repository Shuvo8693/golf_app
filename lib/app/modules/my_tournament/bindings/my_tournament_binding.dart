import 'package:get/get.dart';

import '../controllers/my_tournament_controller.dart';

class MyTournamentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTournamentController>(
      () => MyTournamentController(),
    );
  }
}

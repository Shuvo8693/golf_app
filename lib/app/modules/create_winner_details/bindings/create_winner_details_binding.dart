import 'package:get/get.dart';

import '../controllers/create_winner_details_controller.dart';

class CreateWinnerDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWinnerDetailsController>(
      () => CreateWinnerDetailsController(),
    );
  }
}

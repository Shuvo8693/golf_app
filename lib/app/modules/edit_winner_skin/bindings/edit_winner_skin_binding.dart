import 'package:get/get.dart';

import '../controllers/edit_winner_skin_controller.dart';

class EditWinnerSkinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditWinnerSkinController>(
      () => EditWinnerSkinController(),
    );
  }
}

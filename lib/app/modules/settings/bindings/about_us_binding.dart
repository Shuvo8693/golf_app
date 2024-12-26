import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/settings/controllers/about_us_controller.dart';



class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController(),
    );
  }
}

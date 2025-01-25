import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/sign_in/controllers/login_controller.dart';



class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
  }
}

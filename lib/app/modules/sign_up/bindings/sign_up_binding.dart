import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/sign_up/controllers/signup_controller.dart';



class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController(),
    );
  }
}

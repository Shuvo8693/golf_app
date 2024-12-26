import 'package:get/get.dart';

import 'package:golf_game_play/app/modules/otp/controllers/resend_otp_controller.dart';

import '../controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResendOtpController>(
      () => ResendOtpController(),
    );
    Get.lazyPut<OtpController>(
      () => OtpController(),
    );
  }
}

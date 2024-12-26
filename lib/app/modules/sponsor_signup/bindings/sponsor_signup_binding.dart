import 'package:get/get.dart';

import '../controllers/sponsor_signup_controller.dart';

class SponsorSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SponsorSignupController>(
      () => SponsorSignupController(),
    );
  }
}

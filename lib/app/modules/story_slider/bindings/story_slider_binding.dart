import 'package:get/get.dart';

import '../controllers/story_slider_controller.dart';

class StorySliderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorySliderController>(
      () => StorySliderController(),
    );
  }
}

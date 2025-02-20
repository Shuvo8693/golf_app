import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/story_slider/controllers/story_slider_controller.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_appBar_title.dart';

class StorySliderView extends StatelessWidget {
   StorySliderView({super.key});
  final StorySliderController controller = Get.put(StorySliderController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBarTitle(text: 'Slider'),
      body: Obx(() {
        final currentUser = controller.users[controller.currentUserIndex.value];
        final currentStoryIndex = controller.currentStoryIndex.value;

        List<Story> stories = currentUser.stories;

        return Stack(
          children: [
            PageView.builder(
              itemCount: stories.length,
              controller: PageController(initialPage: currentStoryIndex),
              onPageChanged: (index) {
                controller.currentStoryIndex.value = index;
                if (index == stories.length - 1) {
                  controller.nextUser();
                }
              },
              itemBuilder: (context, index) {
                // Display the story image
                return Image.network(
                  stories[index].imageUrl,
                  fit: BoxFit.cover,
                );
              },
            ),

          ],
        );
      }),
    );
  }
}
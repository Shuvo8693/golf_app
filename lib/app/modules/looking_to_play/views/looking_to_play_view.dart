import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/looking_to_play/controllers/looking_to_play_controller.dart';
import 'package:golf_game_play/app/modules/looking_to_play/widgets/looking_to_play_card_item.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/bottomSheet_top_line.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class LookingToPlayView extends StatelessWidget {
  LookingToPlayView({super.key});

  final LookingToPlayController _lookingToPlayController =
      Get.put(LookingToPlayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.lookingToPlayText, style: AppStyles.h1()),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(Routes.HOME);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                  text: AppString.createText,
                  containerHorizontalPadding: 23.w,
                  containerVerticalPadding: 10.h,
                  onTab: () {
                    Get.toNamed(Routes.CREATE_LOOKING_TO_PLAY);
                  }),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    filColor: AppColors.grayLight,
                    contentPaddingVertical: 20.h,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Icon(
                        Icons.search_outlined,
                        size: 25,
                      ),
                    ),
                    hintText: 'Search...',
                    controller: _lookingToPlayController.searchCtrl,
                    onChange: (value) {},
                  ),
                ),
                SizedBox(width: 6.w),
                GestureDetector(
                  onTap: () {},
                  child: CustomCard(
                    cardColor: AppColors.grayLight,
                    borderSideColor: AppColors.primaryColor,
                    cardHeight: 75,
                    cardWidth: 100,
                    padding: 18,
                    children: [
                      Text(
                        AppString.searchText,
                        style: AppStyles.h4(),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              '80+ Results',
              style: AppStyles.h5(),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return LookingToPlayCardItem();
                },
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }

}



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class CustomCardItem extends StatelessWidget {
  const CustomCardItem({
    super.key, required this.onTab,
  });
  final Function() onTab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.w),
      child: InkWell(
        radius: 12.r,
        onTap: onTab,
        child: CustomCard(
          cardWidth: double.infinity,
          cardColor: AppColors.primaryColor.withOpacity(1),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          isRow: true,
          children: [
            CustomNetworkImage(
              imageUrl: AppNetworkImage.golfPlayerImg,
              height: 80.h,
              width: 80.w,
              borderRadius: BorderRadius.circular(10.r),
            ),
            horizontalSpacing(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppString.nameText} : Shuvo',style: AppStyles.h4(),),
                verticalSpacing(20.h),
                Text('${AppString.cityText} : Dhaka',style: AppStyles.h4()),
              ],
            ),
            horizontalSpacing(10.w),
            Text('${AppString.handicapText} : 5',style: AppStyles.h4()),
          ],
        ),
      ),
    );
  }
}
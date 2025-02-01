import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';

class SponsorContentView extends StatelessWidget {
  const SponsorContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Stack(
        children: [
          Positioned(
            child: CustomNetworkImage(
              imageUrl: AppNetworkImage.golfFlayerImg,
              height: 230,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// Action button Route to Web view
                Padding(
                  padding: EdgeInsets.only(bottom: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('For more information '),
                      SizedBox(width: 8.h),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.SPONSORE_WEB);
                        },
                        child: Text(
                          'click here',
                          style: AppStyles.h5(
                            color: Colors.orange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

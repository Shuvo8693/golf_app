import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/home/model/sponsor_content_model.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/url_luncher/externer_url_luncher.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class SponsorContentView extends StatelessWidget {
  final SponsorContentAttributes sponsorContentAttributes;
  const SponsorContentView({super.key, required this.sponsorContentAttributes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Stack(
        children: [
          Positioned(
            child: CustomNetworkImage(
              imageUrl: '${ApiConstants.imageBaseUrl}/${sponsorContentAttributes.sponserImage?.url}',
              height: 230,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          Positioned(
            child: Column(
              children: [
                /// Action button Route to Web view
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.w),
                    child: CustomCard(
                      isRow: true,
                      elevation: 0,
                      cardHeight: 45.h,
                      padding: 1,
                      borderSideColor: Colors.transparent,
                      cardColor: Colors.black.withOpacity(0.5),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('For more information ',style: AppStyles.h6(color: Colors.white),),
                        SizedBox(width: 8.h),
                        GestureDetector(
                          onTap: () {
                            if(sponsorContentAttributes.link!.isNotEmpty){
                              ExternalUrlLauncher.lunchUrl('${sponsorContentAttributes.link}');
                            }
                          },
                          child: Text(
                            'click here',
                            style: AppStyles.h6(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
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

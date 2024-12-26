import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/challenge_matches/widgets/challenge_matchPlayer_details.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/delete_alert_dialogue.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class ChallengeMatchesView extends StatelessWidget {
  const ChallengeMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.challengeMatchText,
          style: AppStyles.h2(),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return  Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: CustomCard(
              cardColor: AppColors.primaryColor,
              children: [
                /// >>>>This Delete Button only visible to Tournament creator <<<<
                /// Delete Button
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteAlertDialogue();
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: SvgPicture.asset(
                        AppIcons.deleteLogo,
                        height: 20.h,
                        colorFilter: ColorFilter.mode(
                            AppColors.dark2Color, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ChallengeMatchPlayerDetails(
                      imageUrl: AppNetworkImage.golfPlayerImg,
                      playerName: 'Shuvo',
                      playerHandicap: '-3',
                    ),
                    Text(
                      AppString.vsText,
                      style: AppStyles.h1(),
                    ),
                    ChallengeMatchPlayerDetails(
                      imageUrl: AppNetworkImage.golfPlayerImg,
                      playerName: 'Stan',
                      playerHandicap: '5',
                    ),
                  ],
                ),
                verticalSpacing(25.h),
                Container(
                  decoration: BoxDecoration(color: AppColors.black),
                  padding: EdgeInsets.all(5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: [
                          Icon(Icons.location_pin,color: AppColors.white,size: 18.sp,),
                          horizontalSpacing(6.w),
                          SizedBox(
                            width: 170.w,
                              child: Text('Banasree,Dhaka',softWrap: true,overflow: TextOverflow.fade,style: AppStyles.h5(color: AppColors.white),)),
                        ],
                      ),
                      Text('Wed 12/16  8:30 PM',style: AppStyles.h5(color: AppColors.white),),

                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

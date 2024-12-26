import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/winners/controllers/winners_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class WinnersView extends StatelessWidget {
   WinnersView({super.key});
final WinnersController _winnersController=Get.put(WinnersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.winnerDetailText, style: AppStyles.h2()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  text: AppString.addWinnerText,
                  onTab: () {
                    Get.toNamed(Routes.CREATE_WINNER_DETAILS);
                  },
                ),
              ),
              SizedBox(height: 15.h),
              buildSkin(),
              SizedBox(height: 15.h),
              buildKps(),
              SizedBox(height: 15.h),
              buildChallengeMatch(),
              SizedBox(height: 15.h),
              buildPlayerScores()
            ],
          ),
        ),
      ),
    );
  }

  CustomCard buildSkin() {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.skinsText, style: AppStyles.h2()),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(' Name1', style: AppStyles.h5()),
                      SizedBox(width: 20.w),
                      Text('Hole # 4', style: AppStyles.h5()),
                      SizedBox(width: 20.w),
                      Text('Bridle', style: AppStyles.h5()),
                      SizedBox(width: 20.w),
                      CustomCard(
                        padding: 4,
                        isRow: true,
                        cardColor: AppColors.primaryColor,
                        children: [
                          Text('Paid', style: AppStyles.h5()),
                          SizedBox(width: 10.w),
                          Text('\$400.00', style: AppStyles.h5()),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: (){
                              Get.toNamed(Routes.EDIT_WINNER_SKIN);
                            },
                              child: SvgPicture.asset(AppIcons.editLogo,height: 20.h,))

                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }

  CustomCard buildKps() {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.kpsText, style: AppStyles.h2()),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(' Name1', style: AppStyles.h5()),
                      SizedBox(width: 20.w),
                      Text('Hole # 4', style: AppStyles.h5()),
                      SizedBox(width: 20.w),
                      Text('5 feet', style: AppStyles.h5()),
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }

  CustomCard buildChallengeMatch() {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.challengeMatchText, style: AppStyles.h2()),
        ),
        Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Shuvo over Stan', style: AppStyles.h5()),
                    SizedBox(width: 20.w),
                    Text('5-2', style: AppStyles.h5()),
                  ],
                ),
                SizedBox(height: 6.h),
              ],
            )),
        SizedBox(height: 6.h),
      ],
    );
  }

  CustomCard buildPlayerScores() {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.playerScoreText, style: AppStyles.h2()),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              GlobalKey buttonKey=GlobalKey();
              return Column(
                children: [
                  Row(
                    children: [
                      Text(' Name1', style: AppStyles.h5()),
                      SizedBox(width: 20.w),
                      InkWell(
                        key: buttonKey,
                        onTap: (){
                          buildPopUpMenu(buttonKey, _winnersController.teeBoxList, context);
                        }, child: Text('TeeBox ▼ ', style: AppStyles.h5())),
                      SizedBox(width: 20.w),
                      Text('Score: 5', style: AppStyles.h5()),
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
  buildPopUpMenu(GlobalKey buttonKey,List<dynamic> numberList, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      RenderBox currentRenderObject = buttonKey.currentContext?.findRenderObject() as RenderBox;
      final buttonPosition = currentRenderObject.localToGlobal(Offset.zero);
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(buttonPosition.dx.w, buttonPosition.dy.h -190.h, 150.w, 0),
        items: numberList.map(
              (number) => PopupMenuItem(
            child: Text(number),
            onTap: () {
              Text(number);
            },
          ),
        ).toList(),
      );
    });
  }
}

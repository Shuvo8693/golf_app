import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class GaggleDetailView extends StatelessWidget {
  const GaggleDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.tournamentDetailText,style: AppStyles.h2(),),
      centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              CustomCard(
                children: [
                  CustomNetworkImage(
                    imageUrl:
                        'https://t3.ftcdn.net/jpg/00/08/48/90/360_F_8489083_gyFQj5QhX6ZpoH42Vwasg2ZCl1duhntD.jpg',
                    height: 180.h,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 260.h,
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'User name : Boozkljhkkhjkjhkjhkjlhkjl',
                                        style: AppStyles.h5()),
                                    SizedBox(height: 6.h),
                                    Text('Gaggle : Booz',
                                        style: AppStyles.h5()),
                                    SizedBox(height: 6.h),
                                    Text('Type : Skins', style: AppStyles.h5()),
                                    SizedBox(height: 6.h),
                                    Text('Tee Time : 00:00',
                                        style: AppStyles.h5()),
                                    SizedBox(height: 6.h),
                                    Text('Location : Lorem ipsum dolor sit, consectetur elit, seddsfsdfsdfsd  ',
                                        style: AppStyles.h5()),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 2,
                              color: AppColors.grayLight,
                              endIndent: 12,
                              thickness: 2,
                            ),
                            Expanded(
                              child: ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppButton(
                                        onTab: () {
                                          _showAppRovedPlayerBottomSheet(
                                              context);
                                        },
                                        text: 'Players : 2/15',
                                        height: 50.h),
                                    SizedBox(height: 6.h),
                                    Text('Start Date : 2024-05-16',
                                        style: AppStyles.h5()),
                                    SizedBox(height: 6.h),
                                    Text('Start Time : 12:00 AM',
                                        style: AppStyles.h5(fontSize: 12)),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ///=====Request to Play button=====
                  AppButton(
                      onTab: () {},
                      text: AppString.requestToPlayText,
                      height: 50.h),
                  SizedBox(height: 10.h) ,

                  ///=====Tee button=====
                  AppButton(
                      onTab: () {
                       Get.toNamed(Routes.TEE_SHEET);
                      },
                      text: AppString.teeSheetText,
                      height: 50.h),
                  SizedBox(height: 10.h)
                ],
              ),
              SizedBox(height: 16.h),
              CustomButton(
                  onTap: () {
                    Get.toNamed(Routes.CHALLENGE_MATCHES);
                  }, text: AppString.challengeMatchesText),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showAppRovedPlayerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // To shrink the bottom sheet to fit content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title with Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Close Icon at the Top-right Corner
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
              // Content of Bottom Sheet
              SizedBox(height: 10.h),
              Text(AppString.approvedPlayerText, style: AppStyles.h2()),
              SizedBox(height: 20.h),
              CustomCard(
                isRow: true,
                cardWidth: double.infinity,
                borderSideColor: AppColors.primaryColor.withOpacity(0.5),
                children: [
                  Text('John Doe'),
                  SizedBox(width: 8.h),
                  Text('HCP : 3')
                ],
              ),
              SizedBox(height: 8.h),
              CustomCard(
                  isRow: true,
                  cardWidth: double.infinity,
                  borderSideColor: AppColors.primaryColor.withOpacity(0.5),
                  children: [
                    Text('John Doe'),
                    SizedBox(width: 8.h),
                    Text('HCP : 2.1')
                  ]),
              SizedBox(height: 8.h),
              CustomCard(
                isRow: true,
                cardWidth: double.infinity,
                borderSideColor: AppColors.primaryColor.withOpacity(0.5),
                children: [
                  Text('John koe'),
                  SizedBox(width: 8.h),
                  Text('HCP : 8.2')
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}

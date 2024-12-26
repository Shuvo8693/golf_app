import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_constant/app_constant.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';

import '../controllers/my_profile_controller.dart';

class MyProfileView extends StatelessWidget {
   MyProfileView({super.key});

  final MyProfileController _myProfileController=Get.put(MyProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.myProfileText,style: AppStyles.h2(),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 275.h,
                  child: Stack(
                    children: [
                      Positioned(
                        child: CustomNetworkImage(
                          imageUrl: AppConstants.golfDemoImage,
                          height: 200.h,
                        ),
                      ),
                      Positioned(
                        top: 140.h,
                        left: 145.w,
                        child: CustomNetworkImage(
                          imageUrl: AppConstants.demoPersonImage,
                          height: 125.h,
                          width: 125.h,
                          boxShape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 3),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Wrap(
                    runSpacing: 5,
                    children: [
                      SizedBox(height: 10.h,),
                      Text('Name',style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('Shuvo'),
                      SizedBox(height: 10.h),
                      Text(AppString.genderText,style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('Male'),
                      SizedBox(height: 10.h),
                      Text(AppString.cityText, style: AppStyles.h3()),
                      SizedBox(height: 10.h),
                      customListTile('Dhaka', ),
                      SizedBox(height: 10.h),
                      Text(AppString.stateText, style: AppStyles.h3()),
                      SizedBox(height: 10.h),
                      customListTile('State', ),
                      SizedBox(height: 10.h),
                      Text(AppString.countryText,style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('Bangladesh'),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppString.clubText, style: AppStyles.h3()),
                              SizedBox(
                                width: 200.w,
                                child: customListTile('Dhaka Club', ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppString.clubHandicapText, style: AppStyles.h3()),
                              SizedBox(
                                width: 120.w,
                                child: customListTile('3', ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),
                      Text(AppString.handicapText,style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('5'),
                      SizedBox(height: 10.h),
                      Text(AppString.facebookLinkText,style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('www.facebook.com/shuvoKh'),
                      SizedBox(height: 10.h),
                      Text(AppString.instagramLinkText,style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('www.instagram.com/shuvoKh'),
                      SizedBox(height: 10.h),
                      Text(AppString.linkedinLinkText,style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('www.linkedin.com/shuvoKh'),
                      SizedBox(height: 10.h),
                      Text(AppString.xLinkText,style:AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h,),
                      customListTile('www.X.com/shuvoKh'),
                      SizedBox(height: 10.h,),

                      /// Update Button
                      CustomButton(
                          padding: EdgeInsets.only(top: 25.h,bottom: 10.h),
                          onTap: ()=> Get.toNamed(Routes.PROFILE_UPDATE)
                          , text: 'Edit Profile')
                    ],
                  ),
                ),
              ],
            ),
        )

      ),
    );
  }

  customListTile(String title, {String? icon}){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor,width: 1),
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(16).r
      ),
      child: ListTile(
       // leading: SvgPicture.asset(icon??''),
        title:Text(title,style:  AppStyles.customSize(
          size: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.subTextColor,
          family: "Schuyler",
        ),),
      ),
    );
  }
}

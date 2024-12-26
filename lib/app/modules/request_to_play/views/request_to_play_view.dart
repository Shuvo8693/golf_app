import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

import '../controllers/request_to_play_controller.dart';

class RequestToPlayView extends GetView<RequestToPlayController> {
   RequestToPlayView({super.key});
  final RequestToPlayController _requestToPlayController=Get.put(RequestToPlayController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(AppString.requestToPlayText, style: AppStyles.h1()),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        filColor: AppColors.grayLight,
                        contentPaddingVertical: 20.h,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search_outlined,
                            size: 25,
                          ),
                        ),
                        hintText: 'Search...',
                        controller: _requestToPlayController.searchCtrl,
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
                            Text('Search', style: AppStyles.h4(),
                            )
                          ]),
                    )
                  ],
                ),
                SizedBox(height: 30.h),
                Text('80+ Results'),
                SizedBox(height: 8.h),
                CustomCard(
                  padding: 7,
                  cardWidth: double.infinity,
                  borderSideColor:  AppColors.primaryColor.withOpacity(0.4),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Text('${AppString.tournamentText} : Spring Swing Classic ', style: AppStyles.h4()), SizedBox(height: 10.h),
                        SizedBox(height: 7.h),
                        Text('${AppString.tournamentTypeText} :  Stroke Play', style: AppStyles.h4()), SizedBox(height: 10.h),
                        SizedBox(height: 7.h),
                        Text('${AppString.dateAndTimeText} : May 28, 2024 8:00 AM', style: AppStyles.h4()), SizedBox(height: 10.h),
                        SizedBox(height: 7.h),
                        Text('${AppString.locationText} : Dhaka', style: AppStyles.h4()), SizedBox(height: 10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AppButton(text: AppString.chatText, onTab: ()=>_showChatBottomSheet(context),isIconWithTextActive: true,iconPath: AppIcons.chatLogo,containerHorizontalPadding: 2,),

                            AppButton(text:  AppString.standByText, onTab: (){},isIconWithTextActive: true,iconPath: AppIcons.standByIcon,containerHorizontalPadding: 2,),

                            AppButton(text:  AppString.approveText, onTab: (){},isIconWithTextActive: true,iconPath: AppIcons.verifiedIcon,containerHorizontalPadding: 2,),

                            AppButton(text:  AppString.detailsText,
                              onTab: (){
                              Get.toNamed(Routes.USER_PROFILE);
                            },isIconWithTextActive: true,iconPath: AppIcons.detailIcon,containerHorizontalPadding: 2,),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
                SizedBox(height: 25.h),


              ],
            ),
          ),
        ),
      ),
    );
  }

   void _showChatBottomSheet(BuildContext context) {
     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Padding(
           padding: EdgeInsets.all(8.0.sp),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                 IconButton(
                   icon: Icon(Icons.close),
                   onPressed: () {
                     Navigator.pop(context); // Dismiss the bottom sheet
                   },
                 ),
               ],),

               Padding(
                 padding: EdgeInsets.symmetric(vertical: 10.h),
                 child: Text(' Spring Swing Classic', style: AppStyles.h2()),
               ),

               CustomCard(
                 cardWidth: double.infinity,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 8.h),
                     Text('${AppString.nameText} : Stan1 ', style: AppStyles.h4()), SizedBox(height: 10.h),
                     SizedBox(height: 7.h),
                     Text('${AppString.handicapText} : 4', style: AppStyles.h4()), SizedBox(height: 10.h),
                     SizedBox(height: 7.h),
                     Text('${AppString.scoreText} : 72', style: AppStyles.h4()), SizedBox(height: 10.h),
                     SizedBox(height: 20.h),
                     AppButton(text: AppString.sendText, onTab: (){},width: double.infinity,),
                     SizedBox(height: 20.h),
                 ],
               ),
             ],
           ),
         );
       },
     );
   }
}

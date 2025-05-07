import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/requested_to_play_tournament/controllers/request_to_play_approve_contr.dart';
import 'package:golf_game_play/app/modules/requested_to_play_tournament/controllers/request_to_play_reject_contr.dart';
import 'package:golf_game_play/app/modules/requested_to_play_tournament/model/request_to_play_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class RequestToPlayItemCard extends StatelessWidget {
  final RequestToPlayData requestToPlayData;
   RequestToPlayItemCard({
    super.key, required this.requestToPlayData,
  });
  final RequestedToPlayApproveController _requestedToPlayApproveController = Get.put(RequestedToPlayApproveController());
  final RequestedToPlayRejectController _requestedToPlayRejectController = Get.put(RequestedToPlayRejectController());
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: 7.sp,
      cardWidth: double.infinity,
      borderSideColor: AppColors.primaryColor.withOpacity(0.4),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Text('${AppString.applicantNameText} : ${requestToPlayData.requestedUser?.name} ', style: AppStyles.h4()),
            SizedBox(height: 8.h),
            Text('${AppString.tournamentText} : ${requestToPlayData.tournament?.clubName}  ', style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Text('${AppString.tournamentTypeText} : ${requestToPlayData.tournamentType} ', style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Text('Date : ${requestToPlayData.tournament?.date} ', style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Text('${AppString.locationText} : ${requestToPlayData.tournament?.courseName} ', style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //AppButton(text: AppString.chatText, onTab: ()=>_showChatBottomSheet(context),isIconWithTextActive: true,iconPath: AppIcons.chatLogo,containerHorizontalPadding: 2,),
               /// reject
                AppButton(
                  text: AppString.standByText,
                  onTab: () async{
                    if(requestToPlayData.sId != null){
                      await _requestedToPlayRejectController.rejectPlayer(requestToPlayData.sId!);
                    }

                  },
                  isIconWithTextActive: true,
                  iconPath: AppIcons.standByIcon,
                  containerHorizontalPadding: 8.w,
                ),
                /// Approved
                AppButton(
                  text: requestToPlayData.isAccepted==true?'Approved':'Approve' ,
                  onTab: () async{
                    if(requestToPlayData.sId != null){
                      await _requestedToPlayApproveController.approvePlayer(requestToPlayData.sId!);
                    }
                  },
                  isIconWithTextActive: true,
                  iconPath: AppIcons.verifiedIcon,
                  containerHorizontalPadding: 8.w,
                ),
                /// Profile Details
                AppButton(
                  text: 'Details' ,
                  onTab: () {
                    Get.toNamed(Routes.USER_PROFILE,arguments: {'receiverId':'${requestToPlayData.requestedUser?.id}'});
                  },
                  isIconWithTextActive: true,
                  iconPath: AppIcons.detailIcon,
                  containerHorizontalPadding: 8.w,
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
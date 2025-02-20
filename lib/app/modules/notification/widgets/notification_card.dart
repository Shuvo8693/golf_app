 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/app/modules/notification/model/notification_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/date_time_formation/data_age_formation.dart';
import 'package:golf_game_play/common/date_time_formation/difference_formation.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_outlinebutton.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class NotificationCard extends StatelessWidget {
  final int index;
 final NotificationAttributes notificationData;
 final VoidCallback iconOnTap;
   NotificationCard({super.key, required this.index, required this.notificationData, required this.iconOnTap});

  final DataAgeFormation _dataAgeFormation = DataAgeFormation();

  final DifferenceFormation _differenceFormation = DifferenceFormation();

  // final FriendRemoveController _friendRemoveController=Get.put(FriendRemoveController(),tag: 'notification');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomNetworkImage(
          //   imageUrl: AppNetworkImage.golfPlayerImg,
          //   height: 64.h,
          //   width: 64.w,
          //   borderRadius: BorderRadius.circular(10.r),
          // ),
          Stack(
            children: [
              Icon(Icons.notifications_none_outlined,size: 40.sp,color: AppColors.primaryColor,),
              notificationData.isRead==false? Positioned(
                top: 5.h,
                  right: 5.w,
                  child: Container(
                    height: 12.h,
                    width: 12.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepOrangeAccent
                    ),
                  )
              ):SizedBox.shrink()
            ],
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Title or Name
                  Text(
                    "${notificationData.title}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppStyles.customSize(
                      size: 14,
                      fontWeight: FontWeight.w500,
                      family: "Schuyler",
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                            "${notificationData.body}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: AppStyles.h6()),
                      ),
                      IconButton(
                          onPressed: iconOnTap,
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 12.sp,
                          ))
                    ],
                  ),
                  verticalSpacing(8.w),
                  /// Time
                  Text(_dataAgeFormation.formatContentAge(_differenceFormation.formatDifference(notificationData.createdAt!),),
                      style: AppStyles.h6()),
                  /*Row(
                    children: [
                      CustomButton(
                        onTap: () async {
                          // if (widget.notificationResults.friendRequestId != null) {
                          //   await _requestAcceptController.sendAcceptRequest(widget.notificationResults.friendRequestId,toRemoveFromIndex: (){
                          //     widget.notificationController?.notificationModel.value.data?.attributes?.results?.removeAt(widget.index);
                          //     widget.notificationController?.notificationModel.refresh();
                          //   });
                          // }
                        },
                        width: 100.w,
                        height: 40.h,
                        text: "Accept",
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomOutlineButton(
                        onTap: () async {
                          // if (widget.notificationResults.friendId != null) {
                          //   await _friendRemoveController.removeFriend(widget.notificationResults.friendId ,toRemoveFromIndex: (){
                          //     widget.notificationController?.notificationModel.value.data?.attributes?.results?.removeAt(widget.index);
                          //     widget.notificationController?.notificationModel.refresh();
                          //   });
                          // }
                        },
                        width: 100.w,
                        height: 40.h,
                        text: AppString.deleteText,
                        textStyle: AppStyles.h5(color: Colors.redAccent),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/date_time_formation/data_age_formation.dart';
import 'package:golf_game_play/common/date_time_formation/difference_formation.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_outlinebutton.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class NotificationCard extends StatefulWidget {
  final int index;

  const NotificationCard({super.key, required this.index});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  final DataAgeFormation _dataAgeFormation = DataAgeFormation();

  final DifferenceFormation _differenceFormation = DifferenceFormation();

  // final FriendRemoveController _friendRemoveController=Get.put(FriendRemoveController(),tag: 'notification');
  // final FriendRequestAcceptController _requestAcceptController= Get.put(FriendRequestAcceptController(),tag: 'notification');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imageUrl: AppNetworkImage.golfPlayerImg,
            height: 64.h,
            width: 64.w,
            borderRadius: BorderRadius.circular(10.r),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Title or Name
                      Flexible(
                        child: Text(
                          "This is Title akljshkdkljhsdkjhsakjdhkasjdh",
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.customSize(
                            size: 14,
                            fontWeight: FontWeight.w500,
                            family: "Schuyler",
                          ),
                        ),
                      ),
                      /// Time
                      horizontalSpacing(8.w),
                      Text(
                          _dataAgeFormation.formatContentAge(_differenceFormation.formatDifference(DateTime.now()),),
                          style: AppStyles.h6()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                            "This is content message thisiscontentmessagethisis",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: AppStyles.h6()),
                      ),
                      IconButton(
                          onPressed: () {
                            // Get.toNamed(AppRoutes.personalInfoScreen,arguments: {'postId': widget.notificationResults.postId});
                            // Get.toNamed(AppRoutes.homeScreen,arguments: {'postId': widget.notificationResults.postId});
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 12.sp,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

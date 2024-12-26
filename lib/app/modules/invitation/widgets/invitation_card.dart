import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/date_time_formation/data_age_formation.dart';
import 'package:golf_game_play/common/date_time_formation/difference_formation.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_outlinebutton.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class InvitationCard extends StatefulWidget {
  final int index;

  const InvitationCard({super.key, required this.index});

  @override
  State<InvitationCard> createState() => _InvitationCardState();
}

class _InvitationCardState extends State<InvitationCard> {
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
          InkWell(
            onTap: () {
              Get.toNamed(Routes.USER_PROFILE);
            },
            child: CustomNetworkImage(
              imageUrl: AppNetworkImage.golfPlayerImg,
              height: 64.h,
              width: 64.w,
              borderRadius: BorderRadius.circular(10.r),
            ),
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
                      /// Inviter Name
                      Flexible(
                        child: Text("Shuvo Kh adklhdkajshdkljahsdlalkjsdlkjsdlakj",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppStyles.h4(family:'Schuyler' )),
                      ),
                       horizontalSpacing(10.w),
                       SvgPicture.asset(AppIcons.threeDotIcon),
                    ],
                  ),

                  /// Tournament name & Location
                  verticalSpacing(6.h),
                  Text("Booz dhaka adklhdkajshdkljahsdlkjashdkljashdklalkjdlkasjdlsddkf;sldkf;lsdkf;lsdkf;lsdkf;ldskf;lksd;flksd;lfk;sdlfk;l;asldk;laskd;laskd;lkasd;lkas;ldk;slakd;laskd",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppStyles.h6()),
                  verticalSpacing(6.h),
                  Text(
                      "Mirpur,Dhaka ;ll;kajlksdjlksjdlksjdlksjdlksjdlkslalkdlkjaslkjlkdjlaksdjlksjdlkasjdlkajsd';sdfl';sdlf';dslf';sdlf'lds'fl'",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppStyles.h6()),

                  /// Accept & Delete button
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

                  /// Time
                  Text(
                      _dataAgeFormation.formatContentAge(_differenceFormation
                          .formatDifference(DateTime.now())),
                      style: AppStyles.h6()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/invitation/controllers/invitation_accept_controller.dart';
import 'package:golf_game_play/app/modules/invitation/controllers/invitation_controller.dart';
import 'package:golf_game_play/app/modules/invitation/controllers/invitation_delete_controller.dart';
import 'package:golf_game_play/app/modules/invitation/model/invitation_model.dart';
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

class SmallInvitationCard extends StatefulWidget {
  final int index;
  final InvitationAttributes invitationAttributes;
  final InvitationController invitationController;
  const SmallInvitationCard({super.key, required this.index, required this.invitationAttributes, required this.invitationController});

  @override
  State<SmallInvitationCard> createState() => _InvitationCardState();
}

class _InvitationCardState extends State<SmallInvitationCard> {
  final DataAgeFormation _dataAgeFormation = DataAgeFormation();
  final DifferenceFormation _differenceFormation = DifferenceFormation();

   late InvitationAcceptController _invitationAcceptController;
   late InvitationDeleteController _invitationDeleteController;

   @override
  void initState() {
    super.initState();
    _invitationAcceptController = Get.put(InvitationAcceptController(invitationController: widget.invitationController));
    _invitationDeleteController = Get.put(InvitationDeleteController(invitationController: widget.invitationController));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.USER_PROFILE,arguments: {'userId': widget.invitationAttributes.inviteSender?.id});
            },
            child: CustomNetworkImage(
              imageUrl: '${ApiConstants.imageBaseUrl}/${widget.invitationAttributes.inviteSender?.image}',
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
                        child: Text("${widget.invitationAttributes.inviteSender?.name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppStyles.h4(family:'Schuyler' )
                        ),
                      ),
                      horizontalSpacing(10.w),
                      SvgPicture.asset(AppIcons.threeDotIcon),
                    ],
                  ),

                  /// Tournament name & Location
                  verticalSpacing(6.h),
                  Text("${widget.invitationAttributes.smallTournament?.tournamentName}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppStyles.h6()),
                  verticalSpacing(6.h),
                  Text("${widget.invitationAttributes.smallTournament?.courseName}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppStyles.h6()),

                  /// Accept & Delete button
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      CustomButton(
                        onTap: () async {
                          if (widget.invitationAttributes.sId != null) {
                            await _invitationAcceptController.acceptRequest(widget.invitationAttributes.sId! ,updateFromIndex: (){
                               widget.invitationController.invitationModel.refresh();
                            });
                          }
                        },
                        width: 100.w,
                        height: 40.h,
                        text: widget.invitationController.invitationModel.value.data?.attributes?[widget.index].isAccepted==true?"Accepted":"Accept",
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomOutlineButton(
                        onTap: () async {
                          if (widget.invitationAttributes.sId != null) {
                            await _invitationDeleteController.deleteRequest(widget.invitationAttributes.sId! ,updateFromIndex: () {});
                          }
                        },
                        width: 100.w,
                        height: 40.h,
                        text: AppString.deleteText,
                        textStyle: AppStyles.h5(color: Colors.redAccent),
                      ),
                    ],
                  ),

                  /// Time
                  Text(_dataAgeFormation.formatContentAge(_differenceFormation.formatDifference(widget.invitationAttributes.createdAt!)),
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



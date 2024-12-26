import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/bottomSheet_top_line.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class LookingToPlayCardItem extends StatelessWidget {
  const LookingToPlayCardItem({
    super.key,
  });

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
            Text('${AppString.userNameText} : Shuvo',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h4()),
            SizedBox(height: 10.h),
            SizedBox(height: 7.h),
            Text('${AppString.visitingFromText} :  Dhaka',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h4()),
            SizedBox(height: 10.h),
            SizedBox(height: 7.h),
            Text('${AppString.golfCourseText} : Pine valley ',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h4()),
            SizedBox(height: 10.h),
            SizedBox(height: 7.h),
            Text(
                '${AppString.dateRangeText} : 22 January 2024 to 3 July 2024',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppButton(
                  text: AppString.sendInvitationText,
                  onTab: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16)),
                      ),
                      builder: (context) =>
                          buildSendInvitationCard(),
                    );
                  },
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

  Column buildSendInvitationCard() {
    return Column(
      children: [
        BottomSheetTopLine(),
        verticalSpacing(10.h),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(AppString.chooseTournamentText, style: AppStyles.h3()),
        ),
        verticalSpacing(10.h),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: CustomCard(
                  isRow: true,
                  cardWidth: double.infinity,
                  elevation: 0,
                  cardColor: AppColors.primaryColor.withOpacity(0.4),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${AppString.tournamentNameText} : ',
                              style: AppStyles.h4(family: 'Schuyler')),
                          Text('Booz ahsgdfhsgafdhgsafdhgsdfsahgdfhsagfdhgsaf ',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.h6()),
                          verticalSpacing(8.h),
                          Text('${AppString.courseNameText} :',
                              style: AppStyles.h4(family: 'Schuyler')),
                          Text(
                            'Mirpur,dhaka jasgdjasdjsajdsajdjsagdjhsagdjhjas',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.h6(),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: CustomCard(
                        elevation: 3,
                        cardColor: AppColors.primaryColor,
                        children: [
                          SvgPicture.asset(
                            AppIcons.sentIcon,
                            height: 25.h,
                            colorFilter: ColorFilter.mode(
                                AppColors.white, BlendMode.srcIn),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:golf_game_play/app/modules/looking_to_play/model/looking_to_play_model.dart';
import 'package:golf_game_play/app/modules/looking_to_play/widgets/tournament_selection.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/bottomSheet_top_line.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';
import 'package:intl/intl.dart';

class LookingToPlayCardItem extends StatelessWidget {
  final LookingToPlayAttributes lookingToPlayAttributes;

  const LookingToPlayCardItem({
    super.key,
    required this.lookingToPlayAttributes,

  });

  @override
  Widget build(BuildContext context) {
   DateTime dateTimeFrom= DateFormat("dd/MM/yyyy").parse(lookingToPlayAttributes.fromDate!);
   DateTime dateTimeTo= DateFormat("dd/MM/yyyy").parse(lookingToPlayAttributes.tomDate!);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${AppString.userNameText} : ${lookingToPlayAttributes.userName}',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.h4()),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  menuPadding: EdgeInsets.symmetric(vertical: 0),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                          child: Text('Player profile'),
                        onTap: (){
                          print(lookingToPlayAttributes.player);
                          Get.toNamed(Routes.USER_PROFILE,arguments: {'receiverId':lookingToPlayAttributes.player});

                        },
                      )
                    ];
                  },
                )
              ],
            ),
            // SizedBox(height: 10.h),
            // Text('${AppString.visitingFromText} :  ${lookingToPlayAttributes.visitingFrom}', overflow: TextOverflow.ellipsis, style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Text('${AppString.golfCourseText} : ${lookingToPlayAttributes.golfCourse} ', overflow: TextOverflow.ellipsis, style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Text('${AppString.dateRangeText} : ${DateFormat("MMM dd, yyyy").format(dateTimeFrom)} to ${DateFormat("MMM dd, yyyy").format(dateTimeTo)}', overflow: TextOverflow.ellipsis,
                style: AppStyles.h4()),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppButton(
                  text: AppString.sendInvitationText,
                  onTab: () {
                  String? playerId = lookingToPlayAttributes.player;
                   showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => TournamentSelection(playerId: playerId??'',),
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
}


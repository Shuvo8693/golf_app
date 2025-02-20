import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_game_play/app/modules/looking_to_play/model/tournament_selection_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class ClubTournamentSelectionCardItem extends StatelessWidget {
  final BigTournament bigTournament;
  const ClubTournamentSelectionCardItem({
    super.key, required this.bigTournament,
  });

  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${AppString.tournamentNameText} :- ',
                        style: AppStyles.h4(family: 'Schuyler')),
                    Text('Players: ${bigTournament.tournamentPlayersList?.length}/${bigTournament.numberOfPlayers}',style: AppStyles.h6(color: Colors.blueAccent) ,),
                  ],
                ),
                Text('${bigTournament.clubName}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.h6()),
                verticalSpacing(8.h),
                Text('${AppString.courseNameText} :-',
                    style: AppStyles.h4(family: 'Schuyler')),
                Text('${bigTournament.courseName}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.h6(),
                ),
              ],
            ),
          ),
          if(bigTournament.tournamentPlayersList?.length!=bigTournament.numberOfPlayers)
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
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/home/controllers/request_to_play_controller.dart';
import 'package:golf_game_play/app/modules/home/model/club_tournament_model.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

import 'gaggle_rules.dart';

class ClubTournamentCard extends StatelessWidget {
  final ClubTournamentData? clubTournamentData;
  final int index;
  final MyProfile myProfile;

   ClubTournamentCard({super.key, required this.clubTournamentData, required this.index, required this.myProfile});
   final RequestSendToPlayController _requestToPlayController =Get.put(RequestSendToPlayController(),tag: 'club');

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      cardWidth: 350,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Club : ${clubTournamentData?.clubName}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Type : ${clubTournamentData?.tournamentType}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Course name : ${clubTournamentData?.courseName} ', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('City : ${clubTournamentData?.city}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text(
          'Players : ${clubTournamentData?.tournamentPlayersList?.length ?? 0}/${clubTournamentData?.numberOfPlayers}',
          style: AppStyles.h5(),
        ),
        SizedBox(height: 6.h),
        Text('Start Date : ${clubTournamentData?.date}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Start Time : ${clubTournamentData?.time}', style: AppStyles.h5()),
        SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: AppButton(
                width: 100.w,
                onTab: () {
                  _showGaggleDetailsBottomSheet(context);
                },
                text: 'Rules',
                height: 50.h,
              ),
            ),
            // horizontalSpacing(8.w),
            // Flexible(
            //   flex: 2,
            //   fit: FlexFit.loose,
            //   child: AppButton(
            //       textStyle: AppStyles.h5(),
            //       onTab: () {},
            //       text: 'Player ${clubTournamentData?.tournamentPlayersList?.length ?? 0}/${clubTournamentData?.numberOfPlayers}',
            //       height: 50.h),
            // ),
            horizontalSpacing(8.w),
            if (clubTournamentData?.distanceToUser != null && clubTournamentData!.distanceToUser! < 61.0 || myProfile.role=='supperUser' || myProfile.role=='basicUser')
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child:  Obx(() {
                  return CustomButton(
                    loading: _requestToPlayController.isLoading[index]??false,
                    onTap: () async{
                      if (clubTournamentData != null) {
                       await _requestToPlayController.request(tournamentId: clubTournamentData?.sId, tournamentType: 'big', index: index);
                      }
                    },
                    text: 'Request to play',
                    height: 45.h,
                  );
                }),
              ),
          ],
        ),
      ],
    );
  }

  void _showGaggleDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GaggleRules();
      },
    );
  }
}

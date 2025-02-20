import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/home/controllers/request_to_play_controller.dart';
import 'package:golf_game_play/app/modules/home/model/small_tournament_model.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

import 'gaggle_rules.dart';

class SmallTournamentCard extends StatelessWidget {
  final SmallTournamentData? smallTournamentData;
  final int index;

    SmallTournamentCard({super.key, required this.smallTournamentData, required this.index});

   final RequestSendToPlayController _requestToPlayController = Get.put(RequestSendToPlayController( ));

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      cardWidth: 350,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tournament : ${smallTournamentData?.tournamentName}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Type : ${smallTournamentData?.tournamentType}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Location : ${smallTournamentData?.courseName} ', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Players :  ${smallTournamentData?.tournamentPlayersList?.length ?? 0}/${smallTournamentData?.numberOfPlayers}',
          style: AppStyles.h5(),
        ),
        SizedBox(height: 6.h),
        Text('Start Date : ${smallTournamentData?.date}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Start Time : ${smallTournamentData?.time}', style: AppStyles.h5()),
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
            //     flex: 2,
            //     fit: FlexFit.loose,
            //     child: AppButton(
            //         width: 100.w,
            //         onTab: () {},
            //         text:
            //             'Player ${smallTournamentData?.tournamentPlayersList?.length ?? 0}/${smallTournamentData?.numberOfPlayers}',
            //         height: 50.h),
            // ),
            horizontalSpacing(8.w),
            if (smallTournamentData?.distanceToUser != null && smallTournamentData!.distanceToUser! < 61.0 )
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Obx(() {
                  return CustomButton(
                    loading: _requestToPlayController.isLoading[index]??false,
                    onTap: () async {
                      if (smallTournamentData != null) {
                       await _requestToPlayController.request(tournamentId: smallTournamentData?.sId, tournamentType: 'small', index: index);
                      }
                    },
                    text:'Request to play',
                    height: 50.h,
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

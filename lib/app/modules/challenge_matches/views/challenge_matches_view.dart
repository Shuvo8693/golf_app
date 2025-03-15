import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/challenge_matches/controllers/challenge_matches_controller.dart';
import 'package:golf_game_play/app/modules/challenge_matches/controllers/challenge_remove_controller.dart';
import 'package:golf_game_play/app/modules/challenge_matches/widgets/challenge_matchPlayer_details.dart';
import 'package:golf_game_play/app/modules/tournament_detail/model/tournament_detail_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/delete_alert_dialogue.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

import '../model/challenge_match_model.dart';

class ChallengeMatchesView extends StatefulWidget {
  const ChallengeMatchesView({super.key});

  @override
  State<ChallengeMatchesView> createState() => _ChallengeMatchesViewState();
}

class _ChallengeMatchesViewState extends State<ChallengeMatchesView> {
  final ChallengeMatchesController _challengeMatchesController= Get.put(ChallengeMatchesController());
  final ChallengeRemoveController _challengeRemoveController =Get.put(ChallengeRemoveController());

  TournamentDetailAttributes? tournamentDetailAttributes;
  String? userId;
  @override
  void initState() {
    super.initState();
    if(Get.arguments !=null){
      getTournamentDetails();
    }
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      await getMyId();
      await _challengeMatchesController.fetchMatches(tournamentDetailAttributes!.typeName!, tournamentDetailAttributes!.sId!);

    });

  }

  getTournamentDetails(){
    final tournamentDetails = Get.arguments['tournamentDetailsAttributes'] as TournamentDetailAttributes;
    tournamentDetailAttributes = tournamentDetails;
  }

  getMyId()async{
    final id = await PrefsHelper.getString('userId');
    if(id.isNotEmpty){
      setState(() {
        userId = id;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.challengeMatchText,
          style: AppStyles.h2(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if(tournamentDetailAttributes?.tournamentCreator?.sId==userId)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: CustomButton(
                width: 100.w,
                  height: 45.h,
                  onTap: (){
                    if(tournamentDetailAttributes !=null){
                      Get.toNamed(Routes.CREATE_CHALLENGE,arguments: {'tournamentDetails':tournamentDetailAttributes});
                    }

              }, text: 'Create Challenge'),
            ),
          ),
          SizedBox(height: 8,),
          Obx((){
            List<ChallengeMatchAttributes>  matchList = _challengeMatchesController.challengeMatchModel.value.data?.attributes??[];
            if(_challengeMatchesController.isLoading1.value){
              return Center(child: CircularProgressIndicator());
            }
            if(matchList.isEmpty){
              Center(child: Text('Player Challenges is Empty'));
            }
            return  Expanded(
              child: ListView.builder(
                itemCount: matchList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                 final matchItemIndex = matchList[index];
                  return  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: CustomCard(
                      cardColor: AppColors.primaryColor,
                      children: [
                        /// >>>>This Delete Button only visible to Tournament creator <<<<
                        /// Delete Button
                        if(tournamentDetailAttributes?.tournamentCreator?.sId==userId)
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final challengeId = matchItemIndex.id;
                                  if(challengeId != null && challengeId.isNotEmpty){
                                    return DeleteAlertDialogue(
                                      callback: () async{
                                        Get.back();
                                       await _challengeRemoveController.removeChallenge(challengeId, (){
                                         _challengeMatchesController.challengeMatchModel.value.data?.attributes?.removeAt(index);
                                         _challengeMatchesController.challengeMatchModel.refresh();
                                         setState(() {});
                                        });
                                    },);
                                  }else{
                                    return Text('Challenge id not found');
                                  }
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: SvgPicture.asset(
                                AppIcons.deleteLogo,
                                height: 20.h,
                                colorFilter: ColorFilter.mode(
                                    AppColors.dark2Color, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        ///Challenge player card
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //player 1
                            ChallengeMatchPlayerDetails(
                              imageUrl: '${ApiConstants.imageBaseUrl}/${matchItemIndex.player1?.image?.url}',
                              playerName: '${matchItemIndex.player1?.name}',
                              playerHandicap: '${matchItemIndex.player1?.clubHandicap!.isNotEmpty==true? matchItemIndex.player1?.clubHandicap :matchItemIndex.player1?.handicap}',
                            ),
                            Text(
                              AppString.vsText,
                              style: AppStyles.h1(),
                            ),
                            //player 2
                            ChallengeMatchPlayerDetails(
                              imageUrl: '${ApiConstants.imageBaseUrl}/${matchItemIndex.player2?.image?.url}',
                              playerName: '${matchItemIndex.player2?.name}',
                              playerHandicap: '${matchItemIndex.player2?.clubHandicap!.isNotEmpty==true? matchItemIndex.player2?.clubHandicap :matchItemIndex.player2?.handicap}',
                            ),
                          ],
                        ),
                        verticalSpacing(25.h),
                        Container(
                          decoration: BoxDecoration(color: AppColors.black),
                          padding: EdgeInsets.all(5.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                children: [
                                  Icon(Icons.location_pin,color: AppColors.white,size: 18.sp,),
                                  horizontalSpacing(6.w),
                                  SizedBox(
                                      width: 170.w,
                                      child: Text('${matchItemIndex.courseName}',softWrap: true,overflow: TextOverflow.fade,style: AppStyles.h5(color: AppColors.white),)),
                                ],
                              ),
                              //VerticalDivider(width: 5.w,color: Colors.redAccent,),
                              SizedBox(width: 8.w,),
                              Expanded(child: Text('${matchItemIndex.date}\n  ${matchItemIndex.time}',maxLines: 2,overflow: TextOverflow.ellipsis,style: AppStyles.h5(color: AppColors.primaryColor),)),

                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }

          ),
        ],
      ),
    );
  }
}

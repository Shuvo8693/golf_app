import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/winners/controllers/winners_confirmation_controller.dart';
import 'package:golf_game_play/app/modules/winners/controllers/winners_controller.dart';
import 'package:golf_game_play/app/modules/winners/model/winner_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class WinnersView extends StatefulWidget {
   const WinnersView({super.key});

  @override
  State<WinnersView> createState() => _WinnersViewState();
}

class _WinnersViewState extends State<WinnersView> {
final WinnersController _winnersController = Get.put(WinnersController());
final WinnersConfirmationController _confirmationController=Get.put(WinnersConfirmationController());
String? completeTourId;
String? tournamentCreatorId;
String? myId;
@override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((__)async{
      if(Get.arguments != null){
        getCompleteTourId();
        await getMyId();
      }else{
        return;
      }
      await _winnersController.fetchWinner(completeTourId!);
    });
  }

  getCompleteTourId(){
    String id = Get.arguments['completedTournamentId'];
    String creatorId = Get.arguments['tournamentCreator'];
    setState(() {
      completeTourId = id;
      tournamentCreatorId = creatorId;
    });
   }

   getMyId()async{
    String  id = await PrefsHelper.getString('userId');
    setState(() {
      myId = id;
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.winnerDetailText, style: AppStyles.h2()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              if(myId==tournamentCreatorId)
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  text: AppString.addWinnerText,
                  onTab: ()async {
                    if(completeTourId !=null){
                     await PrefsHelper.setString('completeTourID', completeTourId);
                      Get.toNamed(Routes.CREATE_WINNER_DETAILS);
                    }
                  },
                ),
              ),
              Obx(() {
                WinnerAttributes? winnerAttributes= _winnersController.winnerModel.value.data?.attributes;
                if(_winnersController.isLoading.value){
                  return Center(child: CircularProgressIndicator());
                }
                if(winnerAttributes == null || winnerAttributes.kps!.isEmpty
                    && winnerAttributes.skin!.isEmpty
                    && winnerAttributes.playerScore!.isEmpty
                    && winnerAttributes.chalangeMatch!.isEmpty){
                  return Text('Winner result is empty',style: AppStyles.h4(),);
                }
                return Column(
                  children: [
                    SizedBox(height: 15.h),
                    buildSkin(winnerAttributes.skin??[]),
                    SizedBox(height: 15.h),
                    buildKps(winnerAttributes.kps??[]),
                    SizedBox(height: 15.h),
                    buildChallengeMatch(winnerAttributes.chalangeMatch??[]),
                    SizedBox(height: 15.h),
                    buildPlayerScores(winnerAttributes.playerScore??[]),
                    SizedBox(height: 15.h),
                    if(myId==tournamentCreatorId)
                      Obx(() {
                        return CustomButton(
                          loading: _confirmationController.isLoading.value,
                            onTap: () async {
                              if (completeTourId != null &&
                                  completeTourId!.isNotEmpty) {
                                await _confirmationController.confirm(completeTourId!);
                              }
                            },
                            text: 'Confirm Winners');
                      }),
                    SizedBox(height: 15.h),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  CustomCard buildSkin(List<Skin> skin) {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.skinsText, style: AppStyles.h2()),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: skin.length,
            itemBuilder: (BuildContext context, int index) {
             final skinIndex = skin[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                          child: Text('${skinIndex.skinWinner?.name}', overflow: TextOverflow.ellipsis,style: AppStyles.h5())),
                      SizedBox(width: 20.w),
                      Text('Hole : ${skinIndex.skinHole}', style: AppStyles.h6()),
                      SizedBox(width: 20.w),
                      Expanded(
                          flex: 2,
                          child: Text('${skinIndex.skinScore}',overflow: TextOverflow.ellipsis,maxLines: 2, style: AppStyles.h6())),
                      SizedBox(width: 20.w),
                      CustomCard(
                        padding: 4,
                        isRow: true,
                        cardColor: AppColors.primaryColor,
                        children: [
                          Text('\$${skinIndex.skinPaidAmount??0}', style: AppStyles.h6()),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: (){
                              Get.toNamed(Routes.EDIT_WINNER_SKIN,arguments: {'skinItem':skinIndex});
                            },
                              child: SvgPicture.asset(AppIcons.editLogo,height: 20.h,))
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }

  CustomCard buildKps(List<Kps> kps) {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.kpsText, style: AppStyles.h2()),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: kps.length,
            itemBuilder: (BuildContext context, int index) {
              final kpsIndex  = kps[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                          child: Text(' ${kpsIndex.kpsWinner?.name}',overflow: TextOverflow.ellipsis, style: AppStyles.h5())),
                      SizedBox(width: 20.w),
                      Expanded(child: Text('Hole : ${kpsIndex.kpsHole}', style: AppStyles.h5())),
                      SizedBox(width: 20.w),
                      Expanded(
                          flex: 2,
                          child: Text('${kpsIndex.kpsFeet} feet', style: AppStyles.h5())),
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }

  CustomCard buildChallengeMatch(List<ChalangeMatch> challenge) {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.challengeMatchText, style: AppStyles.h2()),
        ),
        Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text('${challenge.first.challengeWinner?.name} ',overflow: TextOverflow.ellipsis, style: AppStyles.h5())),
                    Expanded(
                        flex: 1,
                        child: Text('Vs',overflow: TextOverflow.ellipsis, style: AppStyles.h3())),

                    Expanded(
                      flex: 2,
                        child: Text('${challenge.first.challengeLoser?.name}',overflow: TextOverflow.ellipsis, style: AppStyles.h5())),
                    SizedBox(width: 20.w),
                    Expanded(
                      flex: 1,
                        child: Text('${challenge.first.winnerRound} - ${challenge.first.loserRound}', style: AppStyles.h5())),
                  ],
                ),
                SizedBox(height: 6.h),
              ],
            )),
        SizedBox(height: 6.h),
      ],
    );
  }

  CustomCard buildPlayerScores(List<PlayerScore> playerScore) {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: 0,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 5.w),
          child: Text(AppString.playerScoreText, style: AppStyles.h2()),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: playerScore.length,
            itemBuilder: (BuildContext context, int index) {
              GlobalKey buttonKey=GlobalKey();
             final playerIndex = playerScore[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(' ${playerIndex.name?.name}',overflow: TextOverflow.ellipsis, style: AppStyles.h5())),
                      SizedBox(width: 20.w),
                      InkWell(
                        key: buttonKey,
                        onTap: (){
                          buildPopUpMenu(buttonKey, playerIndex.name?.teeBox??'', context);
                        }, child: Text('TeeBox ▼ ', style: AppStyles.h5())),
                      SizedBox(width: 20.w),
                      Expanded(child: Text('Score: ${playerIndex.score}', style: AppStyles.h5())),
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }

  buildPopUpMenu(GlobalKey buttonKey,String teeBox, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      RenderBox currentRenderObject = buttonKey.currentContext?.findRenderObject() as RenderBox;
      final buttonPosition = currentRenderObject.localToGlobal(Offset.zero);
      Map<String,Color> teeBoxData = _winnersController.teeBoxItem;
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(buttonPosition.dx.w, buttonPosition.dy.h -20.h, buttonPosition.dx.w, buttonPosition.dy.h),
        items: [
          PopupMenuItem(
          child: CustomCard(
            cardHeight: 50,
              cardWidth: 50,
              cardColor: teeBoxData[teeBox],
              children: []
          ),
        )],
      );
    });
  }
}

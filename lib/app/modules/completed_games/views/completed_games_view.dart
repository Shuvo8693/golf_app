import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/completed_games/model/complete_game_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

import '../controllers/completed_games_controller.dart';

class CompletedGamesView extends StatelessWidget {
   CompletedGamesView({super.key});

  final CompletedGamesController _completedGamesController = Get.put(CompletedGamesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(AppString.completedTournamentText, style: AppStyles.h1()),
              ),
            /*  SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      filColor: AppColors.grayLight,
                      contentPaddingVertical: 20.h,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search_outlined,
                          size: 25,
                        ),
                      ),
                      hintText: 'Search...',
                      controller: _completedGamesController.searchCtrl,
                      onChange: (value) {},
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () {},
                    child: CustomCard(
                        cardColor: AppColors.grayLight,
                        borderSideColor: AppColors.primaryColor,
                        cardHeight: 75,
                        cardWidth: 100,
                        padding: 18,
                        children: [
                          Text('Search', style: AppStyles.h4(),
                          )
                        ],
                    ),
                  )
                ],
              ),*/
              SizedBox(height: 30.h),
              Obx((){
                List<CompleteTournamentAttributes> completeTournamentsAttributes =_completedGamesController.completeTournamentModel.value.data?.attributes??[];
                if(_completedGamesController.isLoading1.value){
                  return Center(child: CircularProgressIndicator());
                } else if(completeTournamentsAttributes.isEmpty){
                  return Center(child: Text('No completed Tournament available'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: completeTournamentsAttributes.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                     final completeTournamentIndex = completeTournamentsAttributes[index];
                      return  CustomCard(
                        cardWidth: double.infinity,
                        borderSideColor:  AppColors.primaryColor.withOpacity(0.4),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${AppString.tournamentText} : ${completeTournamentIndex.clubName??completeTournamentIndex.tournamentName}', style: AppStyles.h4()), SizedBox(height: 10.h),
                              SizedBox(height: 7.h),
                              Text('${AppString.tournamentTypeText} :  ${completeTournamentIndex.tournamentType}', style: AppStyles.h4()), SizedBox(height: 10.h),
                              SizedBox(height: 7.h),
                              Text('${AppString.dateAndTimeText} : ${completeTournamentIndex.date} ${completeTournamentIndex.time}', style: AppStyles.h4()), SizedBox(height: 10.h),
                              SizedBox(height: 7.h),
                              Text('${AppString.locationText} : ${completeTournamentIndex.courseName}', style: AppStyles.h4()), SizedBox(height: 10.h),

                              Row(
                                children: [
                                  if(completeTournamentIndex.isWinnerView == true || completeTournamentIndex.tournamentCreator == _completedGamesController.myId)
                                  AppButton(
                                    text: AppString.winnerText,
                                    onTab: (){
                                    Get.toNamed(Routes.WINNERS,arguments: {'completedTournamentId':completeTournamentIndex.sId,'tournamentCreator': completeTournamentIndex.tournamentCreator});
                                  },isIconWithTextActive: true,iconPath: AppIcons.winnerLogo,),
                                  /*  SizedBox(width: 8.h),
                               AppButton(text:  AppString.chatText, onTab: ()=>_showChatBottomSheet(context),isIconWithTextActive: true,iconPath: AppIcons.chatLogo,),*/
                                  //  SizedBox(width: 8.h),
                                  // AppButton(text:  AppString.editText, onTab: (){},isIconWithTextActive: true,iconPath: AppIcons.editLogo,),
                                  // SizedBox(width: 8.h),
                                  // AppButton(text:  AppString.deleteText, onTab: (){},isIconWithTextActive: true,iconPath: AppIcons.deleteLogo,),
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }

              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
   void _showChatBottomSheet(BuildContext context) {
     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Padding(
           padding: EdgeInsets.all(8.0.sp),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   IconButton(
                     icon: Icon(Icons.close),
                     onPressed: () {
                       Navigator.pop(context); // Dismiss the bottom sheet
                     },
                   ),
                 ],),

               Padding(
                 padding: EdgeInsets.symmetric(vertical: 10.h),
                 child: Text(' Spring Swing Classic', style: AppStyles.h2()),
               ),

               CustomCard(
                 cardWidth: double.infinity,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: 8.h),
                   Text('${AppString.nameText} : Stan1 ', style: AppStyles.h4()), SizedBox(height: 10.h),
                   SizedBox(height: 7.h),
                   Text('${AppString.handicapText} : 4', style: AppStyles.h4()), SizedBox(height: 10.h),
                   SizedBox(height: 7.h),
                   Text('${AppString.scoreText} : 72', style: AppStyles.h4()), SizedBox(height: 10.h),
                   SizedBox(height: 20.h),
                   AppButton(text: AppString.sendText, onTab: (){},width: double.infinity,),
                   SizedBox(height: 20.h),
                 ],
               ),
             ],
           ),
         );
       },
     );
   }

}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/tournament_detail/controllers/gaggle_detail_controller.dart';
import 'package:golf_game_play/app/modules/tournament_detail/controllers/tournament_completion_status.dart';
import 'package:golf_game_play/app/modules/tournament_detail/model/tournament_detail_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class GaggleDetailView extends StatefulWidget {
   GaggleDetailView({super.key});

  @override
  State<GaggleDetailView> createState() => _GaggleDetailViewState();
}

class _GaggleDetailViewState extends State<GaggleDetailView> {
  final GaggleDetailController _gaggleDetailController = Get.put(GaggleDetailController());

  final TournamentCompletionStatus _tournamentCompletionStatus =Get.put(TournamentCompletionStatus());
 bool? isActive;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.tournamentDetailText,style: AppStyles.h2(),),
      centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Obx((){
            final tournamentDetailAttributes =_gaggleDetailController.tournamentDetailModel.value.data?.attributes;
            if(_gaggleDetailController.isLoading.value){
              return Center(child: CircularProgressIndicator());
            } else if(tournamentDetailAttributes ==null){
              return Center(child: Text('Tournament Details are empty'));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Tournament Completion status',style: AppStyles.h5(),),
                    trailing: Switch(
                        value:isActive ?? tournamentDetailAttributes.isCompleted! ,
                        activeColor: AppColors.primaryColor,
                        onChanged: (value) async {
                          if (value) {
                            await _tournamentCompletionStatus.changeStatus(tournamentDetailAttributes.sId!, tournamentDetailAttributes.typeName!,(){
                              setState(() {
                                isActive =true;
                              });
                              print(isActive);
                            });
                          }
                        })
                    ),

                  CustomCard(
                    children: [
                      CustomNetworkImage(
                        imageUrl: '${ApiConstants.imageBaseUrl}/${tournamentDetailAttributes.tournamentImage?.url}',
                        height: 180.h,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        height: 260.h,
                        child: GridView(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'User name : ${tournamentDetailAttributes.tournamentCreator?.name}',
                                            style: AppStyles.h5()),
                                        SizedBox(height: 6.h),
                                        Text('Gaggle : ${tournamentDetailAttributes.clubName??tournamentDetailAttributes.tournamentName}',
                                            style: AppStyles.h5()),
                                        SizedBox(height: 6.h),
                                        Text('Type : ${tournamentDetailAttributes.tournamentType}', style: AppStyles.h5()),
                                        // SizedBox(height: 6.h),
                                        // Text('Tee Time : 00:00', style: AppStyles.h5()),
                                        SizedBox(height: 6.h),
                                        Text('Location : ${tournamentDetailAttributes.courseName} ',
                                            style: AppStyles.h5()),
                                      ],
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: 2,
                                  color: AppColors.grayLight,
                                  endIndent: 12,
                                  thickness: 2,
                                ),
                                Expanded(
                                  child: ListTile(
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppButton(
                                            onTab: () {
                                              _showAppRovedPlayerBottomSheet(context,tournamentDetailAttributes.tournamentPlayersList??[]);
                                            },
                                            text: 'Players : ${tournamentDetailAttributes.tournamentPlayersList?.length}/${tournamentDetailAttributes.numberOfPlayers}',
                                            height: 50.h),
                                        SizedBox(height: 6.h),
                                        Text('Start Date : ${tournamentDetailAttributes.date}',
                                            style: AppStyles.h5()),
                                        SizedBox(height: 6.h),
                                        Text('Start Time : ${tournamentDetailAttributes.time}',
                                            style: AppStyles.h5(fontSize: 12)),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ///=====Request to Play button=====
                      AppButton(
                          onTab: () {
                            Get.toNamed(Routes.MESSAGE_INBOX);
                          },
                          text: 'Chat with ${tournamentDetailAttributes.tournamentCreator?.name}',
                          height: 50.h),
                      SizedBox(height: 10.h) ,

                      ///=====Tee button=====
                      AppButton(
                          onTab: () {
                            Get.toNamed(Routes.TEE_SHEET);
                          },
                          text: AppString.teeSheetText,
                          height: 50.h),
                      SizedBox(height: 10.h)
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomButton(
                      onTap: () {
                        Get.toNamed(Routes.MESSAGE_INBOX);
                      }, text: 'Group Chat'),

                  SizedBox(height: 16.h),
                  CustomButton(
                      onTap: () {
                        Get.toNamed(Routes.CHALLENGE_MATCHES);
                      }, text: AppString.challengeMatchesText),
                  SizedBox(height: 10.h),
                ],
              ),
            );
          }

          ),
        ),
      ),
    );
  }

  void _showAppRovedPlayerBottomSheet(BuildContext context,List<TournamentPlayersList> playerList) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // To shrink the bottom sheet to fit content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title with Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Close Icon at the Top-right Corner
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
              // Content of Bottom Sheet
              SizedBox(height: 10.h),
              Text(AppString.approvedPlayerText, style: AppStyles.h2()),
              SizedBox(height: 20.h),
              ...playerList.map((player) => CustomCard(
                isRow: true,
                cardWidth: double.infinity,
                borderSideColor: AppColors.primaryColor.withOpacity(0.5),
                children: [
                  Text('${player.name}'),
                  SizedBox(width: 8.h),
                  Text('HCP : ${ player.clubHandicap ?? player.handicap}')
                ],
                ),
              ),

              SizedBox(height: 8.h),

            ],
          ),
        );
      },
    );
  }
}

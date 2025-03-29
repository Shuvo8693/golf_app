import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/my_tournament/controllers/my_tournament_controller.dart';
import 'package:golf_game_play/app/modules/my_tournament/model/my_tournaments_modal.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_drawer/app_drawer.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';
import 'package:intl/intl.dart';

class MyTournamentView extends StatefulWidget {
  const MyTournamentView({super.key});

  @override
  State<MyTournamentView> createState() => _MyTournamentViewState();
}

class _MyTournamentViewState extends State<MyTournamentView> {
  final MyTournamentController _myTournamentController = Get.put(MyTournamentController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      await _myTournamentController.fetchJoinedTournament();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(2),
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GolfLogo(imageSize: 40),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Text(AppString.myTournamentText, style: AppStyles.h1()),
            SizedBox(height: 20.h),
            Obx((){
              List<MyTournamentAttributes> myTournamentAttributes =_myTournamentController.myTournamentModel.value.data?.attributes??[];
              if(_myTournamentController.isLoading.value){
                return Center(child: CircularProgressIndicator());
              } else if(myTournamentAttributes.isEmpty){
                return Center(child: Text('No tournament available',style: AppStyles.h5(),));
              }
              return  Expanded(
                child: ListView.builder(
                  itemCount: myTournamentAttributes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final myTournamentAttributesIndex  = myTournamentAttributes[index];
                    return buildMyTournament(context,myTournamentAttributesIndex);
                  },
                ),
              );
            }

            )
          ],
        ),
      ),
    );
  }

  CustomCard buildMyTournament(BuildContext context,MyTournamentAttributes myTournamentsAttributes) {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User Name : ${myTournamentsAttributes.tournamentCreator?.name}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Tournament : ${myTournamentsAttributes.tournamentName?? myTournamentsAttributes.clubName}', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Date & time: ${myTournamentsAttributes.date}, ${myTournamentsAttributes.time}', style: AppStyles.h5()),
        // SizedBox(height: 6.h),
        // Text('Tee Time : 00:00:00', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Location : ${myTournamentsAttributes.courseName} ', style: AppStyles.h5()),
        // SizedBox(height: 6.h),
        // Text('Group: 1, 2 ', style: AppStyles.h5()),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: AppButton(
              text: 'Tournament home page',
              onTab: () {
                Get.toNamed(Routes.TOURNAMENT_DETAIL,arguments: {'myTournamentId':myTournamentsAttributes.sId,'tournamentType':myTournamentsAttributes.typeName});
              },
            ),
          ),
        ),
       /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 5,
              children: [
                Text('Player :', style: AppStyles.h5()),
                SizedBox(width: 6.h),
                SizedBox(
                  width: 150.w,
                  height: 28.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _myTournamentController.players.length,
                    itemBuilder: (BuildContext context, int index) {
                      GlobalKey buttonKey = GlobalKey();
                      final player = _myTournamentController.players[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 6.w),
                        child: AppButton(
                          key: buttonKey,
                          text: player,
                          onTab: () {
                            RenderBox currentRenderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
                            final buttonPosition = currentRenderBox.localToGlobal(Offset.zero);
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                buttonPosition.dx,
                                buttonPosition.dy - 40,
                                120.w,
                                0,
                              ),
                              items: [
                                PopupMenuItem(
                                  height: 20,
                                  value: 'UserInfo',
                                  child: Text(
                                    'Test popup',
                                    style: AppStyles.h4(),
                                  ),
                                )
                              ],
                            );
                          },
                          containerVerticalPadding: 0,
                        ),
                      );
                    },
                  ),
                )

                // AppButton(
                //   text: 'B',
                //   onTab: () {},
                //   containerVerticalPadding: 0,
                // ),
                // AppButton(
                //   text: 'C',
                //   onTab: () {},
                //   containerVerticalPadding: 0,
                // ),
                // AppButton(
                //   text: 'D',
                //   onTab: () {},
                //   containerVerticalPadding: 0,
                // ),
              ],
            ),

          ],
        )*/

      ],
    );
  }
}

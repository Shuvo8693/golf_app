import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/my_tournament/controllers/my_tournament_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_drawer/app_drawer.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';

class MyTournamentView extends StatelessWidget {
  MyTournamentView({super.key});

  final MyTournamentController _myTournamentController =
      Get.put(MyTournamentController());

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
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return buildMyTournament(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  CustomCard buildMyTournament(BuildContext context) {
    return CustomCard(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User Name : Stan1', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Tournament : Booz', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Date & time: May 29, 2024 10:00 AM', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Tee Time : 00:00:00', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Location : Lorem ipsum dolor sit, consectetur elit, sed doadipisicing eiusmod tempor ', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Group: 1, 2 ', style: AppStyles.h5()),
        Row(
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
            AppButton(
              text: 'Details',
              onTab: () {
                Get.toNamed(Routes.TEE_SHEET);
              },
            ),
          ],
        )
      ],
    );
  }
}

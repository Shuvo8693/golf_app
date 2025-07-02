import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/top50/controllers/top50_controller.dart';
import 'package:golf_game_play/app/modules/top50/model/top_50_player_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_drawer/app_drawer.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';

class Top50View extends StatelessWidget {
  Top50View({super.key});

  final Top50Controller _top50controller = Get.put(Top50Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(4),
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GolfLogo(imageSize: 40),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(AppString.top50PlayerText, style: AppStyles.h1()),
                ),
               /* SizedBox(height: 12.h),
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
                        controller: _top50controller.searchCtrl,
                        onChange: (value) {},
                      ),
                    ),
                    SizedBox(width: 6.h),
                    GestureDetector(
                      onTap: () {},
                      child: CustomCard(
                          cardColor: AppColors.grayLight,
                          borderSideColor: AppColors.primaryColor,
                          cardHeight: 75,
                          cardWidth: 100,
                          padding: 18,
                          children: [
                            Text(
                              'Search',
                              style: AppStyles.h4(),
                            )
                          ],),
                    )
                  ],
                ),*/
                SizedBox(height: 30.h),
                Text(AppString.top3PlayerText, style: AppStyles.h1()),
                Obx((){
                  List<Top50GolferAttributes> top50GolferAttributes=_top50controller.top50GolfersModel.value.data?.attributes??[];
                  if(_top50controller.isLoading.value){
                    return Center(child: CircularProgressIndicator());
                  } else if(top50GolferAttributes.isEmpty){
                    return Center(child: Text('Top Golfers are not available at your area'));
                  }
                  return SizedBox(
                    height: 320.h,
                    child: ListView.builder(
                      itemCount: top50GolferAttributes.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final top50GolferAttributesIndex = top50GolferAttributes[index];
                        if (index < 3) {
                          return CustomCard(
                            cardWidth: double.infinity,
                            borderSideColor: AppColors.gray,
                            cardColor: AppColors.primaryColor.withOpacity(0.8),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                    top: 5.h,
                                    left: 150.w,
                                    child: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            tileMode: TileMode.mirror,
                                            stops: [
                                              0.4,
                                              0.5,
                                              0.7
                                            ],
                                            colors: [
                                              Colors.lightGreenAccent,
                                              Colors.orange.withOpacity(0.7),
                                              Colors.green,
                                            ],
                                        ).createShader(bounds);
                                      },
                                      child: Text(
                                        '',
                                        style: AppStyles.h1(
                                            fontSize: 80.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${AppString.nameText} : ${top50GolferAttributesIndex.name}',
                                            style: AppStyles.h4()),
                                        SizedBox(height: 8.h),
                                        Text(
                                            '${AppString.handicapText} : ${top50GolferAttributesIndex.handicap}',
                                            style: AppStyles.h4()),
                                        // SizedBox(height: 8.h),
                                        // Text('${AppString.cityText} : ${top50GolferAttributesIndex.city}',
                                        //     style: AppStyles.h4()),
                                        // SizedBox(height: 8.h),
                                        // Text('${AppString.pointText} : 9.2',
                                        //     style: AppStyles.h4()),
                                        SizedBox(height: 8.h),
                                        Text(
                                            '${AppString.tournamentText} : ${top50GolferAttributesIndex.clubName}',
                                            style: AppStyles.h4()),
                                        SizedBox(height: 10.h),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  );
                }

                ),
                SizedBox(height: 25.h),
                Text(AppString.top4To50PlayersText, style: AppStyles.h1()),
                SizedBox(height: 8.h),
                Obx((){
                  List<Top50GolferAttributes> top50GolferAttributes=_top50controller.top50GolfersModel.value.data?.attributes??[];
                  if(_top50controller.isLoading.value){
                    return Center(child: CircularProgressIndicator());
                  } else if(top50GolferAttributes.isEmpty){
                    return Center(child: Text('Top Golfers are not available at your area'));
                  }
                  return SizedBox(
                    height: 300.h,
                    child: ListView.builder(
                      itemCount: top50GolferAttributes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final top50GolferAttributesIndex = top50GolferAttributes[index];
                        if(index > 2){
                          return  CustomCard(
                            borderSideColor: AppColors.primaryColor.withOpacity(0.5),
                            isRow: true,
                            children: [
                              Text('${AppString.nameText} : ${top50GolferAttributesIndex.name}', style: AppStyles.h3()),
                              SizedBox(width: 8.h),
                              Text('${AppString.handicapText} : ${top50GolferAttributesIndex.handicap}',
                                  style: AppStyles.h3()),
                              // SizedBox(width: 8.h),
                              // Text('${AppString.pointText} : 9.2', style: AppStyles.h3()),
                            ],
                          );
                        }else{
                          return SizedBox.shrink();
                        }

                      },

                    ),
                  );
                }

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

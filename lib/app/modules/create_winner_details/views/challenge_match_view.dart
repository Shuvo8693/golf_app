import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/create_winner_details/controllers/create_winner_details_controller.dart';
import 'package:golf_game_play/app/modules/create_winner_details/model/player_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/custom_drop_down_field/custom_dropdown_field.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class TopWinnerView extends StatefulWidget {
  const TopWinnerView({super.key});

  @override
  State<TopWinnerView> createState() => _TopWinnerViewState();
}

class _TopWinnerViewState extends State<TopWinnerView> {
  final CreateWinnerDetailsController _createWinnerDetailsController =
      Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      await _createWinnerDetailsController.fetchPlayer('chalangeMatch');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Winner', style: AppStyles.h3(family: "Schuyler")),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            await _createWinnerDetailsController.fetchPlayer('kps');
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///============Challenge Match AREA============
              ///Winner section
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(AppString.winnerNameText,
                          style: AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 210.w,
                        child: Obx(
                          () {
                            List<PlayerAttributes> playerAttributes =
                                _createWinnerDetailsController
                                        .playerModel.value.data?.attributes ??
                                    [];
                            if (playerAttributes.isEmpty) {
                              return Text('Player is empty');
                            }
                            return DropdownButtonFormField(
                                hint: Text('Select player'),
                                items: playerAttributes.map((item) {
                                  return DropdownMenuItem<PlayerAttributes>(
                                    value: item,
                                    child: Text(item.name ?? ''),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a category';
                                  }
                                  return null;
                                },
                                onChanged: (changedValue) {
                                  _createWinnerDetailsController.winnerId = changedValue?.id;
                                  print(_createWinnerDetailsController.winnerId);
                                });
                          },
                        ),
                      )
                    ],
                  ),

                  /// Winner round
                  SizedBox(width: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(AppString.roundText, style: AppStyles.h3()),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 140.w,
                        child: CustomTextField(
                          contentPaddingVertical: 15.h,
                          hintText: "",
                          controller:
                              _createWinnerDetailsController.winnerRoundCtrl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// Looser section
              SizedBox(height: 10.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(AppString.looserNameText,
                          style: AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 210.w,
                        child: Obx(
                          () {
                            List<PlayerAttributes> playerAttributes =
                                _createWinnerDetailsController.playerModel.value.data?.attributes ?? [];
                            if (playerAttributes.isEmpty) {
                              return Text('Player is empty');
                            }
                            return DropdownButtonFormField(
                                hint: Text('Select player'),
                                items: playerAttributes.map((item) {
                                  return DropdownMenuItem<PlayerAttributes>(
                                    value: item,
                                    child: Text(item.name ?? ''),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a category';
                                  }
                                  return null;
                                },
                                onChanged: (changedValue) {
                                  _createWinnerDetailsController.loserId =
                                      changedValue?.id ?? '';
                                  print(_createWinnerDetailsController.loserId);
                                });
                          },
                        ),
                      )
                    ],
                  ),

                  /// looser round
                  SizedBox(width: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(AppString.roundText, style: AppStyles.h3()),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 140.w,
                        child: CustomTextField(
                          contentPaddingVertical: 15.h,
                          hintText: "",
                          controller:
                              _createWinnerDetailsController.looserRoundCtrl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        onTap: () async{
                          if(_formKey.currentState!.validate()){
                            await _createWinnerDetailsController.postWinners('chalangeMatch');
                          }
                        }, text: AppString.saveAndContinueText),
                  ),
                  horizontalSpacing(8.w),
                  Expanded(
                    child: CustomButton(
                        onTap: () {
                          Get.toNamed(Routes.SCORE);
                        },
                        text: 'Next'),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/create_winner_details/controllers/create_winner_details_controller.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/custom_drop_down_field/custom_dropdown_field.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';


class CreateWinnerDetailsView extends StatelessWidget {
   CreateWinnerDetailsView({super.key});
  final CreateWinnerDetailsController _createWinnerDetailsController=Get.put(CreateWinnerDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.createWinnerDetailsText,style: AppStyles.h2(),),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///============SKIN AREA============
              SizedBox(height: 20.h),
              Text(AppString.skinsText, style: AppStyles.h3(family: "Schuyler")),
              ///winner name
              SizedBox(height: 10.h),
              Text(AppString.winnerNameText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.skinWinnerName = changedValue;
                  print(_createWinnerDetailsController.skinWinnerName);
                },
              ) ,
              ///winner hole
              SizedBox(height: 10.h),
              Text(AppString.holeText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.skinHole = changedValue;
                  print(_createWinnerDetailsController.skinHole);
                },
              ) ,
              ///winner score
              SizedBox(height: 10.h),
              Text('${AppString.scoreText} (Skin)', style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.skinScore = changedValue;
                  print(_createWinnerDetailsController.skinScore);
                },
              ) ,
              ///winner Amount is Paid?
              SizedBox(height: 10.h),
              Text(AppString.isAmountPaidText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.amountIsPaid,
                onChange: (changedValue){
                  _createWinnerDetailsController.skinAmountIsPaid = changedValue;
                  print(_createWinnerDetailsController.skinAmountIsPaid);
                },
              ),


              ///============KPS AREA============
              SizedBox(height: 20.h),
              Text(AppString.kpsText, style: AppStyles.h3(family: "Schuyler")),
              ///Kp name
              SizedBox(height: 10.h),
              Text(AppString.winnerNameText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.kpWinnerName = changedValue;
                  print(_createWinnerDetailsController.kpWinnerName);
                },
              ) ,
              ///Kp hole
              SizedBox(height: 10.h),
              Text(AppString.holeText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.kpHole = changedValue;
                  print(_createWinnerDetailsController.kpHole);
                },
              ) ,
              ///Kp feet
              SizedBox(height: 10.h),
              Text(AppString.feetText , style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.kpFeet = changedValue;
                  print(_createWinnerDetailsController.kpFeet);
                },
              ) ,


              ///============Challenge Match AREA============
              SizedBox(height: 20.h),
              Text(AppString.challengeMatchText, style: AppStyles.h3(family: "Schuyler")),

              ///Winner section
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(AppString.winnerNameText, style: AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 210.w,
                        child: CustomDropdownField(
                          items: _createWinnerDetailsController.categoryList,
                          onChange: (changedValue){
                            _createWinnerDetailsController.kpWinnerName = changedValue;
                            print(_createWinnerDetailsController.kpWinnerName);
                          },
                        ),
                      ),
                    ],
                  ) ,

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
                      Text(AppString.looserNameText, style: AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 210.w,
                        child: CustomDropdownField(
                          items: _createWinnerDetailsController.categoryList,
                          onChange: (changedValue){
                            _createWinnerDetailsController.kpWinnerName = changedValue;
                            print(_createWinnerDetailsController.kpWinnerName);
                          },
                        ),
                      ),
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

              ///============PLAYER SCORE AREA============
              SizedBox(height: 20.h),
              Text(AppString.playerScoreText, style: AppStyles.h3(family: "Schuyler")),
              /// name
              SizedBox(height: 10.h),
              Text(AppString.nameText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.allPlayerScore = changedValue;
                  print(_createWinnerDetailsController.allPlayerScore);
                },
              ) ,
              ///TeeBox
              SizedBox(height: 10.h),
              Text(AppString.teeBoxText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.allTeeBox = changedValue;
                  print(_createWinnerDetailsController.allTeeBox);
                },
              ) ,
              ///Score
              SizedBox(height: 10.h),
              Text(AppString.scoreText , style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.categoryList,
                onChange: (changedValue){
                  _createWinnerDetailsController.allPlayerScore = changedValue;
                  print(_createWinnerDetailsController.allPlayerScore);
                },
              ) ,

              SizedBox(height: 50.h),
              CustomButton(onTap: () {}, text: AppString.saveAndContinueText),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

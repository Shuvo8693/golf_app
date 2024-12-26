import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/custom_drop_down_field/custom_dropdown_field.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';

import '../controllers/edit_winner_skin_controller.dart';

class EditWinnerSkinView extends StatelessWidget {
   EditWinnerSkinView({super.key});
  final EditWinnerSkinController _editWinnerSkinController=Get.put(EditWinnerSkinController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.editWinnerSkinText,style: AppStyles.h2(),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                items: _editWinnerSkinController.categoryList,
                onChange: (changedValue){
                  _editWinnerSkinController.skinWinnerName = changedValue;
                  print(_editWinnerSkinController.skinWinnerName);
                },
              ) ,
              ///winner hole
              SizedBox(height: 10.h),
              Text(AppString.holeText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _editWinnerSkinController.categoryList,
                onChange: (changedValue){
                  _editWinnerSkinController.skinHole = changedValue;
                  print(_editWinnerSkinController.skinHole);
                },
              ) ,
              ///winner score
              SizedBox(height: 10.h),
              Text('${AppString.scoreText} (Skin)', style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _editWinnerSkinController.categoryList,
                onChange: (changedValue){
                  _editWinnerSkinController.skinScore = changedValue;
                  print(_editWinnerSkinController.skinScore);
                },
              ) ,
              ///winner Amount is Paid?
              SizedBox(height: 10.h),
              Text(AppString.isAmountPaidText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _editWinnerSkinController.amountIsPaid,
                onChange: (changedValue){
                  _editWinnerSkinController.skinAmountIsPaid = changedValue;
                  print(_editWinnerSkinController.skinAmountIsPaid);
                },
              ),
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

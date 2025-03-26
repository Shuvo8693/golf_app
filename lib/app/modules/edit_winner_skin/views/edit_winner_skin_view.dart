import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/winners/controllers/winners_controller.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/custom_drop_down_field/custom_dropdown_field.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

import '../controllers/edit_winner_skin_controller.dart';

class EditWinnerSkinView extends StatelessWidget {
   EditWinnerSkinView({super.key});
  final EditWinnerSkinController _editWinnerSkinController=Get.put(EditWinnerSkinController());
   final WinnersController _winnersController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.editWinnerSkinText,style: AppStyles.h2(),),
        centerTitle: true,
        leading: GestureDetector(
          onTap: ()async{
            String completeTourId = await PrefsHelper.getString('completeTourID');
            await _winnersController.fetchWinner(completeTourId);
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
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
              CustomTextField(
                contentPaddingVertical: 14.h,
                controller: _editWinnerSkinController.nameCtrl,
                isEnabled: false,
              ) ,
              ///winner hole
              SizedBox(height: 10.h),
              Text(AppString.holeText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              DropdownButtonFormField(
                  value: _editWinnerSkinController.holeList.contains(_editWinnerSkinController.skinHole )? _editWinnerSkinController.skinHole : null,
                  hint: Text('Select player'),
                  items: _editWinnerSkinController.holeList.map((item) {
                    return DropdownMenuItem<int>(
                      value: item,
                      child: Text(item.toString()),
                    );
                  }).toList(),
                  decoration: const InputDecoration(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  onChanged: (changedValue){
                    _editWinnerSkinController.skinHole = changedValue;
                    print(_editWinnerSkinController.skinHole);
                  }),

              ///winner score
              SizedBox(height: 10.h),
              Text('${AppString.scoreText} (Skin)', style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _editWinnerSkinController.skinScoreList,
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
                  _editWinnerSkinController.skinAmountIsPaid!.value = changedValue;
                  print(_editWinnerSkinController.skinAmountIsPaid);
                },
              ),

              ///amount
              Obx((){
                if(_editWinnerSkinController.skinAmountIsPaid.value=='No'){
                  return SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text('Amount in \$', style: AppStyles.h4(family: "Schuyler")),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      contentPaddingVertical: 16.h,
                      hintText: '\$',
                      keyboardType: TextInputType.number,
                      controller: _editWinnerSkinController.amountCtrl,
                    ),
                  ],
                );
              }),
              SizedBox(height: 50.h),
              Obx((){
                return CustomButton(
                  loading: _editWinnerSkinController.isLoading.value,
                    onTap: () async {
                      await _editWinnerSkinController.updateWinners();
                    }, text: AppString.saveAndContinueText);
                }
              ),
              SizedBox(height: 20.h),

            ],
          ),
        ),
      ),
    );
  }
}

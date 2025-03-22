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

class SkinView extends StatefulWidget {
   const SkinView({super.key});

  @override
  State<SkinView> createState() => _SkinViewState();
}

class _SkinViewState extends State<SkinView> {
  final CreateWinnerDetailsController _createWinnerDetailsController=Get.put(CreateWinnerDetailsController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
     await _createWinnerDetailsController.fetchPlayer('skin');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.skinsText, style: AppStyles.h3(family: "Schuyler")),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ///============SKIN AREA============
              ///winner name
              SizedBox(height: 10.h),
              Text(AppString.winnerNameText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
                Obx(() {
                  List<PlayerAttributes> playerAttributes = _createWinnerDetailsController.playerModel.value.data?.attributes ?? [];
                  if (playerAttributes.isEmpty) {
                    return Text('Player is empty');
                  }
                  PlayerAttributes?  playerValue = playerAttributes.firstWhereOrNull((value) => value.id ==_createWinnerDetailsController.skinWinnerId );
                  return DropdownButtonFormField(
                    value: playerValue,
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
                        _createWinnerDetailsController.skinWinnerId = changedValue?.id ?? '';
                            print(_createWinnerDetailsController.skinWinnerId);
                      });
                }),

                ///winner hole
              SizedBox(height: 10.h),
              Text(AppString.holeText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              DropdownButtonFormField(
                value: _createWinnerDetailsController.holeList.contains(_createWinnerDetailsController.skinHole )? _createWinnerDetailsController.skinHole : null,
                  hint: Text('Select player'),
                  items: _createWinnerDetailsController.holeList.map((item) {
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
                        _createWinnerDetailsController.skinHole = changedValue;
                        print(_createWinnerDetailsController.skinHole);
                  }),

              ///winner score
              SizedBox(height: 10.h),
              Text('${AppString.scoreText} (Skin)', style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomDropdownField(
                items: _createWinnerDetailsController.skinScoreList,
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
                    _createWinnerDetailsController.skinAmountIsPaid.value = changedValue;
                    print(_createWinnerDetailsController.skinAmountIsPaid);
                  },
                ),
                ///amount

                Obx((){
                   if(_createWinnerDetailsController.skinAmountIsPaid.value=='No'){
                     return SizedBox.shrink();
                   }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text('Amount', style: AppStyles.h4(family: "Schuyler")),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        contentPaddingVertical: 16.h,
                        hintText: '\$',
                        controller: _createWinnerDetailsController.amountCtrl,
                      ),
                    ],
                  );
                }

                ) ,
              SizedBox(height: 50.h),
              Row(
                children: [
                  Expanded(child: CustomButton(
                      onTap: () async{
                        if(_formKey.currentState!.validate()){
                          await _createWinnerDetailsController.postWinners('skin');
                        }
                      }, text: AppString.saveAndContinueText)),
                  horizontalSpacing(8.w),
                  Expanded(child: CustomButton(onTap: () {Get.toNamed(Routes.KPS);}, text: 'Next')),
                ],
              ),
              SizedBox(height: 20.h),
             ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _createWinnerDetailsController.dispose();
    super.dispose();
  }
}

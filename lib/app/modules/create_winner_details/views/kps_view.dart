import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/create_winner_details/controllers/create_winner_details_controller.dart';
import 'package:golf_game_play/app/modules/create_winner_details/model/player_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/custom_drop_down_field/custom_dropdown_field.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class KpsView extends StatefulWidget {
   const KpsView({super.key});

  @override
  State<KpsView> createState() => _KpsViewState();
}

class _KpsViewState extends State<KpsView> {
  final CreateWinnerDetailsController _createWinnerDetailsController=Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      await _createWinnerDetailsController.fetchPlayer('kps');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppString.kpsText, style: AppStyles.h3(family: "Schuyler")),
        centerTitle: true,
        leading: GestureDetector(
          onTap: ()async{
            await _createWinnerDetailsController.fetchPlayer('skin');
            Get.back();
          },
            child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///============KPS AREA============
              ///Kp name
              Obx((){
                List<PlayerAttributes>  playerAttributes = _createWinnerDetailsController.playerModel.value.data?.attributes??[];
                if(playerAttributes.isEmpty){
                  return Text('Player is empty');
                }
                return  DropdownButtonFormField(
                    hint: Text('Select player'),
                    items: playerAttributes.map((item) {
                      return DropdownMenuItem<PlayerAttributes>(
                        value: item,
                        child: Text(item.name??''),
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
                      _createWinnerDetailsController.kpWinnerId = changedValue?.id??'';
                          print(_createWinnerDetailsController.kpWinnerId);
                    });
                  }
              ) ,
              ///winner hole
              SizedBox(height: 10.h),
              Text(AppString.holeText, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              DropdownButtonFormField(
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
                    _createWinnerDetailsController.kpHole = changedValue;
                    print(_createWinnerDetailsController.kpHole);
                  }),
              ///Kp feet
              SizedBox(height: 10.h),
              Text(AppString.feetText , style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              CustomTextField(
                contentPaddingVertical: 16.h,
                controller: _createWinnerDetailsController.kpFeetCtrl,
              ) ,
              SizedBox(height: 50.h),
              Row(
                children: [
                  Expanded(child: CustomButton(
                      onTap: () async{
                        if(_formKey.currentState!.validate()){
                          await _createWinnerDetailsController.postWinners('kps');
                        }
                      }, text: AppString.saveAndContinueText)),
                  horizontalSpacing(8.w),
                  Expanded(child: CustomButton(onTap: () {Get.toNamed(Routes.TOP_WINNER);}, text: 'Next')),
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

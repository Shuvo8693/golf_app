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

class ScoreView extends StatefulWidget {
   const ScoreView({super.key});

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  final CreateWinnerDetailsController _createWinnerDetailsController = Get.find();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      await _createWinnerDetailsController.fetchPlayer('playerScore');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.playerScoreText, style: AppStyles.h3(family: "Schuyler")),
        centerTitle: true,
        leading: GestureDetector(
          onTap: ()async{
            await _createWinnerDetailsController.fetchPlayer('chalangeMatch');
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
                ///============PLAYER SCORE AREA============
            /// name
            SizedBox(height: 10.h),
            Text(AppString.nameText, style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
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
                    onChanged: (changedValue) {
                      _createWinnerDetailsController.allPlayerId = changedValue?.id;
                      print(_createWinnerDetailsController.allPlayerId);
                    },);
                }
            ) ,
            ///Score
            SizedBox(height: 10.h),
            Text(AppString.scoreText , style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
            CustomTextField(
              contentPaddingVertical: 16.h,
              hintText: 'Type player score',
              controller: _createWinnerDetailsController.playerScoreCtrl,
            ) ,

            SizedBox(height: 50.h),
            CustomButton(onTap: () async {
              if( _formKey.currentState!.validate()){
                await _createWinnerDetailsController.postWinners('playerScore');
              }
            }, text: AppString.saveAndContinueText),
            SizedBox(height: 20.h),
                    ],
                  ),
          ),
      )
    );
  }
}

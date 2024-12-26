import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';

import '../controllers/create_challenge_controller.dart';

class CreateChallengeView extends StatefulWidget {
  const CreateChallengeView({super.key});

  @override
  State<CreateChallengeView> createState() => _CreateChallengeViewState();
}

class _CreateChallengeViewState extends State<CreateChallengeView> {
  final CreateChallengeController _createChallengeController=Get.put(CreateChallengeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(AppString.challengeText,
                  style: AppStyles.h1(family: "Schuyler")),
            ),
            SizedBox(height: 15.h),

            /// Tournament name
            SizedBox(height: 10.h),
            Text(AppString.tournamentNameText, style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
            DropdownButtonFormField<String>(
              /// Dropdown button field======================<<<<<<<<
              value: _createChallengeController.tournamentName,
              padding: EdgeInsets.zero,
              hint: Text("Select Tournament Name"),
              decoration: InputDecoration(),
              items: _createChallengeController.tournamentNameList.map(
                    (gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ),
              )
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select Tournament Name';
                }
                return null;
              },
              onChanged: (newValue) {
                setState(
                      () {
                        _createChallengeController.tournamentName = newValue;
                    print('Tournament Name>>>${_createChallengeController.tournamentName}');
                  },
                );
              },
            ),


            /// Player 1
            SizedBox(height: 10.h),
            Text(AppString.player1Text, style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
            DropdownButtonFormField<String>(
              /// Dropdown button field======================<<<<<<<<
              value: _createChallengeController.player1,
              padding: EdgeInsets.zero,
              hint: Text("Select Player"),
              decoration: InputDecoration(),
              items: _createChallengeController.player1List.map(
                    (gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ),
              ).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select Player';
                }
                return null;
              },
              onChanged: (newValue) {
                setState(
                      () {
                        _createChallengeController.player1= newValue;
                    print('Tournament Name>>>${_createChallengeController.player1}');
                  },
                );
              },
            ),
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.center,
              child: Text(AppString.vsText,
                  style: AppStyles.h2(family: "Schuyler")),
            ),
            SizedBox(height: 10.h),

            /// Player 2
            SizedBox(height: 10.h),
            Text(AppString.player2Text, style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
            DropdownButtonFormField<String>(
              /// Dropdown button field======================<<<<<<<<
              value: _createChallengeController.player2,
              padding: EdgeInsets.zero,
              hint: Text("Select Player"),
              decoration: InputDecoration(),
              items: _createChallengeController.player2List.map(
                    (gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ),
              ).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select Select Player';
                }
                return null;
              },
              onChanged: (newValue) {
                setState(() {
                  _createChallengeController.player2 = newValue;
                    print('Tournament Name>>>${_createChallengeController.player2}');
                  },
                );
              },
            ),
            SizedBox(height: 80.h),
           CustomButton(onTap: (){}, text: AppString.submitText)

          ],
        ),
      ),
    );
  }
}

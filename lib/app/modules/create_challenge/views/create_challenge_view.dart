import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/assign_group/model/tournament_player_list_model.dart';
import 'package:golf_game_play/app/modules/tournament_detail/model/tournament_detail_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

import '../controllers/create_challenge_controller.dart';

class CreateChallengeView extends StatefulWidget {
  const CreateChallengeView({super.key});

  @override
  State<CreateChallengeView> createState() => _CreateChallengeViewState();
}

class _CreateChallengeViewState extends State<CreateChallengeView> {
  final CreateChallengeController _createChallengeController=Get.put(CreateChallengeController());
  TournamentDetailAttributes? tournamentDetailAttributes;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      if(Get.arguments !=null){
        getTournamentDetails();
      }
      if(tournamentDetailAttributes !=null){
        await _createChallengeController.fetchTournamentPlayer(tournamentDetailAttributes!.typeName!, tournamentDetailAttributes!.sId!);
      }

    });
  }

  getTournamentDetails(){
   final tournamentDetails = Get.arguments['tournamentDetails'] as TournamentDetailAttributes;
   tournamentDetailAttributes = tournamentDetails;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(AppString.challengeText,
                    style: AppStyles.h1(family: "Schuyler")),
              ),
              /// Player 1
              SizedBox(height: 10.h),
              Text(AppString.player1Text, style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              Obx(() {
               final player1List = _createChallengeController.tournamentPlayerListModel.value.data?.attributes?.tournamentPlayersList??[];
                return DropdownButtonFormField<TournamentPlayersItemList>(
                  /// Dropdown button field======================<<<<<<<<
                  //value: _createChallengeController.player1,
                  padding: EdgeInsets.zero,
                  hint: Text("Select Player"),
                  decoration: InputDecoration(),
                  items: player1List.map(
                        (player) => DropdownMenuItem<TournamentPlayersItemList>(
                          value: player,
                          child: Text('${player.name}'),
                        ),
                      ).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Select Player';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(
                      () {
                        _createChallengeController.player1 = newValue?.id;
                        print('Tournament Name>>>${_createChallengeController.player1}');
                      },
                    );
                  },
                );
              }),
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
              Obx((){
                final player2List = _createChallengeController.tournamentPlayerListModel.value.data?.attributes?.tournamentPlayersList??[];
                return DropdownButtonFormField<TournamentPlayersItemList>(
                  /// Dropdown button field======================<<<<<<<<
                 // value: _createChallengeController.player2,
                  padding: EdgeInsets.zero,
                  hint: Text("Select Player"),
                  decoration: InputDecoration(),
                  items: player2List.map((player) => DropdownMenuItem<TournamentPlayersItemList>(
                      value: player,
                      child: Text('${player.name}'),
                    ),
                  ).toList(),
                  validator: (value) {
                    if (value == null ) {
                      return 'Select Select Player';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _createChallengeController.player2 = newValue?.id;
                      print('Tournament Name>>>${_createChallengeController.player2}');
                    },
                    );
                  },
                );
              }

              ),
              ///Date time
              SizedBox(height: 16.h),
              Text('Date time', style: AppStyles.h4(family: "Schuyler")),
              Padding(
                padding:  EdgeInsets.all(8.0.sp),
                child: Row(
                  children: [
                    /// Select Date
                    // SizedBox(height: 10.h),
                    // Text(AppString.dateText, style: AppStyles.h4(family: "Schuyler")),
                    // SizedBox(height: 10.h),
                    Obx(() => Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          _createChallengeController.selectDate(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Get.theme.primaryColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(14.r),
                              color: AppColors.fillColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_createChallengeController.selectedDate.isNotEmpty
                                    ? _createChallengeController.selectedDate.value
                                    : 'Select Date',
                                  // age(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal)
                                ),
                                SvgPicture.asset(AppIcons.calenderIcon)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ),
                    /// Time
                    SizedBox(width: 10.h),
                    // Text('Time', style: AppStyles.h4(family: "Schuyler")),
                    // SizedBox(height: 10.h),
                    Expanded(
                      child: CustomTextField(
                        contentPaddingVertical: 12.h,
                        hintText: "08:30 pm",
                        keyboardType: TextInputType.text,
                        controller:_createChallengeController.timeTec,
                        onChange: (value){
                          setState(() {
                            _createChallengeController.timeTec.text = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h,),
              Obx(() {
                return CustomButton(
                  loading: _createChallengeController.isLoading2.value,
                    onTap: () async {
                      if (tournamentDetailAttributes != null) {
                        await _createChallengeController
                            .createChallenge(tournamentDetailAttributes!);
                      }
                    },
                    text: AppString.submitText);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

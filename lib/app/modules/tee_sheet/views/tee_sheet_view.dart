import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/tee_sheet/controllers/tee_sheet_controller.dart';
import 'package:golf_game_play/app/modules/tee_sheet/model/teesheet_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class TeeSheetView extends StatelessWidget {
   TeeSheetView({super.key});
 final TeeSheetController _teeSheetController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
          child: Column(
            children: [
              Text(AppString.teeSheetText, style: AppStyles.h1()),
              SizedBox(height: 20.h),
              Obx(() {
                List<TeeSheetAttributes> teeSheetAttributes = _teeSheetController.teeSheetModel.value.data?.attributes??[];
                if(_teeSheetController.isLoading.value){
                  return Center(child: CircularProgressIndicator());
                }
                if(teeSheetAttributes.isEmpty){
                  return Center(child: Text('Tee sheet is empty'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: teeSheetAttributes.length,
                  itemBuilder: (BuildContext context, int index) {
                   final teeSheetAttributesIndex= teeSheetAttributes[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.w),
                      child: buildTeeSheet(teeSheetAttributesIndex),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  CustomCard buildTeeSheet(TeeSheetAttributes teeSheetAttributes) {
    return CustomCard(
      padding: 0,
      children: [
        Container(
          height: 25,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${teeSheetAttributes.groupName}'),
                  Text('${teeSheetAttributes.dateTime}'),
                ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Column(
            children: teeSheetAttributes.playerList!.map((player){
              Map<String,Color> teeBoxData = _teeSheetController.teeBoxItem;
              return Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Text('${player.name}',overflow: TextOverflow.ellipsis, style: AppStyles.h5())),
                  SizedBox(width: 20.h),
                  Text(player.clubHandicap!.isEmpty?'Player(HCP) : ${player.handicap}':'Club(HCP) : ${player.clubHandicap}', style: AppStyles.h5()),
                   CustomCard(
                      cardHeight: 30,
                      cardWidth: 50,
                      cardColor: teeBoxData[player.teebox],
                      children: []
                  ),
                ],
              );
             }).toList()
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
}

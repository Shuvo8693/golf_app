import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/invitation/controllers/invitation_controller.dart';
import 'package:golf_game_play/app/modules/invitation/model/invitation_model.dart';
import 'package:golf_game_play/app/modules/invitation/widgets/big_invitation_card.dart';
import 'package:golf_game_play/app/modules/invitation/widgets/small_invitation_card.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';

class InvitationView extends StatelessWidget {
  InvitationView({super.key});

  final InvitationController _invitationController = Get.put(InvitationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.invitationText,
          style: AppStyles.h2(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx((){
          List<InvitationAttributes> invitationAttributes = _invitationController.invitationModel.value.data?.attributes??[];
          if(_invitationController.isLoading.value){
            return Center(child: CircularProgressIndicator());
          } else if(invitationAttributes.isEmpty){
            return Text('~No invitations are found~',style: AppStyles.h5(),);
          }
          return  ListView.separated(
            itemCount: invitationAttributes.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
             final invitationAttributesIndex = invitationAttributes[index];
             if(invitationAttributesIndex.tournamentType=='big'){
               return BigInvitationCard(index: index, invitationAttributes: invitationAttributesIndex, invitationController: _invitationController);
             }else{
               return SmallInvitationCard(index: index, invitationAttributes: invitationAttributesIndex, invitationController: _invitationController,);
              }
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColors.secendryColor,
              );
            },
          );
        }

        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/invitation/widgets/invitation_card.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';


class InvitationView extends StatelessWidget {
  const InvitationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.invitationText,style: AppStyles.h2(),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return InvitationCard(index: index);
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: AppColors.secendryColor,
            );
          },
        ),
      ),
    );
  }
}

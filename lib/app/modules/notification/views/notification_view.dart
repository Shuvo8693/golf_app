import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/notification/widgets/notification_card.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.notificationText),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return NotificationCard(index: index);
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

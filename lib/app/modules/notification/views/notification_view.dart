import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/notification/controllers/notification_controller.dart';
import 'package:golf_game_play/app/modules/notification/model/notification_model.dart';
import 'package:golf_game_play/app/modules/notification/widgets/notification_card.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationController _notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      await _notificationController.fetchNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.notificationText),
        centerTitle: true,
      ),
      body: Obx(() {
        List<NotificationAttributes> notificationAttributes =
            _notificationController.notificationModel.value.data?.attributes ?? [];
        if (_notificationController.isLoading1.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (notificationAttributes.isEmpty) {
          return Center(child: Text('You have no new notification'));
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListView.separated(
            itemCount: notificationAttributes.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              final notificationIndex = notificationAttributes[index];
              return NotificationCard(
                index: index,
                notificationData: notificationIndex,
                iconOnTap: ()async {
                  await _notificationController.markAsRead(notificationId: notificationIndex.sId);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColors.secendryColor,
              );
            },
          ),
        );
      }),
    );
  }
}

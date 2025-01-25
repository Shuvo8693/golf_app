import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_appBar_title.dart';
import 'package:intl/intl.dart';


import '../controllers/message_controller.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(3),
      appBar: CustomAppBarTitle(text: 'Message'),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            /// Friend List
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Get.toNamed(Routes.MESSAGE_INBOX);
                      },
                      leading: CustomNetworkImage(
                        imageUrl: "",
                        height: 54.h,
                        width: 54.w,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      title: Text( 'full name',
                        style: AppStyles.h5(family: "Schuyler"),
                      ),
                      subtitle: Row(
                        children: [
                          Text(DateFormat('hh:mm a').format(DateTime.now()), style: AppStyles.h6(family: "Schuyler",)),
                        ],
                      ),
                    );
                  },
                )

            )
          ],
        ),
      ),
    );
  }
}

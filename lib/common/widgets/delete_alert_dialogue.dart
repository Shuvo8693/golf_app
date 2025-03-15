import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/challenge_matches/controllers/challenge_matches_controller.dart';
import 'package:golf_game_play/app/modules/challenge_matches/controllers/challenge_remove_controller.dart';
import 'package:golf_game_play/app/modules/challenge_matches/model/challenge_match_model.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

import 'custom_button.dart';
import 'custom_outlinebutton.dart';

class DeleteAlertDialogue extends StatelessWidget {
  final VoidCallback callback;
   const DeleteAlertDialogue({
    super.key, required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppString.deleteText),
      content: Text(AppString.areYouSureYouDeleteText),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: horizontalSpacing(10.w),
            ),
            Expanded(
              flex: 5,
              child: CustomOutlineButton(
                onTap: () {
                  Get.back(); // Close the dialog
                },
                text: "No",
              ),
            ),
            horizontalSpacing(10.w),
            Expanded(
              flex: 5,
              child: CustomButton(
                color: Colors.redAccent,
                onTap: callback,
                text: "Yes",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
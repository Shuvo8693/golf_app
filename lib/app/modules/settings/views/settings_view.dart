import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/my_profile/controllers/my_profile_controller.dart';
import 'package:golf_game_play/app/modules/settings/controllers/settings_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_listTile.dart';
import 'package:golf_game_play/common/widgets/delete_account_dialouge.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsController _settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppString.settingText,
          style: AppStyles.h2(
            family: "Schuyler",
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          /// Change Password
          SizedBox(height: 16.h),
          CustomListTile(
            iconHeight: 24.h,
            title: AppString.changePasswordText,
            icon: AppIcons.passwordIcon,
            onTap: () {
              Get.toNamed(Routes.RESET_PASSWORD);
            },
          ),

          /// Privacy setting
          SizedBox(height: 16.h),
          CustomListTile(
            iconHeight: 22.h,
            title: 'Privacy policy & Terms and condition',
            icon: AppIcons.privacyIcon,
            onTap: () {
              Get.toNamed(Routes.PRIVAACY_POLICY);
            },
          ),

          // /// Term & Condition
          // SizedBox(height: 16.h),
          // CustomListTile(
          //   title: AppString.termConditionText,
          //   icon: AppIcons.exclamatoryIcon,
          //   onTap: () {
          //     Get.toNamed(Routes.TERMS_CONDITION);
          //   },
          // ),

          /// about screen
          SizedBox(height: 16.h),
          CustomListTile(
            title: AppString.aboutusText,
            icon: AppIcons.aboutIcon,
            onTap: () {
              Get.toNamed(Routes.ABOUT);
            },
          ),

          /*   /// support screen
          SizedBox(height: 16.h),
          CustomListTile(
            title: AppString.contactUsText,
            icon: AppIcons.supportIcon,
            onTap: () {
              Get.toNamed(Routes.CONTACT_US);
            },
          ),*/
          Spacer(
            flex: 3,
          ),
          CustomButton(
            onTap: () async{
             await DeleteAccountDialog.showDeleteConfirmationDialog(context,
                  deleteOnTap: () async{
                   await _settingsController.deleteAccount();
                  }
              );
            },
            text: 'Delete Account',
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

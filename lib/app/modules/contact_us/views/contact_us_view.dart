import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/contact_us/controllers/contact_us_controller.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({super.key});

  final ContactUsController _contactUsController = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppString.contactUsText,
                style: AppStyles.h1(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                AppString.subonboardingText,
                textAlign: TextAlign.center,
                style: AppStyles.h6(),
              ),
              SizedBox(height: 18.h),
              CustomCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.emailText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 20.h,
                    hintText: "Enter Email",
                    controller: _contactUsController.emailCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Text(AppString.subjectText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 20.h,
                    hintText: "Enter Subject",
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _contactUsController.subjectCtrl,
                  ),
                  SizedBox(height: 10.h),
                  Text(AppString.messageText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 20.h,
                    hintText: "Type here...",
                    maxLine: 4,
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _contactUsController.messageCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Message';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50.h),
                  CustomButton(onTap: () {}, text: AppString.submitText),
                  SizedBox(height: 20.h),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_appBar_title.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final ResetPasswordController _resetPasswordController =
      Get.put(ResetPasswordController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTitle(
        key: key,
        text: AppString.changePasswordText,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* /// Old Password
                SizedBox(
                  height: 10.h,
                ),
                Text('Old Password (Optional)', style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                  contentPaddingVertical: 12.h,
                  hintText: "Enter Old Password",
                  // isPassword: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SvgPicture.asset(AppIcons.passwordIcon),
                  ),
                  controller: _changePasswordController.oldPassCtrl,
                  validator: (value){
                    if(value){}
                  },
                ),*/

                /// New Password
                SizedBox(height: 10.h),
                Text('New Password', style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                  contentPaddingVertical: 12.h,
                  hintText: "Enter New Password",
                  isPassword: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SvgPicture.asset(AppIcons.passwordIcon),
                  ),
                  controller: _resetPasswordController.newPassCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter new password';
                    }
                    return null;
                  },
                ),

                /// Confirm password
                SizedBox(
                  height: 10.h,
                ),
                Text('Confirm Password',
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                  contentPaddingVertical: 12.h,
                  hintText: "Confirm your Password",
                  isPassword: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SvgPicture.asset(AppIcons.passwordIcon),
                  ),
                  controller: _resetPasswordController.confirmPassCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm your password';
                    } else if (value !=
                        _resetPasswordController.newPassCtrl.text) {
                      return 'Password do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 55.h),

                /// Button
                Obx(() {
                  return CustomButton(
                      loading: _resetPasswordController.isLoading.value,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          _resetPasswordController.resetPassword(() {
                            return showStatusOnChangePasswordResponse(context);
                          });
                        }
                      },
                      text: AppString.changePasswordText);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showStatusOnChangePasswordResponse(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0.sp)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              SizedBox(
                height: 170.h,
                child: Lottie.asset('assets/lotti/success_lotti.json'),
              ),
              SizedBox(height: 20.h),
              // Text
              Text(
                AppString.passwordChangedText,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Text(
                AppString.returnToTheLoginPageText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              // Elevated Button
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: CustomButton(
                    onTap: () {
                      Get.toNamed(Routes.SIGN_IN);
                    },
                    text: 'Back To Login'),
              )
            ],
          ),
        );
      },
    );
  }
}

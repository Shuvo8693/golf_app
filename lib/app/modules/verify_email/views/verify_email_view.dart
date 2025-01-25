import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/background_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

import '../controllers/verify_email_controller.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final VerifyEmailController _verifyEmailController = Get.put(VerifyEmailController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 55.h),

                Text(AppString.forgotPasswordText,
                    style:
                        AppStyles.h1(family: "Schuyler", color: Colors.white)),
                Text(AppString.subforgotPassword,
                    style: AppStyles.h5(color: Colors.white)),
                SizedBox(height: 30.h),
                Text(AppString.emailText,
                    style:
                        AppStyles.h4(family: "Schuyler", color: Colors.white)),
                SizedBox(height: 10.h),
                CustomTextField(
                  contentPaddingVertical: 12.h,
                  hintText: "Enter Email",
                  filColor: Colors.white,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SvgPicture.asset(AppIcons.emailIcon),
                  ),
                  controller: _verifyEmailController.emailCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your mail';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                /// Send OTP Button
                Obx(() {
                  return CustomButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate() && !_verifyEmailController.isLoading.value) {
                        await _verifyEmailController.sendMail(true);
                      }
                    },
                    text: _verifyEmailController.isLoading.value
                        ? 'Sending...'
                        : AppString.sentOtpTExt,
                    // Disable button if loading
                  );
                }),
              ],
            ),
          ),
        )
      ],
    );
  }
}

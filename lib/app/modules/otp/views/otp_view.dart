import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/otp/controllers/resend_otp_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/background_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  OtpController otpController = Get.put(OtpController());
  ResendOtpController resendOtpController = Get.put(ResendOtpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _start = 179; // 3 min
  Timer _timer = Timer(Duration(seconds: 1), () {});

  startTimer() {
    print("Start Time$_start");
    print("Start Time$_timer");
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String get timerText {
    int minutes = _start ~/ 60; /// ~/ eta vag kora {When (_start 179 ~/ 60=2.98 ),(_start 119 ~/ 60 = 1.98 ),(_start 59 ~/ 60 = 0.98 ) }
    int seconds = _start % 60; /// Vag sesh, The remainder is 150−120=30, 30 is reminder, if _start is 119 then second will set to 59 cause reminder is 59 ({60*2=120} then 60*1=60 ,if 119 then 119-60=59)
    /// When _start = 59 is divided by 60, the quotient is 0 (since 59 is less than 60), and the remainder is 59. {eta hocce vag sesh , jeta dea multiply kora jabe na obosisto number ty reminder hobe }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool isResetPassword = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

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
                SizedBox(
                  height: 55.h,
                ),
                Text(AppString.verifyEmailTExt, style:
                        AppStyles.h1(family: "Schuyler", color: Colors.white)),
                Text(AppString.subverifyEmailTExt,
                    style: AppStyles.h5(color: Colors.white)),
                SizedBox(height: 30.h),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PinCodeTextField(
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      controller: otpController.otpCtrl,
                      autoDisposeControllers: false,
                      enablePinAutofill: true,
                      appContext: (context),
                      autoFocus: true,
                      textStyle: const TextStyle(),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(4).r,
                        fieldHeight: 58.h,
                        fieldWidth: 45.w,
                        activeFillColor: AppColors.gray.withOpacity(0.7),
                        selectedFillColor: AppColors.white,
                        inactiveFillColor: AppColors.white,
                        borderWidth: 0.5,
                        errorBorderColor: Colors.red,
                        activeBorderWidth: 0.5,
                        selectedColor: Get.theme.primaryColor,
                        inactiveColor: AppColors.white,
                      ),
                      length: 6,
                      enableActiveFill: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your pin code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    Text(timerText, style: AppStyles.h4(color: AppColors.primaryColor)),

                    SizedBox(height: 20.h),

                    ///======Action Button (Verify mail)======
                    Obx(() {
                      return CustomButton(
                          loading: otpController.verifyLoading.value,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await otpController.sendOtp(Get.arguments['isPassReset']??false);
                            }
                          },
                          text: AppString.verifyEmailTExt);
                    }),

                    SizedBox(height: 20.h),

                    /// Resent Button
                    timerText == "00:00"
                        ? InkWell(
                            onTap: () {
                              resendOtpController.sendMail();
                              _start = 179;
                              startTimer();
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn’t receive code? ",
                                  style: AppStyles.customSize(
                                    size: 14,
                                    family: "Schuyler",
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                                Text(
                                  "Resend it",
                                  style: AppStyles.customSize(
                                    size: 15,
                                    family: "Schuyler",
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

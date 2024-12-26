import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/home/views/home_view.dart';
import 'package:golf_game_play/app/modules/sign_up/controllers/signup_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/background_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';

class SignUpView extends GetView {
  SignUpView({super.key});

  final SignupController _signupController = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      children: [
        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  const Align(
                    alignment: Alignment.center,
                    child: GolfLogo(imageSize: 200),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppString.createAccountText,
                        style: AppStyles.h1(color: Colors.white),
                      )),

                  ///Full name
                  SizedBox(height: 40.h),
                  CustomTextField(
                    suffixIcon: Icon(
                      Icons.person,
                      color: AppColors.appGreyColor,
                      size: 20,
                    ),
                    filColor: AppColors.textFieldFillColor,
                    isEmail: true,
                    contentPaddingVertical: 20.h,
                    hintText: "Full name",
                    labelText: 'FullName',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _signupController.nameCtlr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    },
                  ),

                  ///Email
                  SizedBox(height: 20.h),
                  CustomTextField(
                    suffixIcon: Icon(
                      Icons.mail,
                      color: AppColors.appGreyColor,
                      size: 20,
                    ),
                    filColor: AppColors.textFieldFillColor,
                    isEmail: true,
                    contentPaddingVertical: 20.h,
                    hintText: "Enter Email",
                    labelText: 'Email',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _signupController.emailCtlr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),

                  /// Select Gender
                  SizedBox(height: 20.h),
                  DropdownButtonFormField<String>(
                    value: _signupController.gender,
                    padding: EdgeInsets.zero,
                    hint: Text("Select Gender",style: TextStyle(color: AppColors.primaryColor),),
                    decoration: InputDecoration(
                      fillColor: AppColors.white
                    ),
                    items: _signupController.genderList
                        .map((gender) => DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    ),
                    ).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select your gender';
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      _signupController.gender = newValue;
                      print('Gender>>>${_signupController.gender}');

                    },
                  ),

                  ///handicap
                  SizedBox(height: 20.h),
                  CustomTextField(
                    filColor: AppColors.textFieldFillColor,
                    isEmail: true,
                    contentPaddingVertical: 20.h,
                    hintText: "Handicap",
                    labelText: 'Handicap',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _signupController.handicapCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your handicap';
                      }
                      return null;
                    },
                  ),

                  ///City
                  SizedBox(height: 20.h),
                  CustomTextField(
                    filColor: AppColors.textFieldFillColor,
                    contentPaddingVertical: 20.h,
                    hintText: "City",
                    labelText: 'City',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _signupController.cityCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your City';
                      }
                      return null;
                    },
                  ),

                  ///State
                  SizedBox(height: 20.h),
                  CustomTextField(
                    filColor: AppColors.textFieldFillColor,
                    contentPaddingVertical: 20.h,
                    hintText: "State",
                    labelText: 'State',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _signupController.stateCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your State';
                      }
                      return null;
                    },
                  ),

                  ///Country
                  SizedBox(height: 20.h),
                  CustomTextField(
                    filColor: AppColors.textFieldFillColor,
                    contentPaddingVertical: 20.h,
                    hintText: "Country",
                    labelText: 'Country',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _signupController.countryCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Country';
                      }
                      return null;
                    },
                  ),

                  ///password
                  SizedBox(height: 20.h),
                  CustomTextField(
                    filColor: AppColors.textFieldFillColor,
                    suffixIconColor: AppColors.appGreyColor,
                    contentPaddingVertical: 20.h,
                    hintText: "Password",
                    labelText: 'Password',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    isObscureText: true,
                    obscure: '*',
                    isPassword: true,
                    controller: _signupController.passWordCtlr,
                  ),

                  ///confirm password
                  SizedBox(height: 20.h),
                  CustomTextField(
                    filColor: AppColors.textFieldFillColor,
                    suffixIconColor: AppColors.appGreyColor,
                    contentPaddingVertical: 20.h,
                    hintText: "Confirm Password",
                    labelText: 'Confirm Password',
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    isObscureText: true,
                    obscure: '*',
                    isPassword: true,
                    controller: _signupController.confirmPassCtlr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your confirm password';
                      } else if (value != _signupController.passWordCtlr.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  /// SignUp Button
                  SizedBox(height: 20.h),
                  Obx(() {
                    return CustomButton(
                        loading: _signupController.registerLoading.value,
                        onTap: () async {
                          Get.offAllNamed(Routes.HOME);
                          if (_formKey.currentState!.validate()) {
                            await _signupController.signUp();
                          }
                        },
                        textStyle: AppStyles.h3(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        text: AppString.createAccountText);
                  }),

                  /// Route SignUpScreen
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SIGN_IN);
                      _signupController.nameCtlr.clear();
                      _signupController.emailCtlr.clear();
                      _signupController.passWordCtlr.clear();
                      _signupController.confirmPassCtlr.clear();
                      _signupController.handicapCtrl.clear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                            style: AppStyles.customSize(
                                size: 14,
                                family: "Schuyler",
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        Text("Sign in",
                            style: AppStyles.customSize(
                                size: 15,
                                family: "Schuyler",
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor)),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

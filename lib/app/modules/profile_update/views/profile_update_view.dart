import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/app/modules/my_profile/controllers/my_profile_controller.dart';
import 'package:golf_game_play/app/modules/profile_update/controllers/profile_update_controller.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_constant/app_constant.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateView extends StatefulWidget {
  const ProfileUpdateView({super.key});

  @override
  State<ProfileUpdateView> createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView> {
  MyProfileController myProfileCtrl = Get.find();
  ProfileUpdateController? _profileUpdateController;

  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
     await myProfileCtrl.fetchProfile(() {});
      _profileUpdateController = Get.put(ProfileUpdateController(user: myProfileCtrl.myProfile.value));
      _profileUpdateController?.getProfile();
      setState(() {});
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:_profileUpdateController == null
          ? const Center(
        child: CircularProgressIndicator(), // Show a loading state while initializing
      ) : SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Column(
          children: [
            SizedBox(
              height: 275.h,
              child: Stack(
                children: [
                  ///Cover image
                  Obx(() {
                    return Positioned(
                      child: _profileUpdateController!
                              .coverImagePath.value.isNotEmpty
                          ? Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(
                                      File(_profileUpdateController!
                                          .coverImagePath.value),
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : CustomNetworkImage(
                              imageUrl: '${ApiConstants.imageBaseUrl}${myProfileCtrl.myProfile.value.coverImage?.url}',
                              height: 200.h,
                            ),
                    );
                  }),

                  ///profile image
                  Obx((){
                    return  Positioned(
                      top: 140.h,
                      left: 145.w,
                      child: _profileUpdateController!.profileImagePath.value.isNotEmpty
                          ? Container(
                        height: 125.h,
                        width: 125.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 3),
                          image: DecorationImage(
                              image: FileImage(
                                File(_profileUpdateController!
                                    .profileImagePath.value),
                              ),
                              fit: BoxFit.cover,
                          ),
                        ),
                      ) : CustomNetworkImage(imageUrl: '${ApiConstants.imageBaseUrl}${myProfileCtrl.myProfile.value.image?.url}',
                        height: 125.h,
                        width: 125.h,
                        boxShape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 3),
                      ),
                     );
                    }
                  ),

                  /// Cover image edit
                  Positioned(
                    left: 350,
                    child: InkWell(
                      onTap: () {
                        _showImagePickerBottomSheet(context, 'CoverPic');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: SvgPicture.asset(
                          AppIcons.editLogo,
                          height: 30.h,
                          width: 30.h,
                        ),
                      ),
                    ),
                  ),

                  /// Profile image edit
                  Positioned(
                    top: 230.h,
                    left: 220.w,
                    child: InkWell(
                      onTap: () {
                        _showImagePickerBottomSheet(context, 'ProfilePic');
                      },
                      child: Container(
                        height: 35.h,
                        width: 35.h,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: EdgeInsets.all(5.0.sp),
                          child: SvgPicture.asset(AppIcons.editLogo),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.edit), Text('Edit')],
            ),

            /// TextField Area
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Wrap(
                spacing: 5,
                runSpacing: 6,
                children: [
                  SizedBox(height: 10.h),
                  Text(AppString.nameText, style: AppStyles.h3()),
                  CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: "Name",
                    controller: _profileUpdateController!.nameCtrl,
                  ),

                  /// Select Gender
                  SizedBox(height: 10.h),
                  Text(AppString.genderText,
                      style: AppStyles.h4(family: "Schuyler")),
                  SizedBox(
                    height: 10.h,
                  ),
                  DropdownButtonFormField<String>(
                    value: _profileUpdateController!.gender,
                    padding: EdgeInsets.zero,
                    hint: Text("Select Gender"),
                    decoration: InputDecoration(),
                    items: _profileUpdateController!.genderList
                        .map(
                          (gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select your gender';
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      _profileUpdateController!.gender = newValue;
                      print('Gender>>>${_profileUpdateController!.gender}');
                    },
                  ),

                  /// City & State
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.cityText, style: AppStyles.h3()),
                          SizedBox(
                            width: 180.w,
                            child: CustomTextField(
                              contentPaddingVertical: 15.h,
                              hintText: "city",
                              controller: _profileUpdateController!.cityCtrl,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.stateText, style: AppStyles.h3()),
                          SizedBox(
                            width: 180.w,
                            child: CustomTextField(
                              contentPaddingVertical: 15.h,
                              hintText: "state",
                              controller: _profileUpdateController!.stateCtrl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(AppString.countryText, style: AppStyles.h3()),
                  CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: "country",
                    controller: _profileUpdateController!.countryCtrl,
                  ),

                  /// Club name & handicap
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.clubText, style: AppStyles.h3()),
                          SizedBox(
                            width: 220.w,
                            child: CustomTextField(
                              contentPaddingVertical: 15.h,
                              hintText: "Club name",
                              controller:
                                  _profileUpdateController!.clubNameCtrl,
                            ),
                          ),
                        ],
                      ),

                      /// Club handicap
                      SizedBox(width: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.clubHandicapText,
                              style: AppStyles.h3()),
                          SizedBox(
                            width: 140.w,
                            child: CustomTextField(
                              contentPaddingVertical: 15.h,
                              hintText: "Club handicap",
                              controller:
                                  _profileUpdateController!.clubHandicapCtrl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///Player Handicap
                  SizedBox(height: 10.h),
                  Text(AppString.handicapText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: "Handicap level",
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _profileUpdateController!.handicapCtrl,
                  ),

                  /// Facebook link
                  SizedBox(height: 10.h),
                  Text(AppString.facebookLinkText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: "https://www.facebook.com/shuvo",
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _profileUpdateController!.faceBookLinkCtrl,
                  ),

                  /// Instagram link
                  SizedBox(height: 10.h),
                  Text(AppString.instagramLinkText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: "https://www.instagram.com/shuvo",
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _profileUpdateController!.instagramLinkCtrl,
                  ),

                  /// Linkedin link
                  SizedBox(height: 10.h),
                  Text(AppString.linkedinLinkText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: "https://www.linkedin.com/shuvo",
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _profileUpdateController!.linkedinCtrl,
                  ),

                  /// X link
                  SizedBox(height: 10.h),
                  Text(AppString.xLinkText, style: AppStyles.h3()),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: "https://www.x.com/shuvo",
                    labelTextStyle: TextStyle(color: AppColors.primaryColor),
                    controller: _profileUpdateController!.xLinkCtrl,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Obx(() {
              return CustomButton(
                loading: _profileUpdateController!.registerLoading.value,
                onTap: ()async {
                 await _profileUpdateController?.updateProfile(
                    callBack: (message) async{
                      if (message != null && message.isNotEmpty) {
                        await myProfileCtrl.fetchProfile(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 100.h,
                              left: 20.w,
                              right: 20.h,
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        print("Message is null or empty");
                      }
                    },
                  );
                },
                text: AppString.saveAndContinueText,
              );
            }),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context, String editPic) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.choseAFileText,
                style: AppStyles.h2(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Image Picker
                    GestureDetector(
                      onTap: () {
                        if (editPic == 'ProfilePic') {
                          _profileUpdateController!
                              .pickImageFromCameraForProfilePic(
                                  ImageSource.gallery);
                        } else if (editPic == 'CoverPic') {
                          _profileUpdateController!
                              .pickImageFromCameraForCoverPic(
                                  ImageSource.gallery);
                        }
                      },
                      child: SvgPicture.asset(
                        AppIcons.photographLogo,
                        height: 90.h,
                        width: 90.h,
                        colorFilter: ColorFilter.mode(
                            AppColors.appGreyColor, BlendMode.srcIn),
                      ),
                    ),

                    /// Camera Picker
                    SizedBox(width: 50.w),
                    GestureDetector(
                      onTap: () {
                        if (editPic == 'ProfilePic') {
                          _profileUpdateController!
                              .pickImageFromCameraForProfilePic(
                                  ImageSource.camera);
                        } else if (editPic == 'CoverPic') {
                          _profileUpdateController!
                              .pickImageFromCameraForCoverPic(
                                  ImageSource.camera);
                        }
                      },
                      child: SvgPicture.asset(
                        AppIcons.cameraIcon,
                        height: 85.h,
                        width: 85.h,
                        colorFilter: ColorFilter.mode(
                            AppColors.appGreyColor, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

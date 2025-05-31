import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/app/modules/sponsor_signup/controllers/sponsor_signup_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/common/widgets/custom_textfelid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class SponsorSignupView extends StatefulWidget {
  const SponsorSignupView({super.key});

  @override
  State<SponsorSignupView> createState() => _SponsorSignupViewState();
}

class _SponsorSignupViewState extends State<SponsorSignupView> {
  final SponsorSignupController _sponsorSignupController = Get.put(SponsorSignupController());
  late final TextEditingController _searchController = TextEditingController();
  List<String> onChangeTextFieldValue = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(Routes.HOME);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppString.sponsorTournamentText,
                    style: AppStyles.h1(),
                  ),
                ),
                SizedBox(height: 8.h),
                CustomCard(
                  cardWidth: double.infinity,
                  children: [
                    Text(AppString.choseAFileText, style: AppStyles.h3()),
                    SizedBox(height: 8.h),
                    AppButton(
                        text: ' + Select a file',
                        onTab: () {
                          _showBottomSheet(context);
                        })
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  AppString.nameText,
                  style: AppStyles.h2(),
                ),
                CustomTextField(
                  contentPaddingVertical: 15.h,
                  hintText: "Enter name",
                  controller: _sponsorSignupController.nameCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),

                /// Location selector section
                SizedBox(height: 12.h),
                Text(
                  AppString.locationText,
                  style: AppStyles.h2(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (inputValue) async {
                          if (inputValue.isNotEmpty == true) {
                            var result = await GoogleApiService.fetchSuggestions(inputValue);
                            print(result.toString());
                            setState(() {
                              _sponsorSignupController.latLng = null;
                              onChangeTextFieldValue = result;
                            });
                            print(onChangeTextFieldValue.toString());
                          }
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search location",
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 24.sp,
                          ),
                        ),
                        onSubmitted: (value) async {
                          print(value);
                         await _sponsorSignupController.goToSearchLocation(value);
                        },
                      ),
                    ),
                  ],
                ),

                /// Location list section
                SizedBox(height: 8.h),
                onChangeTextFieldValue.isNotEmpty == true
                    ? Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Container(
                          height: 200.h,
                          width: 320.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: 3,
                                color: AppColors.gray.withOpacity(0.7),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.sp),
                              bottomRight: Radius.circular(12.sp),
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: onChangeTextFieldValue.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: InkWell(
                                  onTap: () {
                                    String selectedLocation = onChangeTextFieldValue[index].toString();
                                    print(selectedLocation);
                                    if (selectedLocation.isNotEmpty == true) {
                                      _searchController.text = selectedLocation;
                                      print(_searchController.text);
                                      _sponsorSignupController.goToSearchLocation(_searchController.text);
                                      setState(() {
                                        onChangeTextFieldValue.clear();
                                      });
                                    }
                                  },
                                  child: Text(onChangeTextFieldValue[index].toString(),
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),

                /// Link
                SizedBox(height: 12.h),
                Text(AppString.linkText, style: AppStyles.h2()),
                CustomTextField(
                  contentPaddingVertical: 15.h,
                  hintText: "https://example.com",
                  controller: _sponsorSignupController.linkCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter link';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 100.h),
                Obx(() {
                  return CustomButton(
                    loading: _sponsorSignupController.isLoading.value,
                      onTap: () async {
                        if (_sponsorSignupController.latLng != null && _sponsorSignupController.selectedIFile!.path.isNotEmpty) {
                          print('Check LatLng: ${_sponsorSignupController.latLng}');
                          await _sponsorSignupController.createSponsorContent();
                        } else {
                          print("No location selected!");
                          Get.snackbar('No location selected!', 'Please select your location ');
                        }
                      },
                      text: AppString.saveAndContinueText);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          height: 360.0.h, // Set height of the bottom sheet
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 8,
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  _sponsorSignupController
                      .pickImageFromGallery(ImageSource.gallery);
                },
                child: Obx(() {
                  return Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.grayLight,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: FileImage(
                              File(_sponsorSignupController.filePath.value)),
                          fit: BoxFit.cover),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20), // Add some space below the button
              Text("Click on the image", style: TextStyle(fontSize: 18)),
            ],
          ),
        );
      },
    );
  }
}

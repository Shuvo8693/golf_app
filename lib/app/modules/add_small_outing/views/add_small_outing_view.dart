import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/app/modules/add_small_outing/controllers/add_small_outing_controller.dart';
import 'package:golf_game_play/app/modules/add_tournament/controllers/add_tournament_controller.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddSmallOutingView extends StatefulWidget {
  const AddSmallOutingView({super.key});

  @override
  State<AddSmallOutingView> createState() => _AddSmallOutingViewState();
}

class _AddSmallOutingViewState extends State<AddSmallOutingView> {
  final AddSmallOutingController _addSmallOutingController =
      Get.put(AddSmallOutingController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> onChangeTextFieldValue = [];
  List<String> nothings = []; /// not important

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(AppString.smallTournamentText,
                      style: AppStyles.h1(family: "Schuyler")),
                ),
                SizedBox(height: 25.h),
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
                verticalSpacing(10.h),
                Text('Tournament Name',
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                    contentPaddingVertical: 12.h,
                    hintText: "Tournament Name",
                    controller: _addSmallOutingController.outingNameCtrl),

                /// Outing type
                SizedBox(height: 10.h),
                Text(AppString.tournamentTypeText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  /// Dropdown button field======================<<<<<<<<
                  value: _addSmallOutingController.outingType,
                  padding: EdgeInsets.zero,
                  hint: Text("Select tournament type"),
                  decoration: InputDecoration(),
                  items: _addSmallOutingController.outingTypeList
                      .map(
                        (gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select tournament type';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _addSmallOutingController.outingType = newValue;
                      print('Gender>>>${_addSmallOutingController.outingType}');
                    });
                  },
                ),

                /// Select Date
                SizedBox(height: 10.h),
                Text(AppString.dateText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                Obx(
                  () => GestureDetector(
                    onTap: () async {
                      _addSmallOutingController.selectDate(context);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Get.theme.primaryColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(14.r),
                          color: AppColors.fillColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _addSmallOutingController.selectedDate.isNotEmpty
                                  ? _addSmallOutingController.selectedDate.value
                                  : 'Select your Date of Birth',
                              // age(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal)
                            ),
                            SvgPicture.asset(AppIcons.calenderIcon)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// Time
                SizedBox(height: 10.h),
                Text('Time', style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                  contentPaddingVertical: 12.h,
                  hintText: "Enter time [ example 08:30 pm ]",
                  controller: _addSmallOutingController.timeCtrl,
                ),

                /// city
                SizedBox(height: 10.h),
                Text(AppString.cityText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                    contentPaddingVertical: 12.h,
                    hintText: "Enter City",
                    controller: _addSmallOutingController.cityCtrl),

                /// Course name
                /// Location selector section
                SizedBox(height: 12.h),
                Text(
                  AppString.courseNameText,
                  style: AppStyles.h4(family: 'Schuyler'),
                ),
                SizedBox(height: 10.h),
                buildLocationSelector(),

                /// Course rating & Slope rating
                /// Course rating
                SizedBox(height: 10.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.courseRatingText, style: AppStyles.h3()),
                        verticalSpacing(10.h),
                        SizedBox(
                          width: 180.w,
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            contentPaddingVertical: 15.h,
                            hintText: "Course rating",
                            controller:
                                _addSmallOutingController.courseRatingCtrl,
                          ),
                        ),
                      ],
                    ),

                    /// Slope rating
                    SizedBox(width: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.slopeRatingText, style: AppStyles.h3()),
                        verticalSpacing(10.h),
                        SizedBox(
                          width: 180.w,
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            contentPaddingVertical: 15.h,
                            hintText: "Slope rating",
                            controller:
                                _addSmallOutingController.slopeRatingCtrl,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                ///HCR Range
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(
                      child: Text(
                    AppString.hpcRangeText,
                    style: AppStyles.h2(),
                  )),
                ),

                /// From range
                SizedBox(height: 10.h),
                Text(AppString.fromRangeText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                    keyboardType: TextInputType.number,
                    contentPaddingVertical: 12.h,
                    hintText: "Range from...",
                    controller: _addSmallOutingController.fromRangeCtrl),

                /// To range
                SizedBox(height: 10.h),
                Text(AppString.toRangeText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                    keyboardType: TextInputType.number,
                    contentPaddingVertical: 12.h,
                    hintText: "Range to...",
                    controller: _addSmallOutingController.toRangeCtrl),

                /// Select Number of Groups
                SizedBox(height: 10.h),
                Text(AppString.selectNumberOfPlayersText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  /// Dropdown button field======================<<<<<<<<
                  value: _addSmallOutingController.numberOfPlayer,
                  padding: EdgeInsets.zero,
                  hint: Text("Select Number of player"),
                  decoration: InputDecoration(),
                  items: _addSmallOutingController.numberOfPlayerList
                      .map(
                        (gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select player number';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _addSmallOutingController.numberOfPlayer = newValue;
                      print(
                          'Player Number >>>${_addSmallOutingController.numberOfPlayer}');
                    });
                  },
                ),

                SizedBox(
                  height: 40.h,
                ),
                Obx(() {
                  return CustomButton(
                    loading: _addSmallOutingController.isLoading.value,
                    text: AppString.submitText,
                    onTap: () async{
                      if (formKey.currentState!.validate() &&
                          _addSmallOutingController.numberOfPlayer!.isNotEmpty &&
                          _addSmallOutingController.selectedDate.value.isNotEmpty &&
                          _addSmallOutingController.latLng !=null
                      ) {
                       await _addSmallOutingController.createSmallTournament(callBack: (message){
                          if(message !=null){
                            Get.snackbar('Success', message);
                          }
                        });
                      }
                    },
                    width: double.infinity,
                  );
                }),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildLocationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (inputValue) async {
                  if (inputValue.isNotEmpty == true) {
                    var result =
                        await GoogleApiService.fetchSuggestions(inputValue);
                    print(result.toString());
                    setState(() {
                      _addSmallOutingController.latLng = null;
                      onChangeTextFieldValue = result;
                    });
                    print(onChangeTextFieldValue.toString());
                  }
                },
                controller: _addSmallOutingController.searchCourseNameCtrl,
                decoration: InputDecoration(
                  hintText: "Search location",
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 24.sp,
                  ),
                ),
                onSubmitted: (value) {
                  _addSmallOutingController.goToSearchLocation(value);
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
              onPressed: () {
                _addSmallOutingController.goToSearchLocation(
                    _addSmallOutingController.searchCourseNameCtrl.text);
                setState(() {
                  onChangeTextFieldValue.clear();
                });
              },
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
                            String selectedLocation =
                                onChangeTextFieldValue[index].toString();
                            print(selectedLocation);
                            if (selectedLocation.isNotEmpty == true) {
                              _addSmallOutingController
                                  .searchCourseNameCtrl.text = selectedLocation;
                              print(_addSmallOutingController
                                  .searchCourseNameCtrl.text);
                            }
                          },
                          child: Text(
                            onChangeTextFieldValue[index].toString(),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

   _showBottomSheet(BuildContext context) {
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
                onTap: () async{
                await _addSmallOutingController.pickImageFromGallery(ImageSource.gallery);
                },
                child: Obx(() {
                  if(_addSmallOutingController.filePath.value.isEmpty){
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.grayLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  }
                  return Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.grayLight,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: FileImage(File(_addSmallOutingController.filePath.value)),
                          fit: BoxFit.cover
                      ),
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

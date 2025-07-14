import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
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
import 'package:image_picker/image_picker.dart';

class AddTournamentView extends StatefulWidget {
  const AddTournamentView({super.key});

  @override
  State<AddTournamentView> createState() => _AddTournamentViewState();
}

class _AddTournamentViewState extends State<AddTournamentView> {
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  final AddTournamentController _addTournamentController = Get.put(AddTournamentController());
  List<String> onChangeTextFieldValue = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(AppString.tournamentText,
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
                Text(AppString.tournamentNameText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                    contentPaddingVertical: 12.h,
                    hintText: "Type club name",
                    controller: _addTournamentController.clubNameCtrl),

                /// tournament type
                SizedBox(height: 10.h),
                Text(AppString.tournamentTypeText, style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  /// Dropdown button field======================<<<<<<<<
                  value: _addTournamentController.tournamentType,
                  padding: EdgeInsets.zero,
                  hint: Text("Select tournament type"),
                  decoration: InputDecoration(),
                  items: _addTournamentController.tournamentTypeList.map(
                        (gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ),
                      ).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select tournament type';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _addTournamentController.tournamentType = newValue;
                      print('Gender>>>${_addTournamentController.tournamentType}');
                    });
                  },
                ),

                /// Select Date
                SizedBox(height: 10.h),
                Text(AppString.dateText, style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                Obx(() => GestureDetector(
                    onTap: () async {
                     await _addTournamentController.selectDate(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Get.theme.primaryColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(14.r),
                          color: AppColors.fillColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_addTournamentController.selectedDate.value.isNotEmpty
                                  ? _addTournamentController.selectedDate.value
                                  : 'Select Date',
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
                  controller: _addTournamentController.timeCtrl,
                ),

                /// city
                SizedBox(height: 10.h),
                Text(AppString.cityText, style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                CustomTextField(
                    contentPaddingVertical: 12.h,
                    hintText: "Enter City",
                    controller: _addTournamentController.cityCtrl),

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
                            hintText: "Type course rating",
                            controller: _addTournamentController.courseRatingCtrl,
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
                            hintText: "Type slope rating",
                            controller: _addTournamentController.slopeRatingCtrl,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// Select Number of Players
                SizedBox(height: 10.h),
                Text(AppString.selectNumberOfPlayersText,
                    style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _addTournamentController.numberOfPlayerCtrl,
                  keyboardType: TextInputType.number,
                  style: AppStyles.h1(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2)
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    hintText: "Enter player Qty",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                  validator: (String? value){
                    if(value!.isNotEmpty ){
                  int? parseValue= int.tryParse(value);
                      if( parseValue! < 15){
                        return 'Select Minimum 15 players';
                      }
                    }
                    return null;
                  },
                ),
                // /// Length
                // SizedBox(height: 10.h),
                // Text(AppString.lengthText, style: AppStyles.h4(family: "Schuyler")),
                // SizedBox(height: 10.h),
                // DropdownButtonFormField<String>(
                //   /// Dropdown button field======================<<<<<<<<
                //   value: _addTournamentController.groupLength,
                //   padding: EdgeInsets.zero,
                //   hint: Text("Select Group length"),
                //   decoration: InputDecoration(),
                //   items: _addTournamentController.groupLengthList.map((gender) => DropdownMenuItem<String>(
                //     value: gender,
                //     child: Text(gender),
                //   ),).toList(),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Select Group length';
                //     }
                //     return null;
                //   },
                //   onChanged: (newValue) {
                //     setState(() {
                //       _addTournamentController.groupLength = newValue;
                //       print('Group length>>>${_addTournamentController.groupLength}');
                //     });
                //   },
                // ),
                SizedBox(height: 40.h),
                Obx(() {
                  return CustomButton(
                    loading: _addTournamentController.isLoading.value,
                    text: AppString.submitText,
                    onTap: () {
                      if (formKey.currentState!.validate() && _addTournamentController.selectedDate.value.isNotEmpty && _addTournamentController.latLng != null) {
                        _addTournamentController.createTournament(callBack: (message){
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
                    var result = await GoogleApiService.fetchSuggestions(inputValue);
                    print(result.toString());
                    setState(() {
                      _addTournamentController.latLng = null;
                      onChangeTextFieldValue = result;
                    });
                    print(onChangeTextFieldValue.toString());
                  }
                },
                controller: _addTournamentController.searchCourseNameCtrl,
                decoration: InputDecoration(
                  hintText: AppString.searchLocationText,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 24.sp,
                  ),
                ),
                onSubmitted: (value) {
                  _addTournamentController.goToSearchLocation(value);
                },
              ),
            ),
          ],
        ),

        /// Location list section
        SizedBox(height: 8.h),
        if (onChangeTextFieldValue.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              height: 200.h,
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
                      onTap: () async {
                        String selectedLocation = onChangeTextFieldValue[index];
                        if (selectedLocation.isNotEmpty == true) {
                          _addTournamentController.searchCourseNameCtrl.text = selectedLocation;
                          await _addTournamentController.goToSearchLocation(selectedLocation);
                        }
                        setState(() {
                          onChangeTextFieldValue = [];
                        });
                        print('checkLatLng: ${_addTournamentController.latLng}');
                        print('checkText: ${_addTournamentController.searchCourseNameCtrl.text}');
                      },
                      child: Text(onChangeTextFieldValue[index].toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
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
                  height: 6.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () {
                  _addTournamentController
                      .pickImageFromGallery(ImageSource.gallery);
                },
                child: Obx(() {
                  if(_addTournamentController.filePath.value.isEmpty){
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
                          image: FileImage(File(_addTournamentController.filePath.value)),
                          fit: BoxFit.cover
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.h), // Add some space below the button
              Text("Click on the image", style: TextStyle(fontSize: 18)),
            ],
          ),
        );
      },
    );
  }
}

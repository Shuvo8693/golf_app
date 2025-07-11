import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/app/modules/create_looking_to_play/controllers/create_looking_to_play_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

class CreateLookingToPlayView extends StatefulWidget {
  const CreateLookingToPlayView({super.key});

  @override
  State<CreateLookingToPlayView> createState() => _CreateLookingToPlayViewState();
}

class _CreateLookingToPlayViewState extends State<CreateLookingToPlayView> {
final CreateLookingToPlayController _createLookingToPlayController=Get.put(CreateLookingToPlayController());
final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
List<String> onChangeTextFieldValueVisitingFrom = [];
List<String> onChangeTextFieldValueGolfCourse = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
        onTap: () {
      Get.offNamed(Routes.LOOKING_TO_PLAY);
    },
    child: Icon(Icons.arrow_back_ios_new_outlined),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(AppString.createLookingToPlayText, style: AppStyles.h1(family: "Schuyler")),),
                SizedBox(height: 25.h),

                /// Categorise
                Text(AppString.categoriesText, style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  /// Dropdown button field======================<<<<<<<<
                  value: _createLookingToPlayController.category,
                  padding: EdgeInsets.zero,
                  hint: Text("Select Category"),
                  decoration: InputDecoration(),
                  items: _createLookingToPlayController.categoryList.map((gender) => DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                   ),
                  ).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select Category';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _createLookingToPlayController.category = newValue;
                      print('Category>>>${_createLookingToPlayController.category}');
                    });
                  },
                ),

                /// Visiting From
                SizedBox(height: 10.h),
                Text(AppString.visitingFromText, style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                buildLocationSelector(),

                /// Golf Course
                SizedBox(height: 10.h),
                Text('${AppString.golfCourseText}  (Leave blank for any course)', style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                buildLocationSelector(isGolfCourse: true),
                // CustomTextField(
                //     contentPaddingVertical: 12.h,
                //     hintText: "type Course",
                //     controller: _createLookingToPlayController.golfCourseCtrl,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'type Course';
                //     }
                //     return null;
                //   },
                // ),

                ///Date Range
                SizedBox(height: 8.h,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(child: Text(AppString.dateRangeText,style: AppStyles.h2(),)),
                ),

                /// from Date
                SizedBox(height: 10.h),
                Text(AppString.fromText, style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                Obx(() => GestureDetector(
                  onTap: () async {
                   await _createLookingToPlayController.selectFromDate(context);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Get.theme.primaryColor.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(14.r),
                        color: AppColors.fillColor),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _createLookingToPlayController.selectedFromDate.isNotEmpty
                                ? _createLookingToPlayController.selectedFromDate.value
                                : 'Select your from Date',
                            // age(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal)
                          ),
                          SvgPicture.asset(AppIcons.calenderIcon)
                        ],
                      ),
                    ),
                  ),
                 ),
                ),

                /// To Date
                SizedBox(height: 10.h),
                Text(AppString.toText, style: AppStyles.h4(family: "Schuyler")),
                SizedBox(height: 10.h),
                Obx(() => GestureDetector(
                  onTap: () async {
                    _createLookingToPlayController.selectToDate(context);
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Get.theme.primaryColor.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(14.r),
                        color: AppColors.fillColor),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _createLookingToPlayController.selectedToDate.isNotEmpty
                                ? _createLookingToPlayController.selectedToDate.value
                                : 'Select your Date',
                            // age(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal)
                          ),
                          SvgPicture.asset(AppIcons.calenderIcon)
                        ],
                      ),
                    ),
                  ),
                ),
                ),
                SizedBox(height: 40.h,),
                Obx((){
                  return CustomButton(
                    loading: _createLookingToPlayController.isLoading.value ,
                    text: AppString.submitText,
                    onTap: (){
                      if(_formKey.currentState!.validate()
                          && _createLookingToPlayController.selectedToDate.value.isNotEmpty
                          && _createLookingToPlayController.selectedFromDate.value.isNotEmpty ){
                        _createLookingToPlayController.createLookingToPlay();
                      }
                    },
                    width: double.infinity,);
                  }
                ),
                SizedBox(height: 50.h,),

              ],
            ),
          ),
        ),
      ),
    );
  }

Column buildLocationSelector({bool? isGolfCourse = false}) {
  // Get the appropriate list based on the field type
  List<String> currentSuggestions = isGolfCourse == true
      ? onChangeTextFieldValueGolfCourse
      : onChangeTextFieldValueVisitingFrom;

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
                  setState(() {
                    _createLookingToPlayController.latLng = null;
                    if (isGolfCourse == true) {
                      onChangeTextFieldValueGolfCourse = result;
                    } else {
                      onChangeTextFieldValueVisitingFrom = result;
                    }
                  });
                }
              },
              controller: isGolfCourse == true
                  ? _createLookingToPlayController.golfCourseCtrl
                  : _createLookingToPlayController.visitingFromCtrl,
              decoration: InputDecoration(
                hintText: isGolfCourse == true
                    ? 'Search golf course'
                    : 'Search visiting from',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 24.sp,
                ),
              ),
              onSubmitted: (value) {
                _createLookingToPlayController.goToSearchLocation(value);
              },
            ),
          ),
        ],
      ),

      /// Location list section
      SizedBox(height: 8.h),

      // Show suggestions if available
      if (currentSuggestions.isNotEmpty)
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
              itemCount: currentSuggestions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: InkWell(
                    onTap: () async {
                      String selectedLocation = currentSuggestions[index];
                      if (selectedLocation.isNotEmpty == true) {
                        // Set the appropriate controller based on field type
                        if (isGolfCourse == true) {
                          _createLookingToPlayController.golfCourseCtrl.text = selectedLocation;
                        } else {
                          _createLookingToPlayController.visitingFromCtrl.text = selectedLocation;
                        }

                        await _createLookingToPlayController.goToSearchLocation(selectedLocation);
                      }

                      setState(() {
                        // Clear the appropriate suggestions list
                        if (isGolfCourse == true) {
                          onChangeTextFieldValueGolfCourse = [];
                        } else {
                          onChangeTextFieldValueVisitingFrom = [];
                        }
                      });
                    },
                    child: Text(
                      currentSuggestions[index].toString(),
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
}

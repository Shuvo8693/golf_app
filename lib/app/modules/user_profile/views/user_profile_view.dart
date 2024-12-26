import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_constant/app_constant.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/bottomSheet_top_line.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/location_selector_field.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late final TextEditingController _searchController = TextEditingController();
  List<String> onChangeTextFieldValue = [];

  LatLng? latLng;
  Future<void> _goToSearchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        var latLngLocation = LatLng(location.latitude, location.longitude);
        latLng = latLngLocation;
        print(latLng);
      }
    } catch (e) {
      print('Error occurred while searching: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Column(
          children: [
            SizedBox(
              height: 275.h,
              child: Stack(
                children: [
                  Positioned(
                    child: CustomNetworkImage(
                      imageUrl: AppConstants.golfDemoImage,
                      height: 200.h,
                    ),
                  ),
                  Positioned(
                    top: 140.h,
                    left: 145.w,
                    child: CustomNetworkImage(
                      imageUrl: AppConstants.demoPersonImage,
                      height: 125.h,
                      width: 125.h,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                  ),
                ],
              ),
            ),
            Text('user@gmail.com', style: AppStyles.h4()),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SvgPicture.asset(
                      AppIcons.facebookIcon,
                      height: 20.h,
                    ),
                  ),
                ),
                SizedBox(width: 10.h),
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.linkedinIcon,
                    height: 20.h,
                  ),
                ),
                SizedBox(width: 10.h),
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.xTwitterIcon,
                    height: 20.h,
                  ),
                ),
                SizedBox(width: 10.h),
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.instagramIcon,
                    height: 20.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${AppString.nameText} : Stan', style: AppStyles.h3()),
                  SizedBox(height: 8.h),
                  Text('${AppString.clubText} : August National golf club',
                      style: AppStyles.h3()),
                  SizedBox(height: 8.h),
                  Text('${AppString.clubLevelHandicapText} : 3+',
                      style: AppStyles.h3()),
                  SizedBox(height: 8.h),
                  Text('${AppString.handicapText} : 5', style: AppStyles.h3()),
                  SizedBox(height: 8.h),
                  Text('${AppString.cityText} : Dhaka', style: AppStyles.h3()),
                  SizedBox(height: 8.h),
                  Text('${AppString.stateText} : Dhaka Division',
                      style: AppStyles.h3()),
                  SizedBox(height: 8.h),
                  Text('${AppString.countryText} : Bangladesh',
                      style: AppStyles.h3()),
                  SizedBox(height: 50.h),
                  CustomButton(
                      onTap: () async {
                      await _showLocationSelector(context);
                      },
                      text: AppString.challengeText),
                  SizedBox(height: 15.h),
                  CustomButton(onTap: () {}, text: AppString.messageText),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLocationSelector(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: 700.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   BottomSheetTopLine(),
                  verticalSpacing(25.h),
                  Text(AppString.selectCourseText,
                    style: AppStyles.h3(fontWeight: FontWeight.w700),
                  ),
                  verticalSpacing(15.h),
                  LocationSelector(
                    onSelected: (location)async {
                      print("Selected location: $location");
                      if(location.isNotEmpty){
                        _searchController.text = location;
                         await _goToSearchLocation(location);
                         print(latLng);
                      }
                    },
                  ),
                  ///===Action Button===
                  verticalSpacing(15.h),
                  CustomButton(
                    onTap: () {
                      if (_searchController.text.isNotEmpty) {
                        print(_searchController.text);
                      }
                    },
                    text: AppString.submitText,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


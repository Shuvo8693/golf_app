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
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
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
            SizedBox(height: 8.h),
            Icon(
              Icons.star_outlined,
              color: Colors.orange,
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
                      return await showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  height: 700.h,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppString.selectCourseText,
                                        style: AppStyles.h2(),
                                      ),
                                      const SizedBox(height: 10),
                                      buildLocationSelector(context),
                                      const SizedBox(height: 20),
                                      CustomButton(
                                        onTap: () {
                                          // Navigator.pop(context);
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

  Column buildLocationSelector(BuildContext context) {

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
                      latLng = null;
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
                onSubmitted: (value) {
                  _goToSearchLocation(value);
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
                _goToSearchLocation(_searchController.text);
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
                              _searchController.text = selectedLocation;
                              print(_searchController.text);
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
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:golf_game_play/app/modules/user_profile/model/user_profile.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_constant/app_constant.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/url_luncher/externer_url_luncher.dart';
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
  final UserProfileController _userProfileController= Get.put(UserProfileController());
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      await  _userProfileController.fetchUser();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx((){
        UserProfileAttributes? usersAttributes= _userProfileController.userProfile.value.data?.attributes;
       if(_userProfileController.isLoading.value){
         return Center(child: CircularProgressIndicator());
       }
       if(usersAttributes == null){
         return Center(child: Text('User data is empty',style: AppStyles.h4(),));
       }
        return  SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Column(
            children: [
              SizedBox(
                height: 275.h,
                child: Stack(
                  children: [
                    /// Cover Image
                    Positioned(
                      child: CustomNetworkImage(
                        imageUrl: '${ApiConstants.imageBaseUrl}/${usersAttributes.coverImage?.url}',
                        height: 200.h,
                      ),
                    ),
                    Positioned(
                      top: 140.h,
                      left: 145.w,
                      child: CustomNetworkImage(
                        imageUrl: '${ApiConstants.imageBaseUrl}/${usersAttributes.image?.url}',
                        height: 125.h,
                        width: 125.h,
                        boxShape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 3),
                      ),
                    ),
                  ],
                ),
              ),
              /// Email
              Text(usersAttributes.email??'', style: AppStyles.h4()),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Facebook
                  InkWell(
                    onTap: () {
                      if(usersAttributes.facebookLink!.isNotEmpty){
                        ExternalUrlLauncher.lunchUrl(usersAttributes.facebookLink!);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SvgPicture.asset(
                        AppIcons.facebookIcon,
                        height: 20.h,
                      ),
                    ),
                  ),
                  ///Linkedin
                  SizedBox(width: 10.h),
                  InkWell(
                    onTap: () {
                      if(usersAttributes.linkdinLink!.isNotEmpty){
                        ExternalUrlLauncher.lunchUrl(usersAttributes.linkdinLink!);
                      }
                    },
                    child: SvgPicture.asset(
                      AppIcons.linkedinIcon,
                      height: 20.h,
                    ),
                  ),
                  ///X_Twitter
                  SizedBox(width: 10.h),
                  InkWell(
                    onTap: () {
                      if(usersAttributes.xLink!.isNotEmpty){
                        ExternalUrlLauncher.lunchUrl(usersAttributes.xLink!);
                      }
                    },
                    child: SvgPicture.asset(
                      AppIcons.xTwitterIcon,
                      height: 20.h,
                    ),
                  ),
                  /// Instagram
                  SizedBox(width: 10.h),
                  InkWell(
                    onTap: () {
                      if(usersAttributes.instagramLink!.isNotEmpty){
                        ExternalUrlLauncher.lunchUrl(usersAttributes.instagramLink!);
                      }
                    },
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
                    Text('${AppString.nameText} : ${usersAttributes.name}', style: AppStyles.h3()),
                    SizedBox(height: 8.h),
                    Text('${AppString.clubText} : ${usersAttributes.clubName}',
                        style: AppStyles.h3()),
                    SizedBox(height: 8.h),
                    Text('${AppString.clubLevelHandicapText} : ${usersAttributes.clubHandicap}',
                        style: AppStyles.h3()),
                    SizedBox(height: 8.h),
                    Text('${AppString.handicapText} : ${usersAttributes.handicap}', style: AppStyles.h3()),
                    SizedBox(height: 8.h),
                    Text('${AppString.cityText} : ${usersAttributes.city}', style: AppStyles.h3()),
                    SizedBox(height: 8.h),
                    Text('${AppString.stateText} : ${usersAttributes.state}',
                        style: AppStyles.h3()),
                    SizedBox(height: 8.h),
                    Text('${AppString.countryText} : ${usersAttributes.country}',
                        style: AppStyles.h3()),
                    SizedBox(height: 50.h),
                    // CustomButton(
                    //     onTap: () async {
                    //       await _showLocationSelector(context);
                    //     },
                    //     text: AppString.challengeText),
                    SizedBox(height: 15.h),
                    CustomButton(onTap: () {}, text: AppString.messageText),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
          );
        }
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


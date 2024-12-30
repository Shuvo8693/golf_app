import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/home/controllers/tab_bar_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_drawer/app_drawer.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_images/app_images.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';

class HomeView extends GetView {
  HomeView({super.key});

  final TabBarController _tabBarController = Get.put(TabBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(0),
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GolfLogo(imageSize: 40),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///City_State_Country
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCard(
                    cardHeight: 110,
                    cardWidth: 120,
                    children: [
                      Image.asset(
                        AppImage.cityImg,
                        height: 20,
                        width: 40,
                      ),
                      Text('City', style: AppStyles.h4()),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text('New Work', style: AppStyles.h6()),
                    ],
                  ),
                  CustomCard(
                    cardHeight: 110,
                    cardWidth: 120,
                    children: [
                      Image.asset(
                        AppImage.stateImg,
                        height: 20,
                        width: 40,
                      ),
                      Text(
                        'State',
                        style: AppStyles.h4(),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'New Work',
                        style: AppStyles.h6(),
                      ),
                    ],
                  ),
                  CustomCard(
                    cardHeight: 110,
                    cardWidth: 120,
                    children: [
                      Image.asset(
                        AppImage.countryImg,
                        height: 20,
                        width: 40,
                      ),
                      Text(
                        'Country',
                        style: AppStyles.h4(),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'USA',
                        style: AppStyles.h6(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              ///Set location section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    onTap: () {
                      Get.toNamed(Routes.LOCATION_SELECTOR);
                    },
                    child: CustomCard(
                      isRow: true,
                      cardHeight: 60,
                      cardWidth: 300,
                      elevation: 4,
                      children: [
                        SvgPicture.asset(AppIcons.arrowAngleIcon,width: 22,),
                        SizedBox(width: 8.w),
                        Text('Find Tournament Around You', style: AppStyles.h6(),),
                        Flexible(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.arrow_forward_ios_outlined, size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              /// Sponsor section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    onTap: () {
                      Get.toNamed(Routes.SPONSOR_SIGNUP);
                    },
                    child: CustomCard(
                      cardHeight: 50,
                      cardWidth: 90,
                      padding: 8,
                      elevation: 2,
                      children: [
                        Text(
                          'Add',
                          style: AppStyles.h5(color: AppColors.appGreyColor),
                        )
                      ],
                    ),
                  ),
                  Text('Sponsored Tournaments',
                    style: AppStyles.h2(),
                  )
                ],
              ),

              /// Sponsor content List View
              SizedBox(height: 10.h),
              CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                  return buildSponsorContentView();
                },
                options: CarouselOptions(
                height: 280.h,
                aspectRatio: 16/9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
               // onPageChanged: ,
                scrollDirection: Axis.horizontal,
              ),

              ),
              SizedBox(height: 10.h),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int index = 0; index < _tabBarController.tapBarList.length; index++)
                      AppButton(
                          text: _tabBarController.tapBarList[index],
                          isBorderActive: true,
                          buttonColor:
                              _tabBarController.currentIndex.value == index
                                  ? AppColors.primaryColor.withOpacity(0.5)
                                  : AppColors.primaryColor.withOpacity(0.3),
                          borderColors: AppColors.primaryColor,
                          onTab: () {
                            _tabBarController.currentIndex.value = index;
                          },
                      ),
                  ],
                );
              }),
              SizedBox(height: 10.h),
              Obx(() {
                if (_tabBarController.currentIndex.value == 2) {
                  /// Looking to Play Screen Route
                  Future.microtask(() => Get.offNamed(Routes.LOOKING_TO_PLAY));
                  return SizedBox.shrink();
                }
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: switch (_tabBarController.currentIndex.value) {
                    /// Big Tournament
                    0 => SizedBox(
                        height: 400.h,
                        child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return buildTournament();
                          },
                        ),
                      ),

                    /// Small Tournament
                    1 =>  SizedBox(
                      height: 400.h,
                      child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return buildTournament();
                        },
                      ),
                    ),
                    _ => SizedBox.shrink(),
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildSponsorContentView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Stack(
        children: [
          Positioned(
            child: CustomNetworkImage(
                imageUrl: AppNetworkImage.golfFlayerImg,
              height: 230,
              borderRadius: BorderRadius.circular(12.r),
            )
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// Action button Route to Web view
                Padding(
                  padding:  EdgeInsets.only(bottom: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('For more information '),
                      SizedBox(width: 8.h),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.SPONSORE_WEB);
                        },
                        child: Text('click here', style: AppStyles.h5(
                              color: Colors.orange, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomCard buildTournament() {
    return CustomCard(
      cardWidth: 350,
      children: [
        Text('Tournament : Booz', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Type : Skins', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Location : Lorem ipsum dolor sit, consectetur elit, sed doadipisicing eiusmod tempor ', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Players : 2/15', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Start Date : 2024-05-16', style: AppStyles.h5()),
        SizedBox(height: 6.h),
        Text('Start Time : 12:00 AM', style: AppStyles.h5()),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppButton(
                onTab: () {
                  Get.toNamed(Routes.TOURNAMENT_DETAIL);
                },
                text: 'Details',
                height: 50.h),
            AppButton(onTab: () {}, text: 'Players 2/15', height: 50.h),
            AppButton(
              onTab: () {},
              text: 'Request to play',
              height: 50.h,
            ),
          ],
        )
      ],
    );
  }
}

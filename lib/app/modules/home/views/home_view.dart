import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/home/controllers/current_location_controller.dart';
import 'package:golf_game_play/app/modules/home/controllers/location_update_controller.dart';
import 'package:golf_game_play/app/modules/home/model/club_tournament_model.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/home/controllers/home_controller.dart';
import 'package:golf_game_play/app/modules/home/controllers/tab_bar_controller.dart';
import 'package:golf_game_play/app/modules/home/model/small_tournament_model.dart';
import 'package:golf_game_play/app/modules/home/widgets/club_tournament_card.dart';
import 'package:golf_game_play/app/modules/home/widgets/gaggle_rules.dart';
import 'package:golf_game_play/app/modules/home/widgets/small_tournament_card.dart';
import 'package:golf_game_play/app/modules/home/widgets/sponsor_content_view.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_drawer/app_drawer.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_images/app_images.dart';
import 'package:golf_game_play/common/app_images/network_image%20.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TabBarController _tabBarController = Get.put(TabBarController());
  final CurrentLocationController currentLocationController=Get.put(CurrentLocationController());
   LocationUpdateController? _locationUpdateController;
  final HomeController _homeController = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
     await currentLocationController.getCurrentLocation();
     _locationUpdateController=Get.put(LocationUpdateController(currentLocationController: currentLocationController));
    await _locationUpdateController?.updateLocation();
      await _homeController.fetchClubTournament(() {});
    });
    _scrollController.addListener(()async{
      if(_scrollController.position.pixels
          >= _scrollController.position.maxScrollExtent -200
          && !_homeController.isClubFetchingMore.value){
         await _homeController.loadMoreClubPage();
      }
    });

    _scrollController.addListener(()async{
      if(_scrollController.position.pixels
          >= _scrollController.position.maxScrollExtent -200
          && !_homeController.isOutingFetchingMore.value){
        await _homeController.loadMoreOutingPage();
      }
    });

  }

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
                    elevation: 2,
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
                    elevation: 2,
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
                    elevation: 2,
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
                      elevation: 2,
                      children: [
                        SvgPicture.asset(
                          AppIcons.arrowAngleIcon,
                          width: 22,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Find Tournament Elsewhere',
                          style: AppStyles.h6(),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                  Text(
                    'Sponsored Tournaments',
                    style: AppStyles.h2(),
                  )
                ],
              ),

              /// Sponsor content List View
              SizedBox(height: 10.h),
              CarouselSlider.builder(
                itemCount: 3,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return SponsorContentView();
                },
                options: CarouselOptions(
                  height: 280.h,
                  aspectRatio: 16 / 9,
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
                    for (int index = 0;
                        index < _tabBarController.tapBarList.length;
                        index++)
                      AppButton(
                          text: _tabBarController.tapBarList[index],
                          isBorderActive: true,
                          buttonColor:
                              _tabBarController.currentIndex.value == index
                                  ? AppColors.primaryColor.withOpacity(0.5)
                                  : AppColors.primaryColor.withOpacity(0.3),
                          borderColors: AppColors.primaryColor,
                          onTab: () async {
                            _tabBarController.currentIndex.value = index;
                            /// Small Tournament data fetch
                            if (_tabBarController.currentIndex.value == 1) {
                              await _homeController.fetchSmallTournament(() {});

                            } else if (_tabBarController.currentIndex.value == 0) {
                              /// Club Tournament data fetch
                              await _homeController.fetchClubTournament(() {});
                            }
                          }),
                  ],
                );
              }),
              SizedBox(height: 10.h),
              Obx(() {
                List<ClubTournamentData> clubTournamentDataList = [];
                List<SmallTournamentData> smallTournamentDataList = [];
                if (_tabBarController.currentIndex.value == 2) {
                  /// Looking to Play Screen Route
                  Future.microtask(() => Get.offNamed(Routes.LOOKING_TO_PLAY));
                  return SizedBox.shrink();
                }
                if (_tabBarController.currentIndex.value == 0) {
                  clubTournamentDataList = _homeController.clubTournamentModel.value.data ?? [];
                } else if (_tabBarController.currentIndex.value == 1) {
                  smallTournamentDataList = _homeController.smallTournamentModel.value.data ?? [];
                }

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: switch (_tabBarController.currentIndex.value) {
                    /// Club Tournament
                    0 => _homeController.isLoadingClub.value
                        ? CircularProgressIndicator()
                        : clubTournamentDataList.isEmpty
                            ? Text('No Tournament Available at your area')
                            : SizedBox(
                                height: 400.h,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: clubTournamentDataList.length +(_homeController.isClubFetchingMore.value ? 1:0),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    if(index == clubTournamentDataList.length){
                                      return  Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                        child: Center(child: CircularProgressIndicator()),
                                      );
                                    }
                                    final clubTournamentData = clubTournamentDataList[index];
                                    return ClubTournamentCard(
                                        clubTournamentData: clubTournamentData);
                                  },
                                ),
                              ),

                    /// Small Tournament
                    1 => _homeController.isLoadingSmall.value
                        ? CircularProgressIndicator()
                        : smallTournamentDataList.isEmpty
                            ? Text('No Small Tournament Available at your area')
                            : SizedBox(
                                height: 400.h,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: smallTournamentDataList.length + (_homeController.isOutingFetchingMore.value ? 1:0),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    if(index == smallTournamentDataList.length){
                                      return  Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                                        child: Center(child: CircularProgressIndicator()),
                                      );
                                    }
                                    final smallTournamentData = smallTournamentDataList[index];
                                    return SmallTournamentCard(smallTournamentData: smallTournamentData);
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

}

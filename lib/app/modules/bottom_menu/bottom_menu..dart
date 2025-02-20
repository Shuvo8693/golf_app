import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';

class BottomMenu extends StatefulWidget {
  final int menuIndex;

  const BottomMenu(this.menuIndex, {super.key});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.menuIndex; // Set initial index
  }

  void _onItemTapped(int index) {
    if(_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to corresponding pages
    switch (index) {
      case 0:
        Get.offAndToNamed(Routes.HOME);
        break;
      case 1:
        Get.offAndToNamed(Routes.GOLFERS);
        break;
      case 2:
        Get.offAndToNamed(Routes.ENTERED);
        break;
      case 3:
        Get.offAndToNamed(Routes.MESSAGE);
        break;
      case 4:
        Get.offAndToNamed(Routes.TOP50);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: 80.h,
        child: Card(
          elevation: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              currentIndex: _selectedIndex, // Set the selected index
              onTap: _onItemTapped, // Handle taps on items
              type: BottomNavigationBarType.fixed, // Prevents shifting behavior
              backgroundColor: AppColors.white,
              selectedItemColor: AppColors.primaryColor,
              showSelectedLabels: true,
              unselectedItemColor: const Color(0xffC4D3F6), // Inactive item color
              selectedFontSize: 12.0,
              unselectedFontSize: 12.0,
              items: [
                _buildBottomNavItem(AppIcons.homesIcon, 'Home'),
                _buildBottomNavItem(AppIcons.golferIcon, 'Golfers'),
                _buildBottomNavItem(AppIcons.enteredLogo, 'Entered'),
                _buildBottomNavItem(AppIcons.messageIcons, 'Message'),
                _buildBottomNavItem(AppIcons.top50Logo, 'Top 50'),
              ],
            ),
        ),
      ),
    );

  }

  BottomNavigationBarItem _buildBottomNavItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        height: 24.0,
        width: 24.0,
        color: const Color(0xffC4D3F6), // Inactive icon color
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        height: 24.0,
        width: 24.0,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
         // Active icon color
      ),
      label: label,
    );
  }
}

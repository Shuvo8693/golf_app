import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_images/app_images.dart';

class GolfLogo extends StatelessWidget {
  final double imageSize;
  const GolfLogo({super.key, required this.imageSize});

  @override
  Widget build(BuildContext context) {
      return  Image.asset(AppIcons.golfLogoMain,
       fit: BoxFit.cover, // Force the image to fill its bounds
        width: imageSize.h, // Slightly smaller than the container
        height: imageSize.h,
      );
  }
}

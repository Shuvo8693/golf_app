import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class TeeSheetView extends StatelessWidget {
  const TeeSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
          child: Column(
            children: [
              Text(AppString.teeSheetText, style: AppStyles.h1()),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.w),
                    child: buildTeeSheet(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomCard buildTeeSheet() {
    return CustomCard(
      padding: 0,
      children: [
        Container(
          height: 25,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Group 1'),
                  Text('9:10:00 AM'),
                ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text('A : Name1', style: AppStyles.h5()),
                  SizedBox(width: 20.h),
                  Text('HCP : 8.1', style: AppStyles.h5()),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Text('B : Name2', style: AppStyles.h5()),
                  SizedBox(width: 20.h),
                  Text('HCP : 8.1', style: AppStyles.h5()),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Text('C : Name3', style: AppStyles.h5()),
                  SizedBox(width: 20.h),
                  Text('HCP : 8.1', style: AppStyles.h5()),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Text('D : Name3', style: AppStyles.h5()),
                  SizedBox(width: 20.h),
                  Text('HCP : 8.1', style: AppStyles.h5()),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
}

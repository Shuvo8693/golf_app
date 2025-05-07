import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';

import '../app_string/app_string.dart';
import 'custom_card.dart';
import 'custom_text_field.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchCtrl, this.onChanged, required this.onTab,
  });
  final Function(String?)? onChanged;
  final TextEditingController searchCtrl;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            filColor: AppColors.grayLight,
            contentPaddingVertical: 20.h,
            prefixIcon: Padding(
              padding:  EdgeInsets.all(8.0.sp),
              child: Icon(
                Icons.search_outlined,
                size: 25,
              ),
            ),
            hintText: 'Search...',
            controller: searchCtrl,
            onChange: onChanged,
          ),
        ),
        SizedBox(width: 6.w),
        // GestureDetector(
        //   onTap: onTab,
        //   child: CustomCard(
        //     cardColor: AppColors.grayLight,
        //     borderSideColor: AppColors.primaryColor,
        //     cardHeight: 75,
        //     cardWidth: 100,
        //     padding: 18,
        //     children: [
        //       Text(AppString.searchText,
        //         style: AppStyles.h4(),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}
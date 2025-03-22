import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/create_winner_details/controllers/create_winner_details_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';


class CreateWinnerDetailsView extends StatefulWidget {
   const CreateWinnerDetailsView({super.key});

  @override
  State<CreateWinnerDetailsView> createState() => _CreateWinnerDetailsViewState();
}

class _CreateWinnerDetailsViewState extends State<CreateWinnerDetailsView> {

  final List<String> steps = [
    "SKIN",
    "KPS",
    "TOP WINNERS",
    "SCORE"
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               _buildHeader(),
              verticalSpacing(8.h),
              ..._buildSteps(steps),
              SizedBox(height: 50.h),
              CustomButton(onTap: () {Get.toNamed(Routes.SKIN);}, text: 'Start'),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

   /// Builds the header section
   Widget _buildHeader() {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Text(
           'ADD WINNERS',
           style: TextStyle(
             fontSize: 24,
             fontWeight: FontWeight.bold,
           ),
         ),
         SizedBox(height: 8),
         Text(
           'We’ll finish the adding winner in ${steps.length} steps!',
           style: TextStyle(fontSize: 16),
         ),
       ],
     );
   }

   /// Builds a list of step widgets
   List<Widget> _buildSteps(List<String> steps) {
     return steps.asMap().entries.map((entry) => Padding(
         padding:  EdgeInsets.only(bottom: 8.h),
         child: Text(
           'Step ${entry.key + 1}: ${entry.value}',
           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
         ),
       ),
     ).toList();
   }
}

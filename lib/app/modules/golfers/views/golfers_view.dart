import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/golfers/widgets/custom_card_item.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';

import 'package:golf_game_play/common/app_drawer/app_drawer.dart';
import 'package:golf_game_play/common/widgets/custom_search_field.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class GolfersView extends StatelessWidget {
  GolfersView({super.key});

  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(1),
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
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            CustomSearchField(
              searchCtrl: searchCtrl,
              onTab: () {},
              onChanged: (changedValue) {},
            ),
            verticalSpacing(20.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 10.w),
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CustomCardItem(
                    onTab: () {
                      Get.toNamed(Routes.USER_PROFILE);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

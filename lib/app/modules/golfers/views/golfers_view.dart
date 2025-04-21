import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/golfers/controllers/golfers_controller.dart';
import 'package:golf_game_play/app/modules/golfers/model/golfers_models.dart';
import 'package:golf_game_play/app/modules/golfers/widgets/golfer_card_item.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';

import 'package:golf_game_play/common/app_drawer/app_drawer.dart';
import 'package:golf_game_play/common/app_images/app_images.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_search_field.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';
import 'package:golf_game_play/main.dart';

class GolfersView extends StatelessWidget {
  GolfersView({super.key});

  final TextEditingController searchCtrl = TextEditingController();
  final GolfersController _golfersController = Get.find();

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
              onChanged: (changedValue)async{
                if(changedValue!.isNotEmpty){
                  await _golfersController.fetchGolfers(isDirectFetch: false, name: changedValue);
                }
              },
            ),
            verticalSpacing(20.h),
            Obx(() {
              List<GolferAttributes> golfersAttributes= _golfersController.golferModel.value.data?.attributes??[];
              if(_golfersController.isLoading.value){
                return Center(child: CircularProgressIndicator());
              } else if(golfersAttributes.isEmpty){
                return Center(child: Text('No golfers available at your area now',style: AppStyles.h3(),));
              }
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 10.w),
                  itemCount: golfersAttributes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                   final golferAttributesIndex = golfersAttributes[index];
                    return GolferCardItem(
                      onTab: () {
                        print(golferAttributesIndex.id);
                        Get.toNamed(Routes.USER_PROFILE,arguments: {'receiverId': golferAttributesIndex.id});
                      }, golferAttributes: golferAttributesIndex,
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

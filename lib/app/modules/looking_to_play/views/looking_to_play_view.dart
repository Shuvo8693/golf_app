import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/looking_to_play/controllers/looking_to_play_controller.dart';
import 'package:golf_game_play/app/modules/looking_to_play/model/looking_to_play_model.dart';
import 'package:golf_game_play/app/modules/looking_to_play/widgets/looking_to_play_card_item.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

class LookingToPlayView extends StatefulWidget {
  const LookingToPlayView({super.key});

  @override
  State<LookingToPlayView> createState() => _LookingToPlayViewState();
}

class _LookingToPlayViewState extends State<LookingToPlayView> {
  final LookingToPlayController _lookingToPlayController = Get.put(LookingToPlayController());

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
     await _lookingToPlayController.fetchLookingToPlay();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.lookingToPlayText, style: AppStyles.h1()),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(Routes.HOME);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                  text: AppString.createText,
                  containerHorizontalPadding: 23.w,
                  containerVerticalPadding: 10.h,
                  onTab: () {
                    Get.toNamed(Routes.CREATE_LOOKING_TO_PLAY);
                  }),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    filColor: AppColors.grayLight,
                    contentPaddingVertical: 20.h,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Icon(
                        Icons.search_outlined,
                        size: 25,
                      ),
                    ),
                    hintText: 'Search...',
                    controller: _lookingToPlayController.searchCtrl,
                    onChange: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Obx((){
             List<LookingToPlayAttributes> lookingToPlayAttribute = _lookingToPlayController.lookingToPlayModel.value.data?.attributes??[];
             if(_lookingToPlayController.isLoading.value){
               return Center(child: CircularProgressIndicator());
             }
             if(lookingToPlayAttribute.isEmpty){
               return Center(child: Text('Looking to player list empty',style: AppStyles.h4(),));
             }
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lookingToPlayAttribute.length > 99 ? '99+ Results': '${lookingToPlayAttribute.length} Results ', style: AppStyles.h5()),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: lookingToPlayAttribute.length ,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                         final lookingToPlayAttributesIndex = lookingToPlayAttribute[index];
                          return LookingToPlayCardItem(lookingToPlayAttributes: lookingToPlayAttributesIndex,);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}



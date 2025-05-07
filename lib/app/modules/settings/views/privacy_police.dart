
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/settings/controllers/privacy_controller.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_appBar_title.dart';
import 'package:golf_game_play/common/widgets/html_view.dart';

class PrivacyPoliceScreen extends StatefulWidget {
  const PrivacyPoliceScreen({super.key});

  @override
  State<PrivacyPoliceScreen> createState() => _PrivacyPoliceScreenState();
}

class _PrivacyPoliceScreenState extends State<PrivacyPoliceScreen> {
  PrivacyController privacyController=Get.put(PrivacyController());
  @override
  void initState() {
    super.initState();
    privacyController.fetchPrivacy();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBarTitle(text: 'Privacy policy & Terms and conditions for Golf game world',textStyle: AppStyles.h3(),maxLine: 2,),
      body: Column(
        children: [
          Obx((){
            String privacyContent= privacyController.content.value;
            if(privacyController.isLoading.value){
              return const Center(child: CircularProgressIndicator());
            }
            return   Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: HTMLView(htmlData: privacyContent),
            );
           }

          ),
        ],
      ),
    );

  }
}

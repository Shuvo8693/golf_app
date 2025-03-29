import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/settings/controllers/about_us_controller.dart';
import 'package:golf_game_play/common/widgets/custom_appBar_title.dart';
import 'package:golf_game_play/common/widgets/html_view.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AboutUsController aboutUsController=Get.put(AboutUsController());

  @override
  void initState() {
    super.initState();
   aboutUsController.fetchAboutUs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTitle(text: 'About us'),
      body: Column(
        children: [
          Obx((){
            String aboutUsContent= aboutUsController.content.value;
            if(aboutUsController.isLoading.value){
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: HTMLView(htmlData: aboutUsContent),
            );
          }

          ),
        ],
      ),
    );
  }
}

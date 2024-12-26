import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270.w,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
          /*  DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'App Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GolfLogo( imageSize: 50),
                  SizedBox(width: 8,),
                  Text(AppString.golfGameWorldText,style: AppStyles.h2())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('STAN1',style: AppStyles.h2(fontWeight: FontWeight.w700)),
            ),
            ListTile(
              title: Text(AppString.homeText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.HOME);
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.profileText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.MY_PROFILE);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),

            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.notificationText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.NOTIFICATION);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),

            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.viewInvitationText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.INVITATION);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),

            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.completedTournamentText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.COMPLETED_GAMES);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.requestedToPlayMyTournamentText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.REQUEST_TO_PLAY);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.requestedToPlayMySmallOutingText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.addTournamentText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.ADD_TOURNAMENT);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.addSmallOutingText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.ADD_SMALL_OUTING);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.assignGroupsText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.ASSIGN_GROUP);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.createChallengeText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                  Get.toNamed(Routes.CREATE_CHALLENGE);
                // Navigate to settings or handle logic
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),
            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.singleMatchText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.SINGLE_MATCHES);
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),

            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.paymentText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.SUBSCRIPTION);
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),

            Divider(height: 2,color: Colors.black54,),
            ListTile(
              title: Text(AppString.settingText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.SETTINGS);
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
            ),

            Divider(height: 2,color: Colors.black54,),

            ListTile(
              title: Text(AppString.logoutText,style: AppStyles.h3(),),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings or handle logic
              },
            ),
            SizedBox(height: 100.h,)
          ],
        ),
      ),
    );
  }
}

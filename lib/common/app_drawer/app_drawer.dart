import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/app/modules/my_profile/controllers/my_profile_controller.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/custom_outlinebutton.dart';
import 'package:golf_game_play/common/widgets/golf_logo.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final MyProfileController _myProfileController =Get.put(MyProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
     await _myProfileController.fetchProfile((){});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270.w,
      child: SafeArea(
        child: Obx((){
          MyProfile userValue = _myProfileController.myProfile.value;
          if(_myProfileController.isLoading.value){
            return Center(child: CircularProgressIndicator());
          }else if(userValue == MyProfile()){
            return Text('Profile fetching is getting error');
          }
          return  ListView(
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
                child: Text('${userValue.name}',overflow: TextOverflow.ellipsis,style: AppStyles.h2(fontWeight: FontWeight.w700)),
              ),
              ListTile(
                title: Text(AppString.homeText,style: AppStyles.h3(),),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.HOME);
                  // Get.toNamed(Routes.STORY_SLIDER);
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

          /*    Divider(height: 2,color: Colors.black54,),
              ListTile(
                title: Text(AppString.notificationText,style: AppStyles.h3(),),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.NOTIFICATION);
                  // Navigate to settings or handle logic
                },
                trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
              ),*/

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
              if(userValue.role=='supperUser')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 2,color: Colors.black54,),
                  ListTile(
                    title: Text(AppString.requestedToPlayMyTournamentText,style: AppStyles.h3(),),
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.REQUEST_TO_PLAY,arguments: {'tournamentType':'big'});
                      // Navigate to settings or handle logic
                    },
                    trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
                  ),
                ],
              ),
              Divider(height: 2,color: Colors.black54,),
              ListTile(
                title: Text(AppString.requestedToPlayMySmallOutingText,style: AppStyles.h3(),),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(Routes.REQUEST_TO_PLAY,arguments: {'tournamentType':'small'});
                  // Navigate to settings or handle logic
                },
                trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
              ),
              if(userValue.role == 'supperUser')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
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
              // Divider(height: 2,color: Colors.black54,),
              // ListTile(
              //   title: Text(AppString.assignGroupsText,style: AppStyles.h3(),),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Get.toNamed(Routes.ASSIGN_GROUP);
              //     // Navigate to settings or handle logic
              //   },
              //   trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,),
              // ),
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
                  showCustomDialog(context);
                },
              ),
              SizedBox(height: 100.h,)
            ],
          );
        }

      ),
      )
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout",style: AppStyles.h2(),),
          content: const Text("Are you sure you want to log out ?"),
          actions: [
            CustomOutlineButton(
                width: 55,
                onTap: (){
                  Get.back();
                }, text: 'No'),

            CustomButton(
                width: 55,
                onTap: ()async{
                  await PrefsHelper.remove('token');
                  String token = await PrefsHelper.getString('token');
                  if(token.isEmpty){
                    Get.offAllNamed(Routes.SIGN_IN);
                  }
                }, text: 'Yes'),
          ],
        );
      },
    );
  }
}

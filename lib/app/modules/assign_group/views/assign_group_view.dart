import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/assign_group/controllers/assign_group_controller.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';

class AssignGroupView extends StatefulWidget {
  const AssignGroupView({super.key});

  @override
  State<AssignGroupView> createState() => _AssignGroupViewState();
}

class _AssignGroupViewState extends State<AssignGroupView> {
  final AssignGroupController _assignGroupController =
      Get.put(AssignGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(AppString.assignGroupsText,
                  style: AppStyles.h1(family: "Schuyler")),
            ),
            SizedBox(height: 15.h),

            /// Outing type
            SizedBox(height: 10.h),
            Text(AppString.selectText, style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
            DropdownButtonFormField<String>(
              /// Dropdown button field======================<<<<<<<<
              value: _assignGroupController.selectType,
              padding: EdgeInsets.zero,
              hint: Text("Select type"),
              decoration: InputDecoration(),
              items: _assignGroupController.selectTypeList
                  .map(
                    (gender) => DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    ),
                  ).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select type';
                }
                return null;
              },
              onChanged: (newValue) {
                setState(
                  () {
                    _assignGroupController.selectType = newValue;
                    print('Gender>>>${_assignGroupController.selectType}');
                  },
                );
              },
            ),

            /// Users
            SizedBox(height: 10.h),
            Text(AppString.usersText, style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
            SizedBox(
              height: 210.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  GlobalKey buttonKey = GlobalKey();
                  return buildUsers(buttonKey);
                },
              ),
            ),

            /// No Of Groups
            SizedBox(height: 20.h),
            Text(AppString.noOfGroupsText,
                style: AppStyles.h4(family: "Schuyler")),
            SizedBox(height: 10.h),
            SizedBox(
              height: 273.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return buildNoOfGroup();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomCard buildUsers(GlobalKey<State<StatefulWidget>> buttonKey) {
    return CustomCard(
      key: buttonKey,
      cardColor: AppColors.primaryColor,
      cardWidth: double.infinity,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      isRow: true,
      children: [
        Wrap(
          children: [
            Text('Name', style: AppStyles.h4(family: "Schuyler")),
            Icon(Icons.star_outlined),
          ],
        ),
        InkWell(
          onTap: () {
            buildPopUpMenu(buttonKey,_assignGroupController.groupNumberList);
          },
          child: Text(
            '+ Group ▼ ',
            style: AppStyles.h4(family: "Schuyler"),
          ),
        ),
      ],
    );
  }

  CustomCard buildNoOfGroup() {
    return CustomCard(
      cardWidth: double.infinity,
      padding: 4.sp,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      cardHeight: 220,
      children: [
        CustomCard(
          isRow: true,
          cardColor: AppColors.primaryColor,
          cardWidth: double.infinity,
          children: [
            Text('Name', style: AppStyles.h4(family: "Schuyler")),
            Icon(Icons.star_outlined),
          ],
        ),
        Text('Group Name : Group 1', style: AppStyles.h4(family: "Schuyler")),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 25.h,
              width: 150.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  GlobalKey buttonKey = GlobalKey();
                  List<String>nameList=['name1'];
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child:  AppButton(
                      key: buttonKey,
                      text: 'A',
                      containerVerticalPadding: 0,
                      onTab: (){
                       // buildPopUpMenu(buttonKey, nameList);
                        /// Need to set this properly according to list api data and build it with method
                          RenderBox currentRenderBox= buttonKey.currentContext!.findRenderObject() as RenderBox;
                          final buttonPosition= currentRenderBox.localToGlobal(Offset.zero);
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(buttonPosition.dx.w, buttonPosition.dy.h + 20.h, 150.w, 0),
                            items: [
                              PopupMenuItem(
                                height: 20,
                                value: 'UserInfo',
                                child: Text('Test popup',style: AppStyles.h4(),),
                              )
                            ],
                          );


                      },
                    ),
                  );
                },
              ),
            ),
            AppButton(
              text: AppString.enterText,
              onTab: () {},
              containerVerticalPadding: 0,
            )
          ],
        ),
        Text('${AppString.dateAndTimeText} : May 29, 2024 10:00 AM', style: AppStyles.h4(),
        )
      ],
    );
  }

  buildPopUpMenu(GlobalKey buttonKey,List<dynamic> numberList) {
    WidgetsBinding.instance.addPostFrameCallback((__) {
      RenderBox currentRenderObject = buttonKey.currentContext?.findRenderObject() as RenderBox;
      final buttonPosition = currentRenderObject.localToGlobal(Offset.zero);
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(buttonPosition.dx.w, buttonPosition.dy.h + 98.h, 0, 0),
        items: numberList.map(
              (number) => PopupMenuItem(
                child: Text(number),
                onTap: () {
                  Text(number);
                },
              ),
            ).toList(),
      );
    });
  }
}

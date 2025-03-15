import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:golf_game_play/app/modules/assign_group/controllers/assign_group_controller.dart';
import 'package:golf_game_play/app/modules/assign_group/model/tournament_name_model.dart';
import 'package:golf_game_play/app/modules/assign_group/model/tournament_player_list_model.dart';
import 'package:golf_game_play/app/modules/tournament_detail/model/tournament_detail_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

class AssignGroupView extends StatefulWidget {
  const AssignGroupView({super.key});

  @override
  State<AssignGroupView> createState() => _AssignGroupViewState();
}

class _AssignGroupViewState extends State<AssignGroupView> {
  final AssignGroupController _assignGroupController = Get.put(AssignGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
              Obx((){
                List<TournamentNameAttributes> tournamentNameList =_assignGroupController.myTournamentNameModel.value.data?.attributes??[];
                if(tournamentNameList.isEmpty){
                  return Text('You have no available tournament');
                }
                TournamentNameAttributes? selectedValue = tournamentNameList.contains(_assignGroupController.tournamentNameAttributes.value)
                    ? _assignGroupController.tournamentNameAttributes.value
                    : null;
                return DropdownButtonFormField<TournamentNameAttributes>(
                  /// Dropdown button field======================<<<<<<<<
                  value: selectedValue,
                  padding: EdgeInsets.zero,
                  hint: Text("Select your tournament"),
                  decoration: InputDecoration(),
                  items: tournamentNameList.map((tournament) => DropdownMenuItem<TournamentNameAttributes>(
                      value: tournament,
                      child: Text('${tournament.tournamentName??tournament.clubName}'),
                    ),
                  ).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Select type';
                    }
                    return null;
                  },
                  onChanged: (newValue) async{
                    _assignGroupController.tournamentNameAttributes.value = newValue!;
                        print('Gender>>>${_assignGroupController.tournamentNameAttributes.value}');
                    setState(() {
                      _assignGroupController.groupPlayer.clear();

                    });
                        if(_assignGroupController.tournamentNameAttributes.value.typeName!.isNotEmpty){
                          await _assignGroupController.fetchTournamentPlayer(
                              _assignGroupController.tournamentNameAttributes.value.typeName!,
                              _assignGroupController.tournamentNameAttributes.value.sId!);
                        }

                  },
                  // onTap: (){
                  //   print(_assignGroupController.tournamentNameAttributes.value);
                  // },
                );
              }

              ),
              /// Players
              SizedBox(height: 10.h),
              Text('Players', style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              Obx((){
                List<TournamentPlayersItemList>  tournamentPlayersList = _assignGroupController.tournamentPlayerListModel.value.data?.attributes?.tournamentPlayersList??[];
                 if(_assignGroupController.isLoading2.value){
                   return Center(child: CircularProgressIndicator());
                 }else if(tournamentPlayersList.isEmpty){
                   return Text(" Player are empty , looks like you didn't select any tournament yet",style: AppStyles.h4(),);
                 }
               String? tournamentId = _assignGroupController.tournamentPlayerListModel.value.data?.attributes?.tournamentId;
               String? tournamentType = _assignGroupController.tournamentPlayerListModel.value.data?.attributes?.type;
                return  SizedBox(
                  height: 210.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tournamentPlayersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      GlobalKey buttonKey = GlobalKey();
                     final tournamentPlayersIndex = tournamentPlayersList[index];
                      return buildUsers(buttonKey,tournamentPlayersIndex,tournamentPlayersList.length,tournamentId!,tournamentType!);
                    },
                  ),
                );
              }

              ),

              /// No Of Groups
              SizedBox(height: 20.h),
              Divider(color: Colors.grey,),
              Text(AppString.noOfGroupsText,
                  style: AppStyles.h4(family: "Schuyler")),
              SizedBox(height: 10.h),
              Obx((){
               final groupPlayer = _assignGroupController.groupPlayer;
                return  SizedBox(
                  height: 300.h,
                  child: ListView.builder(
                    itemCount: groupPlayer.length,
                    itemBuilder: (BuildContext context, int index) {
                      final playerIndex =groupPlayer[index];
                      return buildNoOfGroup(playerIndex,index);
                    },
                  ),
                );
              }

              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomCard buildUsers(
      GlobalKey<State<StatefulWidget>> buttonKey,
      TournamentPlayersItemList tournamentPlayersItem,
      int tournamentPlayerLength, String tournamentId,String tournamentType) {
    return CustomCard(
      key: buttonKey,
      cardColor: AppColors.primaryColor,
      cardWidth: double.infinity,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      isRow: true,
      children: [
        Expanded(
            child:Text('${tournamentPlayersItem.name}',maxLines: 1,overflow: TextOverflow.ellipsis,style: AppStyles.h4(family: "Schuyler"))),
        InkWell(
          onTap: () {
            buildPopUpMenu(buttonKey,tournamentPlayerLength,tournamentId,Player(tournamentPlayersItem.name!, tournamentPlayersItem.id!),tournamentType);
          },
          child: Text(
            '+ Group ▼ ',
            style: AppStyles.h4(family: "Schuyler"),
          ),
        ),
      ],
    );
  }

  buildPopUpMenu(GlobalKey buttonKey,int playerLength,String tournamentId, Player playerName,String tournamentType) {
    print(_assignGroupController.groupPlayer);
    WidgetsBinding.instance.addPostFrameCallback((__) {
      RenderBox currentRenderObject = buttonKey.currentContext?.findRenderObject() as RenderBox;
      final buttonPosition = currentRenderObject.localToGlobal(Offset.zero);

      int fixedItemCount = calculateFixedItemCount(playerLength);
      List<String> groupNumberList = List.generate(fixedItemCount, (index)=> "Group ${index+1}");
      print(fixedItemCount);
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(buttonPosition.dx.w, buttonPosition.dy.h + 98.h, 0, 0),
        items:groupNumberList.map((group) => PopupMenuItem(
            child: Text(group),
            onTap: () {
              Text(group);
              _assignGroupController.addGroup();
                int playerIndex = _assignGroupController.groupPlayer.indexWhere((item) => item.tournamentId == tournamentId && item.groupName == group);

              if(playerIndex !=-1){
                if(_assignGroupController.groupPlayer[playerIndex].playerName.indexWhere((item)=> item.id == playerName.id) != -1){
                  Get.snackbar('Player already selected in $group', '');
                }else{
                  if(_assignGroupController.groupPlayer[playerIndex].playerName.length==4){
                    Get.snackbar('Group Is Full', '$group is filled with player');
                  }else{
                    _assignGroupController.groupPlayer[playerIndex].playerName.add(playerName);
                  }
                }

                print(_assignGroupController.groupPlayer);
              }else{
                /// here will be filter the existing group player
                _assignGroupController.groupPlayer.add(GroupPlayer([playerName] , group, tournamentId,tournamentType));
              }
               print(_assignGroupController.groupPlayer);
              // _assignGroupController.tournamentPlayerListModel.value.data?.attributes?.tournamentPlayersList?.removeWhere((player)=>player.id==playerName.id);
              setState(() {
                _assignGroupController.tournamentPlayerListModel.refresh();
              });
            },
          ),
        ).toList(),
      );
    });
  }

  int calculateFixedItemCount(int playerLength){
    double result= playerLength * 0.25; // per player is 0.25 , its 30/4 =7.50 here
     double fractionalResult = result - result.floor(); // floor-> print(1.99999.floor()); // 1  //// print((-2.00001).floor()); // -3
    if(fractionalResult==0.25  || fractionalResult==0.50 || fractionalResult==0.75){
     return result.ceil();
    }else{
      return result.floor();
    }
  }
/// Group Section
  CustomCard buildNoOfGroup(GroupPlayer groupPlayer,int index) {
    return CustomCard(
      cardWidth: double.infinity,
      padding: 4.sp,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //cardHeight: 220,
      children: [
        CustomCard(
          isRow: true,
          cardColor: AppColors.primaryColor,
          cardWidth: double.infinity,
          children: [
            Text(groupPlayer.groupName, style: AppStyles.h4(family: "Schuyler")),
            SizedBox(width: 8.w,),
            Icon(Icons.star_outlined),
          ],
        ),
        Text('Group Name : ${groupPlayer.groupName}', style: AppStyles.h4(family: "Schuyler")),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 25.h,
              width: 160.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: groupPlayer.playerName.length,
                itemBuilder: (BuildContext context, int index) {
                  GlobalKey buttonKey = GlobalKey();
                 final playerIndex = groupPlayer.playerName[index];
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child:  AppButton(
                      key: buttonKey,
                      text: playerIndex.name.substring(0,2),
                      textStyle: AppStyles.h5(),
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
                                height: 20.h,
                                value: 'UserInfo',
                                onTap: (){
                                  setState(() {
                                    groupPlayer.playerName.removeAt(index);
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${playerIndex.name} adsdasdads'.substring(0,playerIndex.name.length>12?12:playerIndex.name.length),style: AppStyles.h4(),),
                                    SizedBox(width: 8,),
                                    Expanded(child: Icon(Icons.close,color: Colors.redAccent,))
                                  ],
                                ),
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
              onTab: ()async {
                if(_assignGroupController.selectedDate[index].isNotEmpty && _assignGroupController.timeTec[index].text.isNotEmpty ){
                 await _assignGroupController.assignPlayer(groupPlayer,index);
                }else{
                  Get.snackbar('Empty Date or Time', 'Please select date & time');
                }
              },
              containerVerticalPadding: 0,
            )
          ],
        ),
        SizedBox(height: 8.h),
        Obx(() {
          return Text(
              '${AppString.dateAndTimeText} : ${_assignGroupController.selectedDate[index]} & ${_assignGroupController.timeTec[index].text}',
              style: AppStyles.h4());
        }),

        ///Date time
        SizedBox(height: 8.h),
        //Text('Date time', style: AppStyles.h4(family: "Schuyler")),
        Padding(
          padding:  EdgeInsets.all(8.0.sp),
          child: Row(
            children: [
              /// Select Date
              // SizedBox(height: 10.h),
              // Text(AppString.dateText, style: AppStyles.h4(family: "Schuyler")),
              // SizedBox(height: 10.h),
              Obx(() => Expanded(
                child: GestureDetector(
                  onTap: () async {
                    _assignGroupController.selectDate(context,index);
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Get.theme.primaryColor.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(14.r),
                        color: AppColors.fillColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_assignGroupController.selectedDate[index].isNotEmpty
                              ? _assignGroupController.selectedDate[index]
                              : 'Select Date',
                            // age(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal)
                          ),
                          SvgPicture.asset(AppIcons.calenderIcon)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ),
              /// Time
              SizedBox(width: 10.h),
              // Text('Time', style: AppStyles.h4(family: "Schuyler")),
              // SizedBox(height: 10.h),
              Expanded(
                child: CustomTextField(
                  contentPaddingVertical: 12.h,
                  hintText: "08:30 pm",
                  keyboardType: TextInputType.text,
                  controller:_assignGroupController.timeTec[index],
                  onChange: (value){

                    setState(() {
                      _assignGroupController.timeTec[index].text = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
@override
  void dispose() {
  _assignGroupController.tournamentPlayerListModel.close();
    super.dispose();
  }

}

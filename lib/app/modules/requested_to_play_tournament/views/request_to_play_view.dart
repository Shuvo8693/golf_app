import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/requested_to_play_tournament/controllers/request_to_play_tournament_controller.dart';
import 'package:golf_game_play/app/modules/requested_to_play_tournament/model/request_to_play_model.dart';
import 'package:golf_game_play/app/modules/requested_to_play_tournament/widgets/request_to_play_item_card.dart';

import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/app_button.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';

class RequestedToPlayTournamentView extends StatefulWidget {

  const RequestedToPlayTournamentView({super.key});

  @override
  State<RequestedToPlayTournamentView> createState() => _RequestedToPlayTournamentViewState();
}

class _RequestedToPlayTournamentViewState extends State<RequestedToPlayTournamentView> {

  final RequestedToPlayTournamentController _requestToPlayTournamentController = Get.put(RequestedToPlayTournamentController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      await _requestToPlayTournamentController.fetchRequestedPlayerList();
    });
    _scrollController.addListener(()async{
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent -200 && !_requestToPlayTournamentController.isFetchingMore.value){
        await _requestToPlayTournamentController.loadMorePage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child:
                    Text(AppString.requestToPlayText, style: AppStyles.h1()),
              ),
              SizedBox(height: 12.h),
              // Row(
              //   children: [
              //     Expanded(
              //       child: CustomTextField(
              //         filColor: AppColors.grayLight,
              //         contentPaddingVertical: 20.h,
              //         prefixIcon: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Icon(
              //             Icons.search_outlined,
              //             size: 25,
              //           ),
              //         ),
              //         hintText: 'Search...',
              //         controller: _requestToPlayTournamentController.searchCtrl,
              //         onChange: (value) {},
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 30.h),
              //Text('80+ Results'),
              SizedBox(height: 8.h),
              Obx((){
               List<RequestToPlayData> requestToPlayData = _requestToPlayTournamentController.requestToPlayModel.value.data??[];
               if(_requestToPlayTournamentController.isLoading.value){
                 return Center(child: CircularProgressIndicator());
               }
               if(requestToPlayData.isEmpty){
                 return Text('Player request is empty',style: AppStyles.h3(),);
               }
                return Expanded(
                  child: ListView.builder(
                    itemCount: requestToPlayData.length + (_requestToPlayTournamentController.isFetchingMore.value ? 1:0),
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if(requestToPlayData.length == index ){
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical: 16.h),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final requestToPlayDataIndex = requestToPlayData[index];
                      return RequestToPlayItemCard( requestToPlayData: requestToPlayDataIndex );
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

  void _showChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Dismiss the bottom sheet
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(' Spring Swing Classic', style: AppStyles.h2()),
              ),
              CustomCard(
                cardWidth: double.infinity,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text('${AppString.nameText} : Stan1 ', style: AppStyles.h4()),
                  SizedBox(height: 10.h),
                  SizedBox(height: 7.h),
                  Text('${AppString.handicapText} : 4', style: AppStyles.h4()),
                  SizedBox(height: 10.h),
                  SizedBox(height: 7.h),
                  Text('${AppString.scoreText} : 72', style: AppStyles.h4()),
                  SizedBox(height: 10.h),
                  SizedBox(height: 20.h),
                  AppButton(
                    text: AppString.sendText,
                    onTab: () {},
                    width: double.infinity,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}



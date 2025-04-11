import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/bottom_menu/bottom_menu..dart';
import 'package:golf_game_play/app/modules/message/model/Messenger_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/date_time_formation/data_age_formation.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_appBar_title.dart';
import 'package:golf_game_play/main.dart';
import 'package:intl/intl.dart';

import '../controllers/messenger_controller.dart';

class MessageView extends StatelessWidget {
  MessageView({super.key});

  final MessengerController _messengerController =
      Get.put(MessengerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(3),
      appBar: CustomAppBarTitle(text: 'Message'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            /// Friend List

            Obx(() {
              List<MessageAttributes> messageAttributes = _messengerController.messageModel.value.data?.attributes??[];

              if(_messengerController.isLoading.value){
                return Center(child: CircularProgressIndicator());
              }
              else if(messageAttributes.isEmpty){
                return Center(child: Text('No Message'));
              }
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: messageAttributes.length,
                  itemBuilder: (context, index) {
                    MessageAttributes messageAttributeIndex = messageAttributes[index];
                    if(messageAttributeIndex.type == 'single'){
                    Participants? participantId = messageAttributeIndex.participants?.firstWhereOrNull((participant)=>participant.id!=myId);
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          Get.toNamed(Routes.MESSAGE_INBOX,arguments: {'messengerAttributes':messageAttributeIndex});
                        },
                        leading: CustomNetworkImage(
                          imageUrl: "${ApiConstants.imageBaseUrl}${participantId?.image?.url}",
                          height: 60.h,
                          width: 60.h,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        title: Text(
                          participantId?.name??'',
                          style: AppStyles.h3(family: "Schuyler"),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${messageAttributeIndex.lastMessage?.message}',maxLines: 1,style: AppStyles.h5(color: Colors.black54),),
                            Text(DataAgeFormation().formatAge(messageAttributeIndex.lastMessage?.timestamp??DateTime.now()),
                                style: AppStyles.h6(family: "Schuyler",color: Colors.black54),
                            ),
                          ],
                        ),
                      );
                    }else{
                     String? tournamentImage = messageAttributeIndex.btournamentId?.tournamentImage?.url ?? messageAttributeIndex.stournamentId?.tournamentImage?.url;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          Get.toNamed(Routes.MESSAGE_INBOX,arguments: {'messengerAttributes':messageAttributeIndex});
                        },
                        leading: CustomNetworkImage(
                          imageUrl: "${ApiConstants.imageBaseUrl}${tournamentImage??''}",
                          height: 54.h,
                          width: 54.w,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        title: Text(
                          '${messageAttributeIndex.btournamentId?.clubName ?? messageAttributeIndex.btournamentId?.tournamentName}',
                          style: AppStyles.h3(family: "Schuyler"),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${messageAttributeIndex.lastMessage?.message}',maxLines: 1,style: AppStyles.h5(color: Colors.black54),),
                            Text(DataAgeFormation().formatAge(messageAttributeIndex.lastMessage?.timestamp??DateTime.now()),
                              style: AppStyles.h6(family: "Schuyler",color: Colors.black54),
                            ),
                          ],
                        ),
                      );
                    }

                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

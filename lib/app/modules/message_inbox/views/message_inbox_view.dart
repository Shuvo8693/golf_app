import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/message/model/Messenger_model.dart'
    show MessageAttributes, Participants;

import 'package:golf_game_play/app/modules/message_inbox/controllers/message_inbox_controller.dart';
import 'package:golf_game_play/app/modules/message_inbox/model/chat_model.dart'
    show ChatAttributes;
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/date_time_formation/data_age_formation.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:golf_game_play/main.dart';
import 'package:intl/intl.dart';

import '../controllers/send_message_controller.dart';

class MessageInboxView extends StatefulWidget {
  const MessageInboxView({super.key});

  @override
  State<MessageInboxView> createState() => _MessageInboxViewState();
}

class _MessageInboxViewState extends State<MessageInboxView> {
  final TextEditingController _msgCtrl = TextEditingController();
  final SendMessageController _sendMessageController = Get.put(SendMessageController());
  final MessageInboxController _messageInboxController = Get.put(MessageInboxController());
  final List<String> menuOptions = ['View Profile'];
  String? messageType;
  String? tournamentCreatorId;
  String? roomChatId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set to true so the body automatically adjusts when keyboard appears
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 65.h,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 40.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.textColor),
            onPressed: () {
              Get.back();
            }
          ),
        ),
        title: Obx(() {
          MessageAttributes? messageAttributes = _messageInboxController.messageAttributesMdl.value;
          if (messageAttributes.sId == null) {
            return SizedBox.shrink();
          }
          if(messageAttributes.type != null){
            WidgetsBinding.instance.addPostFrameCallback((__){
              messageType = messageAttributes.type??'single';
              tournamentCreatorId = messageAttributes.btournamentId?.tournamentCreatorId?? messageAttributes.stournamentId?.tournamentCreatorId;
              roomChatId = messageAttributes.sId;
              setState(() {});
            });

          }
          if (messageAttributes.type == 'single') {
            Participants? participants = messageAttributes.participants?.firstWhere((item) => item.id != _messageInboxController.myID, orElse: () => Participants());
            return Row(
              children: [
                CustomNetworkImage(
                  imageUrl: "${ApiConstants.imageBaseUrl}${participants?.image?.url}",
                  height: 40.h,
                  width: 40.w,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(participants?.name??'', style: AppStyles.h5()),
                    //Text('asd', style: AppStyles.h6(color: AppColors.dark2Color)),
                  ],
                ),
              ],
            );
          }
          if (messageAttributes.type == 'group') {
            String? tournamentImage = messageAttributes.btournamentId?.tournamentImage?.url ?? messageAttributes.stournamentId?.tournamentImage?.url;
            String? tournamentName = messageAttributes.btournamentId?.clubName ?? messageAttributes.stournamentId?.tournamentName;
            return Row(
              children: [
                CustomNetworkImage(
                  imageUrl: "${ApiConstants.imageBaseUrl}$tournamentImage",
                  height: 40.h,
                  width: 40.w,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$tournamentName', style: AppStyles.h5()),
                    //Text('asd', style: AppStyles.h6(color: AppColors.dark2Color)),
                  ],
                ),
              ],
            );
          }
          return SizedBox.shrink();
        }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Image.asset(AppIcons.golfLogoMain, height: 40),
          ),
        ],
      ),
      body: GestureDetector(
        // Add this to dismiss keyboard when tapping outside
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            if (messageType == 'group')
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text('Any one can text each other but only tournament creator can post image',textAlign: TextAlign.center,style: AppStyles.h6(color: AppColors.primaryColor),),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  final chatAttributesList = _messageInboxController.chatAttributesList;
                  if (_messageInboxController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (chatAttributesList.isEmpty) {
                    return Center(child: Text('No Message'));
                  }
                  return ListView.builder(
                    // reverse: false,// Start from the bottom
                    controller: _messageInboxController.scrollController,
                    padding: EdgeInsets.only(bottom: 10.h),
                    itemCount: chatAttributesList.length,
                    itemBuilder: (context, index) {
                      final chatAttributesIndex = chatAttributesList[index];
                      if (chatAttributesIndex.sender?.id == _messageInboxController.myID) {
                        return senderBubble(context, chatAttributesIndex);
                      } else {
                        return receiverBubble(context, chatAttributesIndex);
                      }
                    },
                  );
                }),
              ),
            ),

            // Message input bar - fixed at bottom
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ],
              ),
              padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 10,
                  bottom: 10 + MediaQuery.of(context).padding.bottom),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      contentPaddingVertical: 15.h,
                      hintText: 'Send Message',
                      controller: _msgCtrl,
                      suffixIcon: InkWell(
                        onTap: tournamentCreatorId.toString() == _messageInboxController.myID && messageType == 'group' ? () async {
                          await _sendMessageController.pickImageFromGallery();
                          print(_sendMessageController.filePath.value);
                        }:messageType == 'single'?()async{
                          await _sendMessageController.pickImageFromGallery();
                          print(_sendMessageController.filePath.value);
                        }: null ,
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SvgPicture.asset(
                            AppIcons.fileIcon,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () async {
                      if (_msgCtrl.text.isNotEmpty) {
                        try {
                          await _messageInboxController.sendMessage(
                            message: _msgCtrl.text,
                            media: '',
                            messageType: 'text',
                          );
                          _msgCtrl.clear();
                          _messageInboxController.scrollToBottom();
                        } catch (e) {
                          Get.snackbar('Error', 'Failed to send message: $e');
                        }
                      }

                      String filePath = _sendMessageController.filePath.value;
                      if (roomChatId != null && filePath.isNotEmpty) {
                        _sendMessageController.sendMessage(() async {
                          await _messageInboxController.fetchAndListenToChatHistory();
                          _sendMessageController.filePath.value = '';
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _messageInboxController.scrollToBottom();
                          });
                        }, filePath, roomChatId!);
                      }
                    },
                    child: Container(
                      height: 55.h,
                      width: 52.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).r,
                        border: Border.all(
                          color: Get.theme.primaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.sentIcon,
                          height: 24.h,
                          width: 24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sent Message bubble
  Widget senderBubble(BuildContext context, ChatAttributes chatAttributes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.57),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showMessage(chatAttributes),
                  Text(
                    DataAgeFormation().formatAge(chatAttributes.createdAt!),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        CustomNetworkImage(
          imageUrl:
              "${ApiConstants.imageBaseUrl}${chatAttributes.sender?.image?.url}",
          height: 40.h,
          width: 40.w,
          boxShape: BoxShape.circle,
        ),
      ],
    );
  }

  /// Receive Message bubble
  Widget receiverBubble(BuildContext context, ChatAttributes chatAttributes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomNetworkImage(
          imageUrl: "${ApiConstants.imageBaseUrl}${chatAttributes.sender?.image?.url}",
          height: 40.h,
          width: 40.w,
          boxShape: BoxShape.circle,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            backGroundColor: const Color(0xff1E66CA).withOpacity(0.10),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.57),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showMessage(chatAttributes),
                  Text(
                    DataAgeFormation().formatAge(chatAttributes.createdAt!),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Show message based on type
  Widget showMessage(ChatAttributes chatAttributes) {
    if (chatAttributes.messageType == 'image') {
      return CustomNetworkImage(
        imageUrl: '${ApiConstants.imageBaseUrl}${chatAttributes.media}',
        height: 150,
        width: 150,
        boxShape: BoxShape.rectangle,
      );
    } else if (chatAttributes.messageType == 'text') {
      return Text(
        '${chatAttributes.message}',
        style: TextStyle(
            color: chatAttributes.sender?.id == _messageInboxController.myID
                ? Colors.white
                : Colors.black),
        textAlign: TextAlign.start,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

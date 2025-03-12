import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../controllers/send_message_controller.dart';

class MessageInboxView extends StatefulWidget {
  const MessageInboxView({super.key});

  @override
  State<MessageInboxView> createState() => _MessageInboxViewState();
}

class _MessageInboxViewState extends State<MessageInboxView> {
  final TextEditingController _msgCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final SendMessageController _sendMessageController =
      Get.put(SendMessageController());
  final List<String> menuOptions = [/*'Delete Message',*/ 'View Profile'];

  void scrollToBottom() {
    if (_scrollController.hasClients) {_scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 22,
                            color: AppColors.textColor,
                          )),
                    ),
                    SizedBox(width: 10.w),
                    CustomNetworkImage(
                      imageUrl: "",
                      height: 50.h,
                      width: 50.w,
                      boxShape: BoxShape.circle,
                    ),

                    SizedBox(width: 16.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('', style: AppStyles.h5()),
                        Text('',
                          style: AppStyles.h6(color: AppColors.dark2Color),
                        )
                      ],
                    ),

                    // Expanded(
                    //   child: Align(
                    //     alignment: Alignment.centerRight,
                    //     child: PopupMenuButton<String>(
                    //       icon: SvgPicture.asset(AppIcons.messageMenuIcon),
                    //       onSelected: (value) {
                    //         if (value == 'Delete Message') {
                    //           print('Delete message');
                    //         } else if (value == 'View Profile') {
                    //           print('View profile');
                    //         }
                    //       },
                    //       itemBuilder: (BuildContext context) {
                    //         return menuOptions.map((String option) {
                    //           return PopupMenuItem<String>(
                    //             onTap: () {},
                    //             value: option,
                    //             child: Text(option),
                    //           );
                    //         }).toList();
                    //       },
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                          child: Image.asset(AppIcons.golfLogoMain,height: 50,)),
                    ),
                  ],
                ),
              ),
            ),
          )),

      ///=========== Body message area ==========
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.15),
                    controller: _scrollController,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      if (index == 2 && index == 4) {
                        return senderBubble(context);
                      } else {
                        return receiverBubble(context);
                      }
                    },
                  )),
                ],
              ),
            ),
          ),

          // GroupedListView<String, DateTime>(
          //   elements: _chatController.chatModelList,
          //   controller: _chatController.scrollController,
          //   padding: EdgeInsets.symmetric(horizontal: 20.w),
          //   order: GroupedListOrder.DESC,
          //   itemComparator: (item1, item2) =>
          //       item1.createdAt!.compareTo(item2.createdAt!),
          //   groupBy: (InboxChatModel message) => DateTime(
          //       message.createdAt!.year,
          //       message.createdAt!.month,
          //       message.createdAt!.day
          //   ),
          //   reverse: true,
          //   shrinkWrap: true,
          //   // physics: const AlwaysScrollableScrollPhysics(),
          //   groupSeparatorBuilder: (DateTime date) {
          //     return const SizedBox();
          //   },
          //   itemBuilder: (context,String id) {
          //     return id == currentUserId
          //         ? senderBubble(context,)
          //         : receiverBubble(context,);
          //   },
          // ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20),
              child: Row(
                children: [
                  ///>>>>>>>>>>>>>>>>>> Text Field >>>>>>>>>>>>>>>>>>>>
                  Expanded(
                      child: CustomTextField(
                    contentPaddingVertical: 15.h,
                    hintText: 'Sent Massage',
                    controller: _msgCtrl,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _sendMessageController.pickImageFromGallery();
                        print(_sendMessageController.filePath.value);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AppIcons.fileIcon,
                          height: 16.h,
                          width: 16.w,
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 10.w,
                  ),

                  ///>>>>>>>>>>>>>>>>>> Sent Message Button >>>>>>>>>>>>>>>>>>>>
                  Obx(() {
                    if (_sendMessageController.isLoading.value) {
                      return Center(child: CupertinoActivityIndicator());
                    }
                    return InkWell(
                      onTap: () async {
                        if ('participantChatId'.isNotEmpty) {
                          try {
                            await _sendMessageController.sendMessage(
                              _msgCtrl.text,
                              _sendMessageController.filePath.value,
                              'receiverId',
                              'participantChatId',
                            );
                            _msgCtrl.text = '';
                            _sendMessageController.filePath.value = '';
                            scrollToBottom();
                          } catch (e) {
                            Get.snackbar('Error', 'Failed to send message: $e');
                          }
                        }
                      },
                      child: Container(
                        height: 55.h,
                        width: 52.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10).r,
                          border: Border.all(
                              color: Get.theme.primaryColor.withOpacity(0.2)),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.sentIcon,
                            height: 24.h,
                            width: 24,
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Sent Massage bubble
  senderBubble(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(
              type: BubbleType.sendBubble,
            ),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showMessage(),

                  ///====Show message=====
                  Text(
                    DateFormat('hh:mm a').format(DateTime.now()),
                    // DateFormatHelper.formatTimeHHMM(chatModel.createdAt!),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        CustomNetworkImage(
          imageUrl: "", // Use a placeholder image URL if null
          height: 50.h,
          width: 50.w,
          boxShape: BoxShape.circle,
        ),
      ],
    );
  }

  /// Receive Massage bubble
  receiverBubble(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomNetworkImage(
          imageUrl: "", // Use a placeholder image URL if null
          height: 50.h,
          width: 50.w,
          boxShape: BoxShape.circle,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(
              type: BubbleType.receiverBubble,
            ),
            //alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            backGroundColor: const Color(0xff1E66CA).withOpacity(0.10),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showMessage(),

                  ///========show message===
                  Text(
                    DateFormat('hh:mm a').format(DateTime.now()),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget showMessage() {
    if ('image' == 'image') {
      return CustomNetworkImage(
        imageUrl: '',
        height: 150,
        width: 150,
        boxShape: BoxShape.rectangle,
      );
    } else if ('text' == 'text') {
      return Text(
        '',
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.start,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

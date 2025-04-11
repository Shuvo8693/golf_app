
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/message/model/Messenger_model.dart';
import 'package:golf_game_play/app/modules/tournament_detail/model/tournament_detail_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class ChatCreationController extends GetxController {
  RxBool isLoading= false.obs;
  Rx<MessageAttributes> messageAttributesMdl = MessageAttributes().obs;
  String? myId;

  createChatWithTournamentCreator() async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      Map<String, dynamic> body = {
        'participants': [myId].toList(),
      };

      var request = http.Request('POST', Uri.parse(ApiConstants.singleChatUrl));
      request.body= jsonEncode(body);
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        messageAttributesMdl.value = MessageAttributes.fromJson(decodedBody['data']['attributes']);
        Get.toNamed(Routes.MESSAGE_INBOX,arguments: {'messengerAttributes': messageAttributesMdl.value});
      } else {
        print('Error: ${response.statusCode}');
        Get.snackbar('Failed', decodedBody['message']);
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isLoading2 = false.obs;

  createGroupChat() async {
    isLoading2.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String tournamentId =Get.arguments['myTournamentId'];
      String tournamentType = Get.arguments['tournamentType'];

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      Map<String, dynamic> body = {
        'tournamentid': tournamentId,
        "type": tournamentType
      };

      var request = http.Request('POST', Uri.parse(ApiConstants.groupChatUrl));
      request.body= jsonEncode(body);
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        messageAttributesMdl.value = MessageAttributes.fromJson(decodedBody['data']['attributes']);
        Get.toNamed(Routes.MESSAGE_INBOX,arguments: {'messengerAttributes': messageAttributesMdl.value});
      } else {
        print('Error: ${response.statusCode}');
        Get.snackbar('Failed', decodedBody['message']);
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoading2.value = false;
    }
  }
}

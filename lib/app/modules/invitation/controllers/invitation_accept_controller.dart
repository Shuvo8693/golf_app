import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/invitation/controllers/invitation_controller.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class InvitationAcceptController extends GetxController {
  RxBool isLoading = false.obs;
final InvitationController? invitationController;

  InvitationAcceptController({this.invitationController});

  acceptRequest(String invitationSid,{required Function() updateFromIndex}) async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('PUT', Uri.parse(ApiConstants.invitationAcceptUrl(invitationSid)));

      request.headers.addAll(headers);

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Location update body: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
      var invitationIndex =  invitationController?.invitationModel.value.data?.attributes?.indexWhere((data)=> data.sId == invitationSid);
      print(invitationIndex);
      if(invitationIndex !=null && invitationIndex != -1){
        final invitation = invitationController?.invitationModel.value.data?.attributes?[invitationIndex];
        if(invitation !=null){
          invitation.isAccepted = true;
          print(invitation.isAccepted );
          invitationController?.invitationModel.refresh();
        }
      }
        print(decodedBody['message']);
        Get.snackbar('Success', decodedBody['message']);
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
}

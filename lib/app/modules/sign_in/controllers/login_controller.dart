import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class SignInController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  //ProfileAttributes profileAttributes = ProfileAttributes();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> login() async {
    isLoading.value = true;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'email': emailCtrl.text.trim(),
      'password': passCtrl.text
    };
    final request = http.Request('POST', Uri.parse(ApiConstants.logInUrl))
      ..headers.addAll(headers)
      ..body = jsonEncode(body);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String token = responseData['data']['attributes']['tokens']['access']['token'];
        String userId = responseData['data']['attributes']['user']['id'];
        if (token.isNotEmpty) {
          await PrefsHelper.setString('token', token);
          await PrefsHelper.setString('userId', userId);
          String getToken = await PrefsHelper.getString('token');
          String appUserId = await PrefsHelper.getString('userId');
          print(getToken);
          print(appUserId);
          Get.offAllNamed(Routes.HOME);
        }

      }else{
        Get.snackbar(
          'Error',
          responseData['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    }  on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    }catch(e){
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

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}

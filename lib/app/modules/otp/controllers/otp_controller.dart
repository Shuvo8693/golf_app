import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  TextEditingController otpCtrl = TextEditingController();
  RxString otpErrorMessage=''.obs;
  var verifyLoading = false.obs;

  Future<void> sendOtp(bool isResetPass) async {
    Map<String,String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      verifyLoading.value=true;
      var body = {'email': Get.arguments['email'].toString() ,'oneTimeCode':otpCtrl.text };
      var response = await http.post(Uri.parse(ApiConstants.verifyEmailWithOtpUrl), body:  jsonEncode(body),headers: headers);
      final responseData = jsonDecode( response.body);
      if (response.statusCode == 200) {

       String accessToken = responseData['data']['attributes']['tokens']['access']['token'];
         if (accessToken.isNotEmpty && isResetPass) {
           await PrefsHelper.setString('token', accessToken);
           String token = await PrefsHelper.getString('token');
           print(token);
         }
        if(isResetPass){
          Get.toNamed(Routes.RESET_PASSWORD,arguments: {'email': Get.arguments['email']});
        }else{
          Get.toNamed(Routes.SIGN_IN);
        }

      } else {
        print('Error>>>');
        print('Error>>>${response.body}');
        otpErrorMessage.value = responseData['message'];
        Get.snackbar(otpErrorMessage.value.toString(), '');
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }catch(e){
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    }finally{
      verifyLoading.value=false;
    }
  }
  @override
  void onClose() {
    otpCtrl.dispose();
    super.onClose();
  }
}

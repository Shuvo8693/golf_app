import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;


class ResetPasswordController extends GetxController {
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  RxBool isLoading = false.obs;

   resetPassword(Function() callBack) async {
    isLoading.value = false;
    String token = await PrefsHelper.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
       'Authorization':'Bearer $token'
    };
  //  String email= Get.arguments['email'];
    var body = {
      'password': confirmPassCtrl.text
    };

    try {
      var response = await http.post(Uri.parse(ApiConstants.resetPasswordUrl), body: jsonEncode(body),headers: headers);
      final responseData = jsonDecode( response.body);
      if (response.statusCode == 200) {
        print(responseData.toString());
        callBack();
      } else {
        print('Error>>>');
        print('Error>>>${response.body}');
        Get.snackbar(
          'Error',
          responseData['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    } on SocketException catch (_) {
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
    }finally{
      isLoading.value = false;
    }

  }

  @override
  void onClose() {
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }
}

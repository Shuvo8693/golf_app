import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';

class MyProfileController extends GetxController {
  Rx<MyProfile> myProfile = MyProfile().obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  fetchProfile(Function() noInternet) async {
    try {
      isLoading.value = true;
      String token = await PrefsHelper.getString('token');

      bool isExpired = false;
      if (token.isNotEmpty) {
        try {
          isExpired = JwtDecoder.isExpired(token);
        } catch (e) {
          isExpired = true;
        }
      }

      if (token.isEmpty || isExpired) {
        await PrefsHelper.remove('token');
        Get.offAllNamed(Routes.SIGN_IN);
        return;
      }

      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(ApiConstants.userProfileUrl));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        var profileValue =
            responseData['data']['attributes']['user'] as Map<String, dynamic>;
        myProfile.value = MyProfile.fromJson(profileValue);
      } else if (response.statusCode == 401) {
        await PrefsHelper.remove('token');
        Get.offAllNamed(Routes.SIGN_IN);
      } else {
        print('Error>>>');
        isLoading.value = false;
        errorMessage.value = 'Failed to load data';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            'Error',
            errorMessage.value,
            snackPosition: SnackPosition.TOP,
          );
        });
      }
    } on SocketException catch (_) {
      noInternet();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'No internet connection. Please check your network and try again.',
          snackPosition: SnackPosition.TOP,
        );
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again later.',
          snackPosition: SnackPosition.TOP,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    myProfile.close();
    super.onClose();
  }
}

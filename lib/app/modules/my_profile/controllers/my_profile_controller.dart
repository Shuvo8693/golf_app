import 'dart:convert';
import 'dart:io';

import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  Rx<MyProfile> myProfile = MyProfile().obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  fetchProfile(Function() noInternet) async {
    try {
      isLoading.value=true;
      String token = await PrefsHelper.getString('token');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(ApiConstants.userProfileUrl));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        var profileValue= responseData['data']['attributes']['user'] as Map<String,dynamic>;
        myProfile.value =MyProfile.fromJson(profileValue);
      } else {
        print('Error>>>');
        isLoading.value=false;
        errorMessage.value = 'Failed to load data';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.TOP,
        );
      }
    } on SocketException catch (_) {
      noInternet();
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
    myProfile.close();
    super.onClose();
  }
}


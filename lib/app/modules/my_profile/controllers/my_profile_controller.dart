import 'dart:convert';

import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MyProfileController extends GetxController {
 // Rx<Profile> profile=Profile().obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  fetchProfile(dynamic userId) async {
    try {
      isLoading.value=true;
      String token = await PrefsHelper.getString('token');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(ApiConstants.getProfileUrl(userId)));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        var profileValue= responseData['data']['attributes'] as Map<String,dynamic>;
      //  profile.value= Profile.fromJson(profileValue);
        isLoading.value=false;
      } else {
        print('Error>>>');
        isLoading.value=false;
        errorMessage.value = 'Failed to load data';
      }
    } on Exception catch (error) {
      print(error.toString());
      isLoading.value=false;
      errorMessage.value = 'Something when wrong';
    }
  }
  @override
  void onClose() {
   // profile.close();
    super.onClose();
  }
}


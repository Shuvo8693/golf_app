import 'dart:convert';

import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';



class AboutUsController extends GetxController {
  RxString errorMessage = ''.obs;
  RxString content = ''.obs;
  RxBool isLoading = false.obs;
  fetchAboutUs() async {
    try {
      isLoading.value=true;
      String token = await PrefsHelper.getString('token');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(ApiConstants.aboutUsUrl));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        final aboutUsText = responseData['data']['attributes']['aboutUsText'];
        if(aboutUsText.isNotEmpty){
          content.value = aboutUsText;
        }
        print(content.value);
      } else {
        print('Error>>>');
        errorMessage.value = 'Failed to load data';
      }
    } on Exception catch (error) {
      print(error.toString());
      errorMessage.value = 'Something went wrong';
    }finally {
      isLoading.value=false;
    }
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:http/http.dart' as http;


class SettingsController extends GetxController {

  RxBool isLoading = false.obs;

  deleteAccount() async {
    try {
      isLoading.value = true;
      var request = http.Request('POST', Uri.parse(ApiConstants.supportUrl));
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        List<
            dynamic> contentMapData = responseData['data']['attributes'] as List<
            dynamic>;
      } else {
        print('Error>>>');
      }
    } on Exception catch (error) {
      print(error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

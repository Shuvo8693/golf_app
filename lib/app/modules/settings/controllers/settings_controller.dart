import 'dart:convert';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class SettingsController extends GetxController {
  RxBool isLoading = false.obs;

  deleteAccount() async {
    String token = await PrefsHelper.getString('token');
    final payload = decodeJWT(token);
    String userId = payload['sub'];
    try {
      isLoading.value = true;
      var request = http.Request('DELETE', Uri.parse(ApiConstants.accountDeleteUrl(userId)));
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        await PrefsHelper.remove('token').then((v){
          Get.offAllNamed(Routes.SIGN_IN);
        });
      } else {
        print('Error>>>');
        Get.snackbar('Failed to deletion', responseData['message'].toString());
      }
    } on Exception catch (error) {
      print(error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

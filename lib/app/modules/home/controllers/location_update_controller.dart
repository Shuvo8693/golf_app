import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/home/controllers/current_location_controller.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class LocationUpdateController extends GetxController {
 CurrentLocationController? currentLocationController;

  LocationUpdateController({this.currentLocationController});

 RxBool isLoading= false.obs;

  Future<void> updateLocation({Function(String?)? callBack}) async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      Map<String, String> body = {
        "longitude": currentLocationController?.longitude?.value.toString()??'',
        "latitude": currentLocationController?.latitude?.value.toString()??''
      };

      var request = http.Request('PATCH', Uri.parse(ApiConstants.locationUpdateUrl));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Location update body: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        print(decodedBody);
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

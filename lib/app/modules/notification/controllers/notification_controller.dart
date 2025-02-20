import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/home/controllers/current_location_controller.dart';
import 'package:golf_game_play/app/modules/notification/model/notification_model.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  Rx<NotificationModel> notificationModel = NotificationModel().obs;
  RxBool isLoading1= false.obs;
  /// Fetch notification
  fetchNotification() async {
    isLoading1.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.notificationUrl));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        print(decodedBody['message']);
         notificationModel.value= NotificationModel.fromJson(decodedBody);
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
      isLoading1.value = false;
    }
  }




  /// Mark as read
 RxBool isLoading2 = false.obs;

  markAsRead({Function(String?)? callBack,String? notificationId}) async {
    isLoading2.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };


      var request = http.Request('PATCH', Uri.parse(ApiConstants.markAsReadNotificationUrl(notificationId)));

      request.headers.addAll(headers);

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response Body: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        print(decodedBody['message']);
        Get.toNamed(Routes.REQUEST_TO_PLAY,arguments: {'tournamentId':'${decodedBody['data']['attributes']['tournamentId']}'});
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
      isLoading2.value = false;
    }
  }
}

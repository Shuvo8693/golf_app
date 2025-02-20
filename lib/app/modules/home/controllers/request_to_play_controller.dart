import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/home/controllers/current_location_controller.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class RequestSendToPlayController extends GetxController {

   RxMap<int,bool> isLoading = <int,bool>{}.obs;
 // RxMap<int,bool> isSmallLoading = <int,bool>{}.obs ;


  /// Club Request to play
   request({Function(String?)? callBack,String? tournamentId,String? tournamentType, required int index}) async {
    isLoading[index] = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      Map<String, String> body = {
        "tournamentId":tournamentId??'',
        "typename":tournamentType??''
      };

      var request = http.Request('POST', Uri.parse(ApiConstants.sendRequestToPlayUrl));

      request.headers.addAll(headers);
      request.body=jsonEncode(body);

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Location update body: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        print(decodedBody['message']);
        Get.snackbar('Successfully', decodedBody['message']);
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
      isLoading[index] = false;
    }
  }




  /// Small Outing Request to play
  // smallOutingRequest({Function(String?)? callBack,String? tournamentId,String? tournamentType,required int index}) async {
  //   isSmallLoading[index] = true;
  //   try {
  //     String token = await PrefsHelper.getString('token');
  //     String userId = await PrefsHelper.getString('userId');
  //
  //     Map<String, String> headers = {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json'
  //     };
  //
  //     Map<String, String> body = {
  //       "tournamentId":tournamentId??'',
  //       "typename":tournamentType??''
  //     };
  //
  //     var request = http.Request('POST', Uri.parse(ApiConstants.smallOutingRequestToPlayUrl(tournamentId)));
  //
  //     request.headers.addAll(headers);
  //     request.body=jsonEncode(body);
  //
  //     var response = await request.send();
  //     var responseBody = await http.Response.fromStream(response);
  //     print('Location update body: ${responseBody.body}');
  //     var decodedBody = jsonDecode(responseBody.body);
  //
  //     if (response.statusCode == 200) {
  //       print(decodedBody['message']);
  //       Get.snackbar('Successfully', decodedBody['message']);
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       Get.snackbar('Failed', decodedBody['message']);
  //     }
  //   } on SocketException catch (_) {
  //     Get.snackbar(
  //       'Error',
  //       'No internet connection. Please check your network and try again.',
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Something went wrong. Please try again later.',
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     print(e);
  //   } finally {
  //     isSmallLoading[index] = false;
  //   }
  // }
}


import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/tournament_detail/model/tournament_detail_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class GaggleDetailController extends GetxController {
  Rx<TournamentDetailModel> tournamentDetailModel = TournamentDetailModel().obs;
  RxBool isLoading= false.obs;

  String? myID;

  fetchTournamentDetails() async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String tournamentId =Get.arguments['myTournamentId'];
     String tournamentType = Get.arguments['tournamentType'];

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };


      var request = http.Request('GET', Uri.parse(ApiConstants.tournamentDetailsUrl(tournamentType, tournamentId)));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        tournamentDetailModel.value= TournamentDetailModel.fromJson(decodedBody);
        print(tournamentDetailModel.value);
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
 @override
  void onReady() async{
    await getMyId();
  await fetchTournamentDetails();
    super.onReady();
  }

  getMyId()async{
    String  id = await PrefsHelper.getString('userId');
      myID = id;
      update();
  }
}

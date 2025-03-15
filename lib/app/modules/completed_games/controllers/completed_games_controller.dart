
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/challenge_matches/model/challenge_match_model.dart';
import 'package:golf_game_play/app/modules/completed_games/model/complete_game_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class CompletedGamesController extends GetxController {
  final TextEditingController searchCtrl =TextEditingController();
  Rx<CompleteTournamentModel> completeTournamentModel = CompleteTournamentModel().obs;
  RxBool isLoading1= false.obs;


  fetchCompleteGames() async {
    isLoading1.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.completeGamerUrl));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        completeTournamentModel.value = CompleteTournamentModel.fromJson(decodedBody);
        print(completeTournamentModel.value);
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
  @override
  void onReady() async {
    await fetchCompleteGames();
    super.onReady();
  }

}


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/create_winner_details/model/player_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class CreateWinnerDetailsController extends GetxController {
  List<String> categoryList = ['category1', 'category2', 'category3'];
  List<int> holeList = List.generate(18, (index)=> index + 1);
  List<String> skinScoreList = [
    "Birdie",      // 1 stroke under par
    "Eagle",       // 2 strokes under par
    "Albatross",   // 3 strokes under par (also called Double Eagle)
    "Par",         // Even score with the hole’s par
    "Bogey",       // 1 stroke over par
    "Double Bogey",// 2 strokes over par
    "Triple Bogey",// 3 strokes over par
    "Skin",        // A hole won in a Skins Game
    "Carryover",   // When a skin carries over due to a tie
    "Hole-in-One"  // Ace (scoring 1 on any hole)
  ];

  List<String> amountIsPaid = ['Yes','No'];

  TextEditingController winnerRoundCtrl =TextEditingController();
  TextEditingController looserRoundCtrl =TextEditingController();
  TextEditingController amountCtrl =TextEditingController();
  TextEditingController kpFeetCtrl =TextEditingController();
  TextEditingController playerScoreCtrl =TextEditingController();

  String? skinWinnerName;
  String? skinWinnerId;
  int? skinHole;
  String? skinScore;
  RxString skinAmountIsPaid='No'.obs;

  String? kpWinnerName;
  String? kpWinnerId;
  int? kpHole;

  String? winnerName;
  String? winnerId;
  String? loserName;
  String? loserId;

  String? allPlayerName;
  String? allPlayerId;

  Rx<PlayerModel> playerModel = PlayerModel().obs;
  RxBool isLoading= false.obs;

  fetchPlayer(String sectionName) async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String completeTourId = await PrefsHelper.getString('completeTourID');
     print(completeTourId);

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.playerListUrl(completeTourId,sectionName)));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        playerModel.value= PlayerModel.fromJson(decodedBody);
        print(playerModel.value);
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

  ///===================== Break ==================


  postWinners(String sectionName) async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String completeTourId = await PrefsHelper.getString('completeTourID');
     print(completeTourId);

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      ///Skin Body
      bool isPaidSkin= skinAmountIsPaid.value == 'Yes'? true : false;
      Map<String, dynamic> bodySkin = {
        "tournament":completeTourId,
        "skinWinner":skinWinnerId??'',
        "skinHole":skinHole,
        "skinScore":skinScore,
        "skinIsPaid": isPaidSkin,
        "skinPaidAmount":amountCtrl.text
      };

      Map<String, dynamic> bodyKps = {
        "tournament":completeTourId,
        "kpsWinner":kpWinnerId??'',
        "kpsHole":kpHole,
        "kpsFeet":kpFeetCtrl.text,
      };

      Map<String, String> bodyTopWinner = {
        "tournament":completeTourId,
        "challengeWinner":winnerId??'',
        "winnerRound":winnerRoundCtrl.text,
        "challengeLoser":loserId??'',
        "loserRound":looserRoundCtrl.text
      };

      Map<String, String> bodyScore = {
        "tournament":completeTourId,
        "name":allPlayerId??'',
        "score":playerScoreCtrl.text
      };

      var request = http.Request('POST', Uri.parse(ApiConstants.postWinnersUrl(sectionName)));

      request.headers.addAll(headers);
      //requestBody(sectionName, request, bodySkin, bodyKps, bodyTopWinner, bodyScore);
      switch (sectionName){
        case 'skin':
           request.body=jsonEncode(bodySkin);
           break;
        case 'kps':
           request.body=jsonEncode(bodyKps);
           break;
        case 'chalangeMatch':
           request.body=jsonEncode(bodyTopWinner);
           break;
        case 'playerScore':
           request.body=jsonEncode(bodyScore);
           break;
        default:
          throw Exception("Invalid section name: $sectionName");
      }
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 201) {
        Get.snackbar('Success', decodedBody['message']);
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

  requestBody(
      String sectionName,
      http.Request request,
      Map<String, String> bodySkin,
      Map<String, String> bodyKps,
      Map<String, String> bodyTopWinner,
      Map<String, String> bodyScore
      ){
    switch (sectionName){
      case 'skin':
        return request.body=jsonEncode(bodySkin);
      case 'kps':
        return request.body=jsonEncode(bodyKps);
      case 'chalangeMatch':
        return request.body=jsonEncode(bodyTopWinner);
      case 'playerScore':
        return request.body=jsonEncode(bodyScore);
      default:
        return 'Unknown section name';
    }
  }


}

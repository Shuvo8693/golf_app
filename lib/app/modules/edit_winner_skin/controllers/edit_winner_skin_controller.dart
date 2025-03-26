import 'package:get/get.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/create_winner_details/model/player_model.dart';
import 'package:golf_game_play/app/modules/winners/model/winner_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class EditWinnerSkinController extends GetxController {
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

  TextEditingController amountCtrl =TextEditingController();
  TextEditingController nameCtrl =TextEditingController();

  String? skinWinnerName;
  int? skinHole;
  String? skinScore;
  RxString skinAmountIsPaid = 'No'.obs;
  RxBool isLoading =false.obs;

  Skin? skin;

  updateWinners() async {
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
        "skinId": skin!.sId,
        "skinWinner": skin!.skinWinner?.id,
       if(skinHole!=null) "skinHole": skinHole,
        if(skinScore!=null && skinScore!.isNotEmpty) "skinScore": skinScore,
        "skinIsPaid": isPaidSkin,
        "skinPaidAmount": amountCtrl.text
      };

      var request = http.Request('PUT', Uri.parse(ApiConstants.updateSkinUrl));

      request.headers.addAll(headers);
      request.body=jsonEncode(bodySkin);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
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
 @override
  void onReady() {
    if(Get.arguments !=null){
      Skin skinItem = Get.arguments['skinItem'];
      skin=skinItem;
      nameCtrl.text = skin?.skinWinner?.name??'';
      amountCtrl.text = (skin?.skinPaidAmount??0).toString();
      update();
    }
    super.onReady();
  }
}

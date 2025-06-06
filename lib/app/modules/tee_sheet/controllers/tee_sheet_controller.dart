import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/tee_sheet/model/teesheet_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class TeeSheetController extends GetxController {

  Map<String,Color> teeBoxItem={
    'black' : Colors.black,
    'blue' : Colors.blue,
    'white' : Colors.white,
    'gold' : Colors.orangeAccent,
    'red' : Colors.red,
  };


  Rx<TeeSheetModel> teeSheetModel = TeeSheetModel().obs;
  RxBool isLoading= false.obs;


  fetchTeeSheet() async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String tournamentId = Get.arguments['tournamentId'];
      String tournamentType = Get.arguments['tournamentType'];
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.teeSheetUrl(tournamentId,tournamentType)));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        teeSheetModel.value= TeeSheetModel.fromJson(decodedBody);
        print(teeSheetModel.value);
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
  void onInit() async {
    super.onInit();
   await fetchTeeSheet();
  }
}

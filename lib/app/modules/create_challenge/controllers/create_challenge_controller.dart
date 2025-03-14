
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/assign_group/controllers/assign_group_controller.dart';
import 'package:golf_game_play/app/modules/assign_group/model/tournament_player_list_model.dart';
import 'package:golf_game_play/app/modules/tournament_detail/model/tournament_detail_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CreateChallengeController extends GetxController {

  String? tournamentName;
  String? player1;
  String? player2;

  Rx<TournamentPlayerListModel> tournamentPlayerListModel = TournamentPlayerListModel().obs;
  RxBool isLoading1= false.obs;

  RxList<GroupPlayer> groupPlayer = <GroupPlayer>[].obs;

  fetchTournamentPlayer(String tournamentType, String tournamentId) async {
    isLoading1.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.showAllPlayerUrl(tournamentType, tournamentId)));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        tournamentPlayerListModel.value= TournamentPlayerListModel.fromJson(decodedBody);
        print(tournamentPlayerListModel.value);
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

  ///============================= Break ================================

 TextEditingController timeTec = TextEditingController();
 RxString selectedDate='Select date'.obs;
  RxBool isLoading2= false.obs;
  /// Date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));
    // DateTime selectedDates = DateTime.parse(selectedDate.value);

    if (picked != null ) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:$selectedDate');
    }
  }

  createChallenge(TournamentDetailAttributes tournamentDetailAttributes) async {
    isLoading2.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      Map<String, String> body = {
        "gagleName":"${tournamentDetailAttributes.tournamentName??tournamentDetailAttributes.clubName}",
        "playeare1":"$player1",
        "playeare2":"$player2",
        "tournamentid":"${tournamentDetailAttributes.sId}",
        "type":"${tournamentDetailAttributes.typeName}",
        "date":selectedDate.value,
        "time":timeTec.text,
        "courseName":"${tournamentDetailAttributes.courseName}",
      };

      var request = http.Request('POST', Uri.parse(ApiConstants.createChallengeUrl));

      request.headers.addAll(headers);
      request.body= jsonEncode(body);
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
      isLoading2.value = false;
    }
  }

}

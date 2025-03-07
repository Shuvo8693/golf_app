
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/assign_group/model/tournament_name_model.dart';
import 'package:golf_game_play/app/modules/assign_group/model/tournament_player_list_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AssignGroupController extends GetxController {
  final TextEditingController timeTec= TextEditingController();

  List groupNumberList = ['Group 1','Group 2', 'Group 3','Group 4','Group 5','Group 6'];
  List<Map<String,int>> groupNumbers = [];
  RxString? selectType;
  String? groupNumber;
  RxString selectedDate = 'Select Date'.obs;

  Rx<TournamentNameModel> myTournamentNameModel = TournamentNameModel().obs;
  Rx<TournamentNameAttributes> tournamentNameAttributes = TournamentNameAttributes().obs;
  RxBool isLoading= false.obs;


  /// Date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));
    // DateTime selectedDates = DateTime.parse(selectedDate.value);

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:$selectedDate');
    }
  }

  fetchMyTournamentName() async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.myTournamentNameUrl));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        myTournamentNameModel.value= TournamentNameModel.fromJson(decodedBody);
        print(myTournamentNameModel.value);
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
  void onReady() async {
    await fetchMyTournamentName();
    super.onReady();
  }

 ///============================== Break ===================================

  Rx<TournamentPlayerListModel> tournamentPlayerListModel = TournamentPlayerListModel().obs;
  RxBool isLoading2= false.obs;

  RxList<GroupPlayer> groupPlayer = <GroupPlayer>[].obs;

  fetchTournamentPlayer(String tournamentType, String tournamentId) async {
    isLoading2.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.tournamentPlayerUrl(tournamentType, tournamentId)));

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
      isLoading2.value = false;
    }
  }

  ///============================== Break ===================================

  ///Max 288 player for big tournament, Min 8
  ///
  RxBool isLoading3= false.obs;

  assignPlayer(GroupPlayer groupPlayer) async {
    isLoading3.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      Map<String, dynamic> body = {
        "playerList":groupPlayer.playerName.map((item)=> item.id).toList(),
        "groupName":groupPlayer.groupName,
        "type":groupPlayer.tournamentType,
        "tournamentId":groupPlayer.tournamentId,
        "dateTime":"${groupPlayer.date} & ${groupPlayer.time} "
      };


      var request = http.Request('POST', Uri.parse(ApiConstants.assignPlayerUrl));

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
      isLoading3.value = false;
    }
  }
}



class GroupPlayer{
  String tournamentId;
  String tournamentType;
  String groupName;
  List<Player> playerName;
  String date;
  String time;

  GroupPlayer(this.time,this.date,this.playerName,this.groupName,this.tournamentId,this.tournamentType);

}

class Player{
  String name;
  String id;
  Player(this.name,this.id);
}

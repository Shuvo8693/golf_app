import 'dart:convert';
import 'dart:io';

import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/home/model/club_tournament_model.dart';
import 'package:golf_game_play/app/modules/home/model/small_tournament_model.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<ClubTournamentModel> clubTournamentModel = ClubTournamentModel().obs;
  Rx<SmallTournamentModel> smallTournamentModel = SmallTournamentModel().obs;
  RxString errorMessage = ''.obs;
  RxBool isLoadingClub = false.obs;
  RxBool isLoadingSmall = false.obs;
 ///Club tournament
  fetchClubTournament(Function() noInternet) async {
    try {
      isLoadingClub.value=true;
      String token = await PrefsHelper.getString('token');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(ApiConstants.clubTournamentUrl));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      print(responseData);
      if (response.statusCode == 200) {
        clubTournamentModel.value =ClubTournamentModel.fromJson(responseData);
      } else {
        print('Error>>>');
        isLoadingClub.value=false;
        errorMessage.value = 'Failed to load data';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.TOP,
        );
      }
    } on SocketException catch (_) {
      noInternet();
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    }catch(e){
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoadingClub.value = false;
    }
  }

/// Small Tournament
  fetchSmallTournament(Function() noInternet) async {
    try {
      isLoadingSmall.value=true;
      String token = await PrefsHelper.getString('token');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(ApiConstants.smallTournamentUrl));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      print(responseData);
      if (response.statusCode == 200) {
        smallTournamentModel.value =SmallTournamentModel.fromJson(responseData);
      } else {
        print('Error>>>');
        isLoadingSmall.value=false;
        errorMessage.value = 'Failed to load data';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.TOP,
        );
      }
    } on SocketException catch (_) {
      noInternet();
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    }catch(e){
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoadingSmall.value = false;
    }
  }
  @override
  void onClose() {
    clubTournamentModel.close();
    smallTournamentModel.close();
    super.onClose();
  }
}


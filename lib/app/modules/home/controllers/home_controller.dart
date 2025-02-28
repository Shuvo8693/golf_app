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

  RxString errorMessage = ''.obs;
  RxBool isLoadingClub = false.obs;

  RxBool isClubFetchingMore = false.obs;
  RxInt currentClubPage = 1.obs;
  RxInt clubLimit = 2.obs;
  RxInt totalClubPages = 1.obs;

 ///Club tournament
  fetchClubTournament(Function() noInternet,{bool isLoadMore=false }) async {
    if (isLoadMore && isClubFetchingMore.value) return;
    if(isLoadMore){
      isClubFetchingMore.value= true;
    }else{
      isLoadingClub.value=true;
      currentClubPage.value = 1;
    }
    try {
      String token = await PrefsHelper.getString('token');
      String url= '${ApiConstants.clubTournamentUrl}?page=${currentClubPage.value}&limit=${clubLimit.value}';
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
     var dataList= (responseData['data'] as List<dynamic>);
      print(responseData);
      if (response.statusCode == 200) {
        if(isLoadMore){
          clubTournamentModel.value.data??=[];
          clubTournamentModel.value.data?.addAll(dataList.map((data)=> ClubTournamentData.fromJson(data)));
        }else{
          clubTournamentModel.value = ClubTournamentModel.fromJson(responseData);
        }
        print(clubTournamentModel.value.data);
        totalClubPages.value= responseData['pagination']['totalPages']?? totalClubPages.value;
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
      print('Catch Error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,

      );
      print(e);
    } finally {
      if (isLoadMore) {
        isClubFetchingMore.value = false;
      } else {
        isLoadingClub.value = false;
      }

    }
  }

  loadMoreClubPage()async{
    if(currentClubPage.value < totalClubPages.value && !isClubFetchingMore.value){
      currentClubPage.value += 1;
      await fetchClubTournament((){},isLoadMore: true);
    }
  }

///=================================Break=============================


/// Small Tournament
  Rx<SmallTournamentModel> smallTournamentModel = SmallTournamentModel().obs;
  RxBool isLoadingSmall = false.obs;

  RxBool isOutingFetchingMore = false.obs;
  RxInt currentOutingPage = 1.obs;
  RxInt outingLimit = 2.obs;
  RxInt totalOutingPages = 1.obs;


  fetchSmallTournament(Function() noInternet,{bool isLoadMore=false }) async {
    if (isLoadMore && isOutingFetchingMore.value) return;

    if(isLoadMore){
      isOutingFetchingMore.value= true;
    }else{
      isLoadingSmall.value=true;
      currentOutingPage.value = 1;
    }

    try {
      String token = await PrefsHelper.getString('token');
      String url= '${ApiConstants.smallTournamentUrl}?page=${currentOutingPage.value}&limit=${outingLimit.value}';
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      print(responseData);
      var dataList= (responseData['data'] as List<dynamic>);
      if (response.statusCode == 200) {
        if(isLoadMore){
          smallTournamentModel.value.data??=[];
          smallTournamentModel.value.data?.addAll(dataList.map((data)=> SmallTournamentData.fromJson(data)));
        }else{
          smallTournamentModel.value =SmallTournamentModel.fromJson(responseData);
        }
        print(smallTournamentModel.value);
        totalOutingPages.value = responseData['pagination']?['totalPages']?? totalOutingPages.value;
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
      if (isLoadMore) {
        isOutingFetchingMore.value = false;
      } else {
        isLoadingSmall.value = false;
      }

    }
  }
  loadMoreOutingPage()async{
    if(currentOutingPage.value < totalOutingPages.value && !isOutingFetchingMore.value){
      currentOutingPage.value += 1;
      await fetchSmallTournament((){},isLoadMore: true);
    }
  }
  @override
  void onClose() {
    clubTournamentModel.close();
    smallTournamentModel.close();
    super.onClose();
  }
}


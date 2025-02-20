import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/notification/model/notification_model.dart';
import 'package:golf_game_play/app/modules/requested_to_play_tournament/model/request_to_play_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class RequestedToPlayTournamentController extends GetxController {
  final TextEditingController searchCtrl =TextEditingController();
  Rx<RequestToPlayModel> requestToPlayModel = RequestToPlayModel().obs;
  RxBool isLoading= false.obs;

  RxBool isFetchingMore = false.obs;
  RxInt currentPage = 1.obs;
  RxInt pageLimit = 3.obs;
  RxInt totalPages = 1.obs;

  /// Fetch notification
  fetchRequestedPlayerList({bool isLoadMore=false }) async {
    if(isLoadMore && isFetchingMore.value) return;

    if(isLoadMore){
      isFetchingMore.value = true;
    }else{
      isLoading.value=true;
      currentPage.value = 1;
    }
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      String tournamentType = Get.arguments['tournamentType'];

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse('${ApiConstants.baseUrl}/request-to-play?typename=$tournamentType&page=$currentPage&limit=$pageLimit'));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);
     final decodedData =decodedBody['data'] as List<dynamic>;

      if (response.statusCode == 200) {
        print(decodedBody['message']);
        if(isLoadMore){
          requestToPlayModel.value.data??=[];
          requestToPlayModel.value.data?.addAll(decodedData.map((data)=> RequestToPlayData.fromJson(data)));
        }else{
          requestToPlayModel.value = RequestToPlayModel.fromJson(decodedBody);
        }
        print(requestToPlayModel.value.data);
        totalPages.value= decodedBody['pagination']?['totalPages']?? totalPages.value;

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
      if(isLoadMore){
        isFetchingMore.value = false;
      }else{
        isLoading.value=false;
      }
    }
  }

  loadMorePage()async{
    if(currentPage.value < totalPages.value && !isFetchingMore.value){
      currentPage.value += 1;
      await fetchRequestedPlayerList(isLoadMore: true);
    }
  }

}

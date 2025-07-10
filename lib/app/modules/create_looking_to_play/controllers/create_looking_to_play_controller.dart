import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CreateLookingToPlayController extends GetxController {

  final TextEditingController userNameCtrl=TextEditingController();
  final TextEditingController visitingFromCtrl=TextEditingController();
  final TextEditingController golfCourseCtrl=TextEditingController();

  List categoryList = [
    'Skins',
    'Stroke Play',
    'Match Play',
    'Best Ball',
    'Alternate Shot',
    'Scramble',
    'Shamble',
    'Stableford',
    'Ryder Cup',
    'Four Ball',
    'Bingo Bango Bongo',
    'Flags',
    'Money Ball',
    'Quota',
    'Peoria System',
  ];
  LatLng? latLng;
  String? category;
  RxBool isLoading= false.obs;

  RxString selectedFromDate = 'Select Date Time'.obs;
  RxString selectedToDate = 'Select Date Time'.obs;


  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));

    if (picked != null) {
      selectedFromDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:$selectedFromDate');
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));

    if (picked != null ) {
      selectedToDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:$selectedToDate');
    }
  }
  Future<void> goToSearchLocation(String address) async {
    try {
      LatLng? locations = await GoogleApiService.fetchAddressToCoordinate(address, (location){});
      if (locations !=null) {
        latLng = locations;
        print(latLng);
      }
    } catch (e) {
      print('Error occurred while searching: $e');
    }
  }

  createLookingToPlay({Function(String?)? callBack}) async {


      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      Map<String, dynamic> body = {
        "tomDate":selectedFromDate.value,
        "fromDate": selectedToDate.value,
        "latitude": latLng?.latitude,
        "longitude": latLng?.longitude,
        "golfCourse": golfCourseCtrl.text
      };

    try {
      isLoading.value = true;
      var request = http.Request('POST', Uri.parse(ApiConstants.lookingToPlayCreationUrl));

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response Body: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

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

}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CreateLookingToPlayController extends GetxController {

  final TextEditingController userNameCtrl=TextEditingController();
  final TextEditingController visitingFromCtrl=TextEditingController();
  final TextEditingController golfCourseCtrl=TextEditingController();
  final TextEditingController cityToPlayCtrl=TextEditingController();

  List categoryList = ['category1', 'category2', 'category3'];

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
  createLookingToPlay({Function(String?)? callBack}) async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      Map<String, String> body = {
        "tomDate":selectedFromDate.value,
        "fromDate":selectedToDate.value,
        "cityToPlay":cityToPlayCtrl.text,
        "golfCourse":golfCourseCtrl.text,
        "visitingFrom":visitingFromCtrl.text,
        "userName":userNameCtrl.text
      };

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

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:http/http.dart' as http;

class ResendOtpController extends GetxController {

  var isLoading = false.obs;

  Future<void> sendMail() async {

    if (isLoading.value) {
      return; // Prevent multiple taps
    }

    isLoading.value = true; // Start loading
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'email': Get.arguments['email'].toString(),
    };

    try {
      final url = Uri.parse(ApiConstants.resendOtpUrl);
      final request = http.Request('POST', url)
        ..headers.addAll(headers)
        ..body = jsonEncode(body);

      // Send the request and get the streamed response
      final streamedResponse = await request.send();

      // Convert streamed response to a regular response
      final response = await http.Response.fromStream(streamedResponse);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Response Data: $responseData');
      } else {
        print('Error: ${response.statusCode}, Message: ${response.body}');
        Get.snackbar(
          'Error',
          responseData['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    }  on SocketException catch (_) {
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
      isLoading.value = false;
    }
  }


}

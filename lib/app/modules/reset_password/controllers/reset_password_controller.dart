import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:http/http.dart' as http;


class ResetPasswordController extends GetxController {
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();


  Future<Either<String,bool>> resetPassword() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String email= Get.arguments['email'];
    var body = {
      'email':email ,
      'password': confirmPassCtrl.text
    };

    var response = await http.post(Uri.parse(ApiConstants.resetPasswordUrl), body:  jsonEncode(body),headers: headers);
    final responseData = jsonDecode( response.body);
    if (response.statusCode == 200) {
      print(responseData.toString());
      return Right(response.statusCode==200);
    } else {
      print('Error>>>');
      print('Error>>>${response.body}');
      return Left(responseData['message']);
    }
  }

  @override
  void onClose() {
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }
}

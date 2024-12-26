
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignupController extends GetxController {
  TextEditingController nameCtlr = TextEditingController();
  TextEditingController emailCtlr = TextEditingController();
  TextEditingController handicapCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController passWordCtlr = TextEditingController();
  TextEditingController confirmPassCtlr = TextEditingController();



  RxBool isJobExperience=false.obs;
  RxString phoneNumber = ''.obs;
  RxString address = ''.obs;
  String? gender;
  bool isChecked = false;
  List genderList = ['Male', 'Female', 'Other'];

  RxList<String> categoriList=<String>[].obs;

  RxString selectedDate = 'Select Date Time'.obs;
  String responseMessage = '';
  File? selectedIMage;
  var imagePath = ''.obs;

  Future pickImageFromCamera(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) return;
    selectedIMage = File(returnImage.path);
    imagePath.value = selectedIMage!.path;
    //image =  File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath:${imagePath}');
    Get.back(); //
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));

    if (picked != null && picked != selectedDate) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:${selectedDate}');
      update();
    }
  }

  var registerLoading = false.obs;

  signUp() async {
    registerLoading(true);

    var headers = {'Content-Type': 'multipart/form-data'};
    String phoneNumbers= phoneNumber.value!=null || phoneNumber.value.isNotEmpty? phoneNumber.value.toString():'';

    Map<String, String> body = {
      'fullName': nameCtlr.text,
      'email': emailCtlr.text,
      'password': passWordCtlr.text,
      'role': 'user',
      if(phoneNumbers.isNotEmpty) 'phoneNumber': phoneNumbers,
      'dataOfBirth': selectedDate.value,
      'gender': gender!,
      'jobExperience': isJobExperience.value.toString(),
      'jobLessCategory': jsonEncode(categoriList),
      'address' : address.value
    };

   /* List<MultipartBody> multipartBody = [MultipartBody('image', File(imagePath.value))];
    var response = await ApiClient.postMultipartData(ApiConstants.registerUrl, body, multipartBody: multipartBody, headers: headers);

    if (response.statusCode == 201) {
      //Get.toNamed(AppRoutes.emailveryfaiScreen);
      registerLoading(false);
      update();
    } else {
      print('Error>>>');
      print('Error>>>${response.body}');
      registerLoading(false);
      update();
    }*/
  }
}

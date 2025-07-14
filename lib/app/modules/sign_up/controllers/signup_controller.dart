import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController handicapCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController passWordCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  LatLng? latLng;
  String? gender;
  bool isChecked = false;
  List genderList = ['Male', 'Female', 'Other'];

  RxList<String> categoryList = <String>[].obs;

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
    print('ImagesPath:$imagePath');
    Get.back(); //
  }

  var registerLoading = false.obs;

  signUp() async {
    registerLoading.value=true;
    final location = Get.arguments ?? {};
    latLng = location['latLng'] as LatLng;
    final locationName = location['locationName'] as String;
    print('Location Name: $locationName');
    final header = {'Content-Type': 'application/json'};

    Map<String, String> body = {
      "name": nameCtrl.text,
      "email": emailCtrl.text,
      "password": passWordCtrl.text,
      "role": "user",
       "country": locationName,
      "handicap": handicapCtrl.text,
      "latitude": (latLng?.latitude).toString(),
      "longitude": (latLng?.longitude).toString()
    };

    http.Request request = http.Request('POST', Uri.parse(ApiConstants.registerUrl));
    request.headers.addAll(header);
    request.body = jsonEncode(body);

    try {
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      Map<String, dynamic> data = jsonDecode(responseData.body);
      if (response.statusCode == 201) {
        print(data['code']);
        if(data['code']==201){
          Get.toNamed(Routes.OTP,arguments: {'email':emailCtrl.text});
        }

      } else {
        print('Error>>>' );
        print('Error>>>${response}');
        Get.snackbar('Failed', data['message']);
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    }catch(_){
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
    }finally{
      registerLoading.value=false;
    }
  }
}

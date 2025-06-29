import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddSmallOutingController extends GetxController {
  final TextEditingController outingNameCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController courseCtrl = TextEditingController();
  final TextEditingController fromRangeCtrl = TextEditingController();
  final TextEditingController toRangeCtrl = TextEditingController();
  final TextEditingController courseRatingCtrl = TextEditingController();
  final TextEditingController slopeRatingCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();

  late final TextEditingController searchCourseNameCtrl = TextEditingController();
  LatLng? latLng;

  List<String> outingTypeList = [
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

  List numberOfPlayerList = ['2', '3', '4', '5', '6', '7', '8'];

  RxBool isLoading = false.obs;

  String? outingType;
  String? numberOfPlayer;
  File? selectedFile;
  RxString filePath = ''.obs;

  RxString selectedDate = 'Select Date'.obs;

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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:$selectedDate');
    }
  }

  pickImageFromGallery(ImageSource imageSource) async {
    final returnImage = await ImagePicker().pickImage(source: imageSource);
    if (returnImage == null) return;
    selectedFile = File(returnImage.path);
    filePath.value = selectedFile!.path;
    print('ImagesPath:$filePath');
    if (filePath.value.isNotEmpty) {
      Get.snackbar('File selected', '');
    }
  }

  /// Network Call Function
  createSmallTournament({Function(String?)? callBack}) async {
    isLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data'
      };

      Map<String, String> body = {
        "tournamentName": outingNameCtrl.text,
        "tournamentType": outingType ?? '',
        "date": selectedDate.value,
        "city": cityCtrl.text,
        "courseName": searchCourseNameCtrl.text,
        "longitude": latLng?.longitude.toString() ?? '',
        "latitude": latLng?.latitude.toString() ?? '',
        "courseRating": courseRatingCtrl.text,
        "slopeRating": slopeRatingCtrl.text,
        "numberOfPlayers": numberOfPlayer ?? '',
        "handicapToRange": toRangeCtrl.text,
        "handicapFromRange": fromRangeCtrl.text,
        "time": timeCtrl.text
      };

      // Create a MultipartRequest for the profile update
      var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.createSmallTournamentUrl));

      request.headers.addAll(headers);
      // Check if an image is selected for upload
      if (selectedFile != null && selectedFile!.path.isNotEmpty) {
        await addFileToRequest(request, selectedFile!, 'tournamentImage');
      }
      request.fields.assignAll(body);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Profile updated successfully: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);
      if (response.statusCode == 201) {
        callBack!(decodedBody['message'].toString());
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

  // Helper method to add file based on its type
  Future<void> addFileToRequest(
      http.MultipartRequest request, File file, String fileKey) async {
    String fileName = file.path.split('/').last;
    String fileType = fileName.split('.').last.toLowerCase();

    if (fileType == 'png') {
      request.files.add(
        http.MultipartFile.fromBytes(
          fileKey,
          await file.readAsBytes(),
          filename: fileName,
          contentType: MediaType('image', 'png'),
        ),
      );
      debugPrint("Media type png ==== $fileName");
    }

    if (fileType == 'jpg' || fileType == 'jpeg') {
      request.files.add(
        http.MultipartFile.fromBytes(
          fileKey,
          await file.readAsBytes(),
          filename: fileName,
          contentType: MediaType('image', fileType),
        ),
      );
      debugPrint("Media type $fileType ==== $fileName");
    } else {
      debugPrint("Unsupported media type: $fileName");
      throw Exception('Unsupported file type');
    }
  }
}

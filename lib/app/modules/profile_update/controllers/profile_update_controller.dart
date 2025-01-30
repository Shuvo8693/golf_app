import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/model/user_model.dart';
import 'package:golf_game_play/app/modules/my_profile/controllers/my_profile_controller.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class ProfileUpdateController extends GetxController {
  User? user;

  ProfileUpdateController({this.user});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController clubNameCtrl = TextEditingController();
  final TextEditingController clubHandicapCtrl = TextEditingController();
  final TextEditingController handicapCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController faceBookLinkCtrl = TextEditingController();
  final TextEditingController instagramLinkCtrl = TextEditingController();
  final TextEditingController linkedinCtrl = TextEditingController();
  final TextEditingController xLinkCtrl = TextEditingController();

  // Fetch and populate the profile details
  getProfile() {
    nameCtrl.text = user?.name ?? '';
    clubNameCtrl.text = user?.clubName ?? '';
    clubHandicapCtrl.text = user?.clubHandicap ?? '';
    handicapCtrl.text = user?.handicap ?? '';
    stateCtrl.text = user?.state ?? '';
    cityCtrl.text = user?.city ?? '';
    countryCtrl.text = user?.country ?? '';
    faceBookLinkCtrl.text = user?.facebookLink ?? '';
    instagramLinkCtrl.text = user?.instagramLink ?? '';
    linkedinCtrl.text = user?.linkdinLink ?? '';
    xLinkCtrl.text = user?.xLink ?? '';
  }

  RxString address = ''.obs;
  String? gender;
  bool isChecked = false;
  List<String> genderList = ['Male', 'Female', 'Other'];
  RxString selectedDate = 'Select Date Time'.obs;
  String responseMessage = '';
  File? selectedProfileImage;
  File? selectedCoverImage;
  var profileImagePath = ''.obs;
  var coverImagePath = ''.obs;

  // Image picker method for camera
  ///For Profile Pic
  Future<void> pickImageFromCameraForProfilePic(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) return;

    selectedProfileImage = File(returnImage.path);
    profileImagePath.value = selectedProfileImage!.path;

    update(); // Updates the UI
    print('ImagePath: ${profileImagePath.value}');
    Get.back(); // Dismiss the image picker dialog
  }

  /// For Cover Pic
  Future<void> pickImageFromCameraForCoverPic(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) return;

    selectedCoverImage = File(returnImage.path);
    coverImagePath.value = selectedCoverImage!.path;

    update(); // Updates the UI
    print('ImagePath: ${coverImagePath.value}');
    Get.back(); // Dismiss the image picker dialog
  }

  var registerLoading = false.obs;

  Future<void> updateProfile({Function(String?)? callBack}) async {
    registerLoading.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data'
      };

      Map<String, String> body = {
        if (nameCtrl.text.isNotEmpty) "name": nameCtrl.text,
        if (cityCtrl.text.isNotEmpty) "city": cityCtrl.text,
        if (stateCtrl.text.isNotEmpty) "state": stateCtrl.text,
        if (gender != null && gender!.isNotEmpty) "gender": gender!,
        if (countryCtrl.text.isNotEmpty) "country": countryCtrl.text,
        if (handicapCtrl.text.isNotEmpty) "handicap": handicapCtrl.text,
        if (clubHandicapCtrl.text.isNotEmpty)
          "clubHandicap": clubHandicapCtrl.text,
        if (clubNameCtrl.text.isNotEmpty) "clubName": clubNameCtrl.text,
        if (faceBookLinkCtrl.text.isNotEmpty)
          "facebookLink": faceBookLinkCtrl.text,
        if (instagramLinkCtrl.text.isNotEmpty)
          "instagramLink": instagramLinkCtrl.text,
        if (linkedinCtrl.text.isNotEmpty) "linkdinLink": linkedinCtrl.text,
        if (xLinkCtrl.text.isNotEmpty) "xLink": xLinkCtrl.text,
        // if (profileImagePath.value.isNotEmpty) "image": profileImagePath.value,
        // if (coverImagePath.value.isNotEmpty) "coverImage": coverImagePath.value,
      };

      // Create a MultipartRequest for the profile update
      var request = http.MultipartRequest(
          'PATCH', Uri.parse(ApiConstants.updateProfileUrl(userId)));

      request.headers.addAll(headers);
      request.fields.addAll(body);

      // Check if an image is selected for upload
      if (selectedProfileImage != null) {
        buildImageForUpload(selectedProfileImage, request, fileKey: 'image',);
      }
      if (selectedCoverImage != null) {
        buildImageForUpload(selectedCoverImage, request, fileKey: 'coverImage');
      }

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Profile updated successfully: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
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
      registerLoading.value = false;
    }
  }

  buildImageForUpload(File? selectedImage, http.MultipartRequest request,
      {required String fileKey}) {
    if (selectedImage != null) {
      final mimeType = lookupMimeType(selectedImage.path) ?? 'image/jpeg';
      final mimeTypeData = mimeType.split('/');

      request.files.add(
        http.MultipartFile(
          fileKey, // This should match your API's expected file key
          selectedImage.readAsBytes().asStream(),
          selectedImage.lengthSync(),
          filename: selectedImage.path.split('/').last,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
    }
  }
}

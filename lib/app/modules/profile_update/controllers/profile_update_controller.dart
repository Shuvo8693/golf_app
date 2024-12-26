import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class ProfileUpdateController extends GetxController {
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
  /* Future<void> getProfileId() async {
    String? authorId = await PrefsHelper.getString('authorId');
    await profileController.fetchProfile(authorId);

    // Populate controllers after fetching profile
    fullNameController.text = profileController.profile.value.fullName ?? '';
    emailController.text = profileController.profile.value.email ?? '';
    phoneNumberController.text = profileController.profile.value.phoneNumber ?? '';
    genderController.text = profileController.profile.value.gender ?? '';
    dateOfBirthController.text = profileController.profile.value.dataOfBirth ?? '';
  }*/

  RxString phoneNumber = ''.obs;
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
    coverImagePath.value = selectedProfileImage!.path;

    update(); // Updates the UI
    print('ImagePath: ${coverImagePath.value}');
    Get.back(); // Dismiss the image picker dialog
  }

  var registerLoading = false.obs;

  Future<void> updateProfile() async {
    try {
      registerLoading.value = true;
      String token = await PrefsHelper.getString('token');
      String authorId = await PrefsHelper.getString('authorId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data'
      };

      Map<String, String> body = {
        'role': 'user',
        'phoneNumber': phoneNumber.value,
        'dataOfBirth': selectedDate.value,
        'gender': gender ?? '',
      };

      // Create a MultipartRequest for the profile update
      var request = http.MultipartRequest('PATCH', Uri.parse(ApiConstants.updateProfileUrl(authorId)));

      request.headers.addAll(headers);
      request.fields.addAll(body);

      // Check if an image is selected for upload
      buildImageForUpload(selectedProfileImage, request);
      buildImageForUpload(selectedCoverImage, request);

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        print('Profile updated successfully: ${responseBody.body}');
        var decodedBody = jsonDecode(responseBody.body);
        Get.showSnackbar(GetSnackBar(
          message: decodedBody['message'].toString(),
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
          maxWidth: 330.w,
          borderRadius: 15,
        ));
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in updating profile: $e');
      registerLoading(false);
    } finally {
      registerLoading.value = false;
    }
  }

  buildImageForUpload(File? selectedImage,http.MultipartRequest request){
    if (selectedImage != null) {
      final mimeType = lookupMimeType(selectedImage.path) ?? 'image/jpeg';
      final mimeTypeData = mimeType.split('/');

      request.files.add(http.MultipartFile(
        'image', // This should match your API's expected file key
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: selectedImage.path.split('/').last,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ),
      );
    }
  }
}

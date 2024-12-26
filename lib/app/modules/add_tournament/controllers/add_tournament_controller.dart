import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddTournamentController extends GetxController {
  final TextEditingController tournamentCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController courseCtrl = TextEditingController();
  final TextEditingController courseRatingCtrl = TextEditingController();
  final TextEditingController slopeRatingCtrl = TextEditingController();
  List tournamentTypeList = ['Type1', 'Type2', 'Type3'];
  List groupNumberList = ['2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'];
  List groupLengthList = ['2', '3', '4', '8'];
  String? tournament;
  String? groupNumber;
  String? groupLength;
  File? selectedFile;
  var filePath = ''.obs;

  RxString selectedDate = 'Select Date Time'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));

    if (picked != null && picked != selectedDate) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:$selectedDate');
      update();
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

  // Helper method to add file based on its type
  _addFileToRequest(http.MultipartRequest request, File file) async {
    String fileName = file.path.split('/').last;
    String fileType = fileName.split('.').last.toLowerCase();

    if (fileType == 'png') {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          await file.readAsBytes(),
          filename: fileName,
          contentType: MediaType('image', 'png'),
        ),
      );
      debugPrint("Media type png ==== $fileName");
    } else if (fileType == 'jpg' || fileType == 'jpeg') {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        await file.readAsBytes(),
        filename: fileName,
        contentType: MediaType('image', fileType),
      ));
      debugPrint("Media type $fileType ==== $fileName");
    } else {
      debugPrint("Unsupported media type: $fileName");
      throw Exception('Unsupported file type');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

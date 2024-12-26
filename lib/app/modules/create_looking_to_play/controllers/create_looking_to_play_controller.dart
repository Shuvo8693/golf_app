import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateLookingToPlayController extends GetxController {

  final TextEditingController userNameCtrl=TextEditingController();
  final TextEditingController visitingFromCtrl=TextEditingController();
  final TextEditingController golfCourseCtrl=TextEditingController();
  List categoryList = ['category1', 'category2', 'category3'];

  String? category;

  RxString selectedFromDate = 'Select Date Time'.obs;
  RxString selectedToDate = 'Select Date Time'.obs;


  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050));

    if (picked != null && picked != selectedFromDate) {
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

    if (picked != null && picked != selectedToDate) {
      selectedToDate.value = DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:$selectedToDate');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }


}

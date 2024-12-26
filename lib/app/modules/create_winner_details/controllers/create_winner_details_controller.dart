import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateWinnerDetailsController extends GetxController {
  List<String> categoryList = ['category1', 'category2', 'category3'];
  List<String> amountIsPaid = ['Yes','No'];

  TextEditingController winnerRoundCtrl =Get.put(TextEditingController());
  TextEditingController looserRoundCtrl =Get.put(TextEditingController());

  String? skinWinnerName;
  String? skinHole;
  String? skinScore;
  String? skinAmountIsPaid;

  String? kpWinnerName;
  String? kpHole;
  String? kpFeet;

  String? winnerName;
  String? loserName;

  String? allPlayerName;
  String? allTeeBox;
  String? allPlayerScore;


}

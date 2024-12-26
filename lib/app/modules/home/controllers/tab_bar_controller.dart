import 'package:get/get.dart';

class TabBarController extends GetxController {

  final RxList<String> tapBarList=<String>[
    'Tournament',
    'Small Outing',
    'Looking to play',
  ].obs;

  RxInt currentIndex=0.obs;

  @override
  void onInit() {
    super.onInit();
  }



  @override
  void onClose() {
    super.onClose();
  }
}

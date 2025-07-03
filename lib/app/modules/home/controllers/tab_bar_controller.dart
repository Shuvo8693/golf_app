import 'package:get/get.dart';

class TabBarController extends GetxController {

  final RxList<String> tapBarList=<String>[
    'Club Outings     ',
    'Pick up Round',
    'Looking to golf',
  ].obs;

  RxInt currentIndex=0.obs;

}

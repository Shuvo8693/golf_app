import 'package:get/get.dart';

class TabBarController extends GetxController {

  final RxList<String> tapBarList=<String>[
    'Club Outings     ',
    'Pick up Round',
    '  Golfers   ',
  ].obs;

  RxInt currentIndex=0.obs;

}

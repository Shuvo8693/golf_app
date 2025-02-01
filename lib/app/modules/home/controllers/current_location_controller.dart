import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CurrentLocationController extends GetxController{
  String _locationMessage = "";
  RxDouble? latitude=0.0.obs;
  RxDouble? longitude=0.0.obs;

  getCurrentLocation()async{
    ///Check for service enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      Get.snackbar('Location Is Disabled', '');
    }

     LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      LocationPermission requestPermission = await Geolocator.requestPermission();
      if(requestPermission==LocationPermission.denied){
        Get.snackbar('Location permissions are denied','');
      }

      if(requestPermission==LocationPermission.deniedForever){
        Get.snackbar('Location permissions are permanently denied'," we cannot request permissions.");
      }

    }

    Position position = await Geolocator.getCurrentPosition();
    print('Current latitude ${position.latitude}');
    print('Current longitude ${position.longitude}');
    latitude?.value = position.latitude;
    longitude?.value = position.longitude;
  print('Take latitude ${latitude?.value}');
  print('Take longitude ${longitude?.value}');

  }

}
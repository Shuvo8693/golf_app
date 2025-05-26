import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CurrentLocationController extends GetxController{
  RxDouble? latitude=0.0.obs;
  RxDouble? longitude=0.0.obs;
  Rx<Placemark?> placeMark =Rx<Placemark?>(null);

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
   /// Get current location
    Position position = await Geolocator.getCurrentPosition();
    print('Current latitude ${position.latitude}');
    print('Current longitude ${position.longitude}');
    latitude?.value = position.latitude;
    longitude?.value = position.longitude;
  Placemark place = await getAddressFromLatLng(position.latitude,position.longitude);
  placeMark.value = place;
  print('PlaceMark ${placeMark.value}');


  }

 Future<Placemark> getAddressFromLatLng(double latitude, double longitude) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks[0];
      return place;
    }else{
      return Placemark();
    }
  }
}
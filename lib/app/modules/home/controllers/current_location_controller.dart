import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationController extends GetxController{
  RxDouble? latitude=0.0.obs;
  RxDouble? longitude=0.0.obs;
  Rx<Placemark?> placeMark =Rx<Placemark?>(null);
  RxBool isLoading= false.obs;

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
   try{
     isLoading.value =true;
     Position position = await Geolocator.getCurrentPosition();
     latitude?.value = position.latitude;
     longitude?.value = position.longitude;
     Placemark place = await getAddressFromLatLng(position.latitude,position.longitude);
     placeMark.value = place;
     print('PlaceMark ${placeMark.value}');
    }catch(e){
      print('Current location facing failed : $e');
   }finally{
     isLoading.value = false;
   }

  }

 Future<Placemark> getAddressFromLatLng(double latitude, double longitude) async {
    //List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
    List<Placemark> placeMarks = await GoogleApiService.placeMarkFromCoordinate(LatLng(latitude, longitude));
    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks[0];
      return place;
    }else{
      return Placemark();
    }
  }
}
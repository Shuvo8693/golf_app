import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/app/routes/app_pages.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationSelectorView extends StatefulWidget {
  const LocationSelectorView({super.key});

  @override
  _LocationSelectorViewState createState() => _LocationSelectorViewState();
}

class _LocationSelectorViewState extends State<LocationSelectorView> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(19.432608, -99.133209); // Default to Mexico City
  LatLng? _pickedLocation;
  late final TextEditingController _searchController = TextEditingController();
  List<String> onChangeTextFieldValue = [];

@override
  void initState() {

    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _goToSearchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location? location = locations.first;
        _moveCamera(LatLng(location.latitude, location.longitude));
      }
    } catch (e) {
      print('Error occurred while searching: $e');
    }
  }

  void _moveCamera(LatLng target) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 15),
      ),
    );
    _pickedLocation = target;

  }
 /// Api Call method
  void _confirmLocation(String selectedLocation) {
      // You can make an API call here to save the selected location or perform other actions
      final args = Get.arguments ?? {};
      print(selectedLocation);
      if(args['from']=='login'){
        Get.toNamed(Routes.SIGN_UP, arguments: {'latLng': _pickedLocation});
      }else{
        Get.offAndToNamed(Routes.HOME);
      }
      print("Location confirmed: $_pickedLocation");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Google Map view
          Positioned.fill(
            child: SafeArea(
              child: GoogleMap(
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                onTap: (position) {
                  _moveCamera(position);
                },
                myLocationEnabled: true,
              ),
            ),
          ),

          /// Back button
          Positioned(
            top: 55.h,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),

          /// Search bar at the top
          Positioned(
            top: 40.h,
            // Adjust this to position the search bar slightly below the status bar
            left: 25.w,
            right: 15.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (inputValue) async {
                        if (inputValue.isNotEmpty == true) {
                          var result = await GoogleApiService.fetchSuggestions(inputValue);
                          print(result.toString());
                          setState(() {
                            _pickedLocation=null;
                            onChangeTextFieldValue = result;
                          });
                          print(onChangeTextFieldValue.toString());
                        }
                      },
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search location",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  /// Search Icon
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      // Handle search button press logic
                      _goToSearchLocation(_searchController.text);
                      setState(() {
                        onChangeTextFieldValue=[];
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          /// Location Suggesion List
          Positioned(
            top: 105.h,
            left: 25.w,
            right: 15.w,
            child: onChangeTextFieldValue.isNotEmpty == true
                ? Container(
                    height: 200.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 3,
                            color: AppColors.gray.withOpacity(0.7),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.sp),
                            bottomRight: Radius.circular(12.sp))),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: onChangeTextFieldValue.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: InkWell(
                            onTap: () {
                              String selectedLocation = onChangeTextFieldValue[index].toString();
                              print(selectedLocation);
                              if (selectedLocation.isNotEmpty == true) {
                                _searchController.text = selectedLocation;
                                print(_searchController.text);
                              }
                              _goToSearchLocation(_searchController.text);
                              setState(() {
                                onChangeTextFieldValue=[];
                              });
                            },
                            child: Text(onChangeTextFieldValue[index].toString(),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          /// Confirm button at the bottom
          Positioned(
            bottom: 30.h,
            left: 15.w,
            right: 15.w,
            child: CustomButton(
              onTap: () {
                if(_pickedLocation !=null){
                  _confirmLocation(_searchController.text);
                }else {
                  print("No location selected!");
                  Get.snackbar('No location selected!', 'Please select your location ');
                }
              },
              text: 'Confirm Location',
              height: 54.h,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

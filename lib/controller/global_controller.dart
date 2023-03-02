import 'package:alada_weather_app/models/weather_model.dart';
import 'package:alada_weather_app/services/api_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  // variables that are needed for the controller

  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxList _placemark = [].obs;
  final _currentWeather = CurrentWeather().obs;
  //methods that are needed for the getting those variables data

  RxBool checkLoadingStatus() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;
  RxList getPlaceDetails() => _placemark;
  Rx<CurrentWeather> getCurrentWeather() => _currentWeather;
//location getting methods
  getLoaction() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location Services Not Enabled!");
    }

    //permission status
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location Permission is denied forver!');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        Future.error('Location Permission is denied');
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((value) async {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _currentWeather.value =
          (await ApiHandler().getWeather(_latitude.value, _longitude.value));
      print(_currentWeather.value.coord!.lat);
      _placemark.value =
          await placemarkFromCoordinates(_latitude.value, _longitude.value);
      _isLoading.value = false;
      // print(_placemark);
      // print('lat $_latitude \n lon $_longitude');
    });
  }
}

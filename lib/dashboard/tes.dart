import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

double lat = 0;
double lon = 0;
Homec homeController = Homec(); // Create an instance of Homec
// Register Homec as a lazy singleton

class Homec extends GetxController {
  var latitude = 'Getting latitude..'.obs;
  var longitude = 'Getting longitude..'.obs;
  var locality = 'Getting address..'.obs;
  var address = 'Select Location'.obs;

  late StreamSubscription<Position> streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    getLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Services are Disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Services are Disabled');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('kjdnvkbnfdkjbvkjfsbdkjb ');
    }
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude.value = 'Latitude : ${position.latitude}';
      longitude.value = 'Logitude : ${position.longitude}';
      lat = position.latitude;
      lon = position.longitude;
      getAddressFromLatLang(position);
    });
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    locality.value = '${place.locality}';
    address.value = '${place.country}';
  }
}

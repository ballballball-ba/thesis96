import 'dart:async';

import 'package:location/location.dart';
import 'package:mythesis96/m/userlocation.dart';

class Locationservices {
  UserLocation _currentLocation;
  Location location = Location();

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Locationservices() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longtitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longtitude: userLocation.longitude,
      );
    } catch (e) {
      print('ไม่สามารถเข้าถึงตำแหน่ง: $e');
    }
    return _currentLocation;
  }
}

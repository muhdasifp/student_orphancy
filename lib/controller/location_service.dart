import 'package:care_life/utility/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  final _collection = FirebaseFirestore.instance.collection('users');
  final _user = FirebaseAuth.instance.currentUser;

  ///to get location permission alert
  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      /// if allow permission
      getCurrentLocation();
    } else if (status.isDenied) {
      sendToastMessage(message: 'Location Permission denied');
    }
    return Future.error('Access the permissions are denied');
  }

  /// to check if user enable gps and get current latitude and longitude
  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      ///if permission denied ask on more time
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position myLocation = await Geolocator.getCurrentPosition();
    getCurrentAddress(myLocation.latitude, myLocation.longitude);
  }

  /// by using latitude and longitude get current address
  Future<void> getCurrentAddress(double lat, double long) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
    String address =
        "${placeMarks[0].name},${placeMarks[0].street},${placeMarks[0].locality},${placeMarks[0].postalCode}";
    updateProfile(lat.toString(), long.toString(), address);
  }

  /// after getting address and lat and long update user profile in firebase
  Future<void> updateProfile(String lat, String long, String address) async {
    try {
      await _collection.doc(_user!.uid).update({
        "lat": lat,
        "long": long,
        "address": address,
      });
      sendToastMessage(message: 'location updated', color: Colors.green);
    } catch (e) {
      sendToastMessage(message: e.toString());
      throw e.toString();
    }
  }
}

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class Aaa extends StatefulWidget {
  const Aaa({Key? key,}) : super(key: key);


  @override
  State<Aaa> createState() => _AaaState();
}

class _AaaState extends State<Aaa> {

  Position? currentPosition;
  StreamSubscription<Position>? positionStream;

  var _latitude = "";
  var _longitud = "";
  var _altitude = "";
  var _speed = "";
  var _address = "";

  fetchWeather() async {

    // url = await http.get('https://api.openweathermap.org/data/2.5/weather?lat={}&lon={}&appid={3f517816334c2cd3afceba0ab1a23278}');
  }



















































  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _latitude = pos.latitude.toString();
      _longitud = pos.longitude.toString();
      _altitude = pos.altitude.toString();
      _address = pm[0].toString();
      _speed = pos.speed.toString();
    });
  }




  void listenToLocationChanges()  async {


    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) {
        print(position==null? 'Unknown' : '$position');
        setState(() {
          currentPosition = position;
        });
      },
    );
  }



  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('www'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(''
            //     'your last known location is :'),
            // Text('latitude' + _latitude),
            // Text('atitude' + _altitude),
            // Text('longtitude' + _longitud),
            // Text('speed' + _speed),
            // Text('addreess' + _address),
          Text(currentPosition!=null? '$currentPosition' : '----',)
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _updatePosition,
      //   tooltip: 'get gps location',
      //   child: const Icon(Icons.change_circle_outlined),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    /// don't forget to cancel stream once no longer needed
    positionStream?.cancel();
  }

  @override
  void initState() {
    super.initState();
    listenToLocationChanges();
  }
}
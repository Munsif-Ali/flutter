
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../api/weather_api.dart';
import '../model/weather_model.dart';

class Location1 extends StatefulWidget {

  static var latitude;
  static var longitude;

   StreamSubscription<Position>? positionStream;
   List<WeatherModel>? weather;
   var isLoaded = false;

   // late double? www = currentPosition?.latitude.toString() as double;
   // late double? wwwq = currentPosition?.longitude.toString() as double?;

   Location1({Key? key, this.weather, this.positionStream}) : super(key: key);


  @override
  State<Location1> createState() => _Location1State();


}
 class _Location1State extends State<Location1> {
   Position? currentPosition;
   var a;

// var a = Location.latitude;

  /// Determine the current position of the device
  void _determinePosition() async {


    // Test if lices are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print('Location permissions are permanently denied, we cannot request permissions.');

      /// open app settings so that user changes permissions
      // await Geolocator.openAppSettings();
      // await Geolocator.openLocationSettings();

      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    // print("Current Position $position");
    setState(() {
      currentPosition = position;
      // print('kir : $currentPosition');
    });
  }

  void getLastKnownPosition() async {
    Position? position = await Geolocator.getLastKnownPosition();
  }

  void listenToLocationChanges() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    widget.positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) {
        // print(position==null? 'Unknown' : '$position');
        setState(() {
          currentPosition = position;
          Location1.longitude = currentPosition?.longitude;
          Location1.latitude = currentPosition?.latitude;

          print(Location1.longitude);
          print(Location1.latitude);

        });

      },
    );
  }


  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   /// don't forget to cancel stream once no longer needed
  //   widget.positionStream?.cancel();
  // }
  //
  @override
  void initState() {
    super.initState();
    getData();


  }


  getData() async {
    widget.weather = await WeatherApi.getWeather();
    if(widget.weather !=null) {
      setState(() {
        widget.isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geolocator"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: _determinePosition, child: Text('Determine Position')),
            SizedBox(height: 20.0,),
            Text(currentPosition!=null? '$widget.currentPosition' : '----',),
          ],
        ),
      ),
    );
  }
}
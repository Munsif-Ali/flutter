import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class Ccc extends StatefulWidget {
  const Ccc({Key? key}) : super(key: key);

  @override
  State<Ccc> createState() => _CccState();
}

class _CccState extends State<Ccc> {

  static  late  final latitude;
  static  late  final longitude;

  Position? currentPosition;
  StreamSubscription<Position>? positionStream;
  List<WeatherModel>? weather;
  var isLoaded = false;

    void listenToLocationChanges() {
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(
                (Position? position) {
              // print(position==null? 'Unknown' : '$position');
              setState(() {
                currentPosition = position;
                longitude = currentPosition?.longitude;
                latitude = currentPosition?.latitude;
                print(latitude);
                print(longitude);
              });
            },
          );
    }




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

@override
void initState() {
  super.initState();
  getData();
}



getData() async {
  weather = await getWeather();
  if(weather !=null) {
    setState(() {
      isLoaded = true;
    });
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) {
        // print(position==null? 'Unknown' : '$position');
        setState(() {
          currentPosition = position;

longitude = currentPosition?.longitude;
latitude = currentPosition?.latitude;

          print(latitude);
          print(longitude);
        });

      },
    );

  }


}
  static Future<List<WeatherModel>?> getWeather() async {
    // final latitude = Location.latitude;
    // final longitude = Location.longitude;
    //
    // print(latitude);
    // print(longitude);
    //
    // print(Location().latitude);
    // print(Location().longitude);
var lat = latitude;
var long = longitude;
    var client = http.Client();
    var key = 'ca0b4f21819f534216c0e18e1afb4eef';
    var uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?&lat=${lat}&lon=${long}&units=metric&appid=${key}');
    var response = await client.get(uri);

    print(response.body);
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

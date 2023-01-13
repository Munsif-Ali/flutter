//
// import 'package:firstflutter/api/weather_api.dart';
// import 'package:firstflutter/classes/location.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../model/weather_model.dart';
//
// class Weather extends StatefulWidget {
//   const Weather({Key? key}) : super(key: key);
//
//   @override
//   State<Weather> createState() => _WeatherState();
// }
//
// class _WeatherState extends State<Weather> {
//   List<WeatherModel>? weather;
//   var isLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     weather = await WeatherApi.getWeather();
//     if(weather !=null) {
//       setState(() {
//         isLoaded = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('weather'),
//       ),
//       body: Visibility(
//         visible: isLoaded,
//         child: ListView.builder(
//           itemCount: weather?.length,
//             itemBuilder: (context , index) {
//               return Container(
//                 child: Text(weather![index].name!),
//                 // Text(weather![index].name !=null? weather![index].name!' : '----',),
//               );
//         }),
//         replacement: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:firstflutter/classes/location.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import '../model/weather_model.dart';

class WeatherApi {
  static Future<List<WeatherModel>?> getWeather() async {

    var latitude = Location1.latitude;
    var longitude = Location1.longitude;

    print(latitude);
    print(longitude);

    var client = http.Client();
    var key = 'ca0b4f21819f534216c0e18e1afb4eef';
    var uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?&lat=${latitude}&lon=${longitude}&units=metric&appid=${key}');
    var response = await client.get(uri);

    print(response.body);
  }
}

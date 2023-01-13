import 'package:firstflutter/api/ccc.dart';
import 'package:firstflutter/classes/location.dart';
import 'package:firstflutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'classes/weather.dart';
import 'plugins/input_page.dart';
import 'package:provider/provider.dart';
import 'classes/image_class.dart';
import 'package:firstflutter/pages/details_page.dart';
import 'package:image_painter/image_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=> ImageFile(),
      child: MaterialApp(
        title: 'Flutter',
        // theme: ThemeData.dark(),
        home: Location1(),
        routes: {
          InputPage.routeName:(ctx)=> const InputPage(),
          DetailsPage.routeName:(ctx)=> const DetailsPage()
        },
      ),
    );
  }
}



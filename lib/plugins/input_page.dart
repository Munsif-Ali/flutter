import 'package:firstflutter/plugins/image_input.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:firstflutter/classes/image_class.dart';

import '../api/weather_api.dart';
import '../model/weather_model.dart';

class InputPage extends StatefulWidget {
  static const routeName = 'InputPage';

  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  File? savedImage;

  void savedImages(File image) {
    savedImage = image;
  }


  void onSave() {
    if (savedImage == null) {
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(savedImage!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('input page'),
        actions: [
          IconButton(onPressed: onSave, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ImageInput(savedImages),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function imageSaveAt;
  const ImageInput(this.imageSaveAt, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxHeight: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = await _imageFile?.copy('${apDir.path}/$fileName');

    widget.imageSaveAt(saveImagePath);
  }

  Future<void> _galleryPicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.gallery, maxHeight: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = await _imageFile?.copy('${apDir.path}/$fileName');

    widget.imageSaveAt(saveImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 5, color: Colors.indigo),
              borderRadius: BorderRadius.circular(20),
            ),
            child: _imageFile != null
                ? Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Text(
                      'no image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextButton.icon(
                    onPressed: _galleryPicture,
                    icon: const Icon(Icons.image),
                    label: const Text('add pic'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera),
                  label: const Text('open cam'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black87,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:firstflutter/database/database.dart';
import 'package:flutter/cupertino.dart';

class Image {
  final String id;
  final File image;

  Image({
    required this.image,
    required this.id,
  });
}

class ImageFile with ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [..._items];
  }

  Future<void> addImagePlace(File image) async {
    final newImage = Image(
      image: image,
      id: DateTime.now().toString(),
    );
    _items.add(newImage);
    notifyListeners();
    DataHelper.insert('user_image', {
      'id': newImage.id,
      'image': newImage.image.path,
    });
  }

  Image findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fetchImage() async {
    final list = await DataHelper.getData('user_image');
    _items = list
        .map(
          (item) => Image(
            image: File(item['image']),
            id: item['id'],
          ),
        )
        .toList();
    notifyListeners();
  }
}

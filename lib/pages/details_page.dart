import 'package:flutter/material.dart';
import 'package:firstflutter/classes/image_class.dart' as ima;
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = 'DetailsPage';

  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)?.settings.arguments as String;
    final image =
        Provider.of<ima.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('details'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 400,
            width: double.infinity,
            child: Image.file(
              image.image,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

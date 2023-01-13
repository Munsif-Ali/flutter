import 'package:flutter/material.dart';
import 'package:firstflutter/plugins/input_page.dart';
import 'package:provider/provider.dart';
import 'package:firstflutter/classes/image_class.dart' as ima;
import 'package:firstflutter/pages/details_page.dart';
// import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: () {
              Navigator.pushNamed(context, InputPage.routeName);
            },
            child: const Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('home page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: Provider.of<ima.ImageFile>(context, listen: false)
                  .fetchImage(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<ima.ImageFile>(
                      child:
                          const Center(child: Text('Start adding your story')),
                      builder: (ctx, image, ch) => image.items.isEmpty
                          ? ch!
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (ctx, i) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GridTile(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, DetailsPage.routeName,
                                            arguments: image.items[i].id);
                                      },
                                      child: Image.file(
                                        image.items[i].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: image.items.length,
                            ),
                    )),
        ));
  }
}

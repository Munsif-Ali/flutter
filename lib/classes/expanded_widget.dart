import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  const ExpandedWidget({super.key});

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  List list = [
    Colors.red,
    Colors.black,
    Colors.green,
    Colors.redAccent,
    Colors.orange,
  ];
  final CarouselController _carouselController = CarouselController();
  var _currentCarouselPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CarouselSlider.builder(
              itemCount: list.length,
              carouselController: _carouselController,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  height: 300,
                  color: list[index],
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                // viewportFraction: 1,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCarouselPage = index;
                  });
                },
                autoPlayInterval: const Duration(seconds: 3),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: list.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: _currentCarouselPage == entry.key ? 40 : 20,
                    height: 20,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: (Colors.black).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _currentCarouselPage == entry.key
                        ? Text(
                            "${_currentCarouselPage + 1}/${list.length}",
                            style: const TextStyle(fontSize: 10),
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

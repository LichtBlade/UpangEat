import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 3.0,
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                Color color = switch (i) {
                  1 => Colors.pinkAccent,
                  2 => Colors.blueAccent,
                  3 => Colors.lightGreenAccent,
                4 => Colors.deepOrangeAccent,
                5 => Colors.yellowAccent,
                  _ => Colors.white,
                };
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card.filled(
                      color: color,
                        child: Text(
                          'text $i',
                          style: const TextStyle(fontSize: 16.0),
                        )));
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3, 4, 5].asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.5 : 0.2)),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
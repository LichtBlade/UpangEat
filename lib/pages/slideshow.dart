import 'package:flutter/material.dart';

import 'home.dart';

class SlideshowScreen extends StatefulWidget {
  @override
  _SlideshowScreenState createState() => _SlideshowScreenState();
}

class _SlideshowScreenState extends State<SlideshowScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              buildPage('assets/mingming.png', 'Welcome to the App! \n\n step 1 \n sjdghoishgfoeiushgoieuh'),
              buildPage('assets/stalls/banners/BossSisigBanner.jpg', 'Discover New Features \n klwgsjuhreoiguhs'),
              buildPage('assets/stalls/banners/MasamsamitSoAdeleBanner.jpg', 'Let’s Get Started!'),
              buildPage('assets/stalls/banners/MekusMekusTayoInsanBanner.jpeg', 'avgrrrrrrr'),
              buildPage('assets/stalls/banners/NinongRySpecialDelicacyBanner.jpg', 'a\na\na\na\na'),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => buildDot(index)), //increase number of "dots"
            ),
          ),
          // "Next" or "Understood" button
          Positioned(
            bottom: 20,
            right: 20,
            child: _currentPage == 4
                ? ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: const Text("Understood"),
            )
                : ElevatedButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              child: Text("Next"),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build individual slides
  Widget buildPage(String imagePath, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 300),
        SizedBox(height: 30),
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Helper function to build dot indicator for each slide
  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: _currentPage == index ? 12 : 8,
      height: _currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Color(0xFFDE0F37) : Color.fromARGB(255, 224, 224, 224),
        shape: BoxShape.circle,
      ),
    );
  }
}

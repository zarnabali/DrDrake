import 'dart:async';
import 'package:flutter/material.dart';

class AutoSlidingCarousel extends StatefulWidget {
  final List<Widget> widgets;

  AutoSlidingCarousel({required this.widgets});

  @override
  _AutoSlidingCarouselState createState() => _AutoSlidingCarouselState();
}

class _AutoSlidingCarouselState extends State<AutoSlidingCarousel> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < widget.widgets.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 175, // Adjust the height as necessary
          child: PageView(
            controller: _pageController,
            children: widget.widgets,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.widgets.length, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: _currentIndex == index ? 12.0 : 8.0,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? const Color.fromARGB(255, 201, 33, 243)
                    : Colors.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
            );
          }),
        ),
      ],
    );
  }
}

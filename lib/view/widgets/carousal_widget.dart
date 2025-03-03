import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarousalWidget extends StatelessWidget {
  const CarousalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image.asset('assets/banner1.jpg',fit: BoxFit.cover,),
        Image.asset('assets/banner1.jpg',fit: BoxFit.cover,),
        Image.asset('assets/banner1.jpg',fit: BoxFit.cover,),
        Image.asset('assets/banner1.jpg',fit: BoxFit.cover,),
      
      ],
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1.0,
      ),
    );
  }
}

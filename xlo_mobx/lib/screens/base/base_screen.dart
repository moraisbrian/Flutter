import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          Container(color: Colors.yellow),
          Container(color: Colors.purple),
          Container(color: Colors.blue),
          Container(color: Colors.green),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Help extends StatelessWidget{
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text("WiMouse is a mobile application that allows you to control your computer with your phone. You can use it to control your computer from a distance, or to use your phone as a trackpad."),
      ),
    );
  }
}
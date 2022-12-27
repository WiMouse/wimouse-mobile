import 'package:flutter/material.dart';
import 'package:wimouse_mobile/ComputerListView.dart';

class Find extends StatelessWidget {
  const Find({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComputerListView(favoritesView: false);
  }
}
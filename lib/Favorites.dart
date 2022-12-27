import 'package:flutter/material.dart';
import 'package:wimouse_mobile/ComputerListView.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComputerListView(favoritesView: true);
  }
}
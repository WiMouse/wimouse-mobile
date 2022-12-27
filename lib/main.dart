import 'package:flutter/material.dart';
import 'package:wimouse_mobile/Help.dart';
import 'package:wimouse_mobile/Favorites.dart';
import 'package:wimouse_mobile/Find.dart';
import 'package:wimouse_mobile/Settings.dart';

import 'model/Computer.dart';

void main() {
  Computer.createDummyData();
  runApp(
    const MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.star),
                  text: 'Favorites',
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: 'Find Device',
                ),
                Tab(
                  icon: Icon(Icons.help_outline),
                  text: 'Help',
                ),
              ],
            ),
            title: const Text('WiMouse'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
              ),
            ],
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Favorites(),
              Find(),
              Help(),
            ],
          ),
        ),
      ),
    );
  }
}
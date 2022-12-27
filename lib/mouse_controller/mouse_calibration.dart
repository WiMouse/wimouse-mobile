

import 'package:flutter/material.dart';

class MouseCalibration extends StatefulWidget {
  const MouseCalibration({super.key});

  @override
  createState() => _MouseCalibrationState();
}

class _MouseCalibrationState extends State<MouseCalibration>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mouse Calibration'),
      ),
      body: const Center(
        child: Text('Mouse Calibration'),
      ),
    );
  }

}
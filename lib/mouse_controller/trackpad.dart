import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wimouse_mobile/model/Computer.dart';
import 'package:wimouse_mobile/mouse_controller/customTouchGestureRecognizer.dart';

class Trackpad extends StatelessWidget {
  final Computer computer;
  const Trackpad({super.key, required this.computer});

  @override
  Widget build(BuildContext context) {
    return TwoFingerPointerWidget(
      onUpdate: (DragUpdateDetails details) {
//        print(details);
      // TODO implement two finger scroll
        if(details.delta.dy>0) {
          computer.sendMouseEvent(4,details.delta.dy);
        } else if(details.delta.dy<0) {
          computer.sendMouseEvent(3,details.delta.dy);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.settings_overscan,
            size: 100,
            color: Color(0xFFE0E0E0),
          ),
          Text(
            'Trackpad',
            style: TextStyle(fontSize: 28, color: Color(0xFFE0E0E0)),
          ),
        ],
      ),
    );
  }
}
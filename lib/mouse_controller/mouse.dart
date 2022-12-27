import 'package:flutter/material.dart';
import 'package:wimouse_mobile/model/Computer.dart';

class Mouse extends StatelessWidget {
  final bool mouseLock;
  final Computer computer;
  Mouse({super.key, required this.mouseLock, required this.computer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:20.0,right:10,left:10),
          child: Row(
            children: [
              mouseButton("Left"),
              mouseButton("Middle"),
              mouseButton("Right"),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.mouse_outlined,
                  size: 100,
                  color: Color(0xFFE0E0E0),
                ),
                Text(
                  'Mouse',
                  style: TextStyle(fontSize: 28, color: Color(0xFFE0E0E0)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Offset _lastPosition = Offset.zero;
  Widget mouseButton(String button) {
    if(button=="Middle"){
      return Expanded(
        flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onVerticalDragStart: (DragStartDetails details) {
                _lastPosition = details.globalPosition;
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                if(mouseLock){
                  double dy = details.globalPosition.dy - _lastPosition.dy;
                  //print(dy);
                  if(dy>0) {
                    computer.sendMouseEvent(4,dy);
                  }else if(dy<0){
                    computer.sendMouseEvent(3,dy);
                  }
                  _lastPosition = details.globalPosition;
                }
              },
                onTap: () {
                  computer.sendMouseEvent(2,1);
                },
                child: Card(
                  color: const Color(0xFFE7E7E7),
                  elevation: 2,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E7E7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                          height: (mouseLock) ? 250 : 175,
                          child: Center(child: Text(button, style: const TextStyle(color: Color(0xFF9E9E9E),fontWeight: FontWeight.w500,)))
                      )
                  ),
                )
            ),
          ));
    }else {
      return Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  if(button=="Left") {
                    computer.sendMouseEvent(0,1);
                  }else{
                    computer.sendMouseEvent(1,1);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFE7E7E7)),
                  //foregroundColor: MaterialStateProperty.all<Color>(
                  //    const Color(0xFF9E9E9E)),
                  elevation: MaterialStateProperty.all<double>(2),
                ),
                child: SizedBox(
                    height: (mouseLock) ? 250 : 175,
                    child: Center(child: Text(button, style: const TextStyle(color: Color(0xFF9E9E9E),)))
                )
            ),
          ));
    }
  }
}
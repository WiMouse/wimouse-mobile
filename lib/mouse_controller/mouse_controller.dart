
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wimouse_mobile/model/Computer.dart';
import 'package:wimouse_mobile/mouse_controller/mouse_calibration.dart';
import 'package:wimouse_mobile/mouse_controller/trackpad.dart';
import 'package:wimouse_mobile/mouse_controller/mouse.dart';

class MouseController extends StatefulWidget {
  final Computer computer;
  const MouseController({super.key, required this.computer});

  @override
  createState() => _MouseControllerState();
}

class _MouseControllerState extends State<MouseController> {
  bool mouseLocked=false;
  bool disconnect=false;

  @override
  Widget build(BuildContext context) {
    if(mouseLocked){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,);
    }else{
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,);
    }
    return WillPopScope(
      onWillPop: onWillPopCallback,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: InkWell(
                enableFeedback: true,
                onLongPress: () {
                  setState(() {
                    mouseLocked=!mouseLocked;
                  });
                },
                child: FloatingActionButton.large(
                  elevation: 8,
                  backgroundColor: mouseLocked?Colors.red:Colors.greenAccent,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Make a long press to lock/unlock the mouse."),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: (mouseLocked)?const Icon(Icons.lock_outline,size: 35,):const Icon(Icons.lock_open_outlined,size: 35,),
                ),
              ),
            ),
            appBar: (!mouseLocked)? AppBar(
              leading: IconButton(
                onPressed: () async {
                  if(await onWillPopCallback()){
                    Navigator.pop(context);
                  }
                },
                tooltip: "Disconnect",
                icon: const Icon(Icons.phonelink_off_outlined, color: Colors.red,size: 30,),
              ),
              bottom: const TabBar(
                isScrollable: false,
                tabs: [
                  Tab(
                    icon: Icon(Icons.settings_overscan),
                    text: 'Trackpad',
                  ),
                  Tab(
                    icon: Icon(Icons.mouse_outlined),
                    text: 'Mouse',
                  ),
                ],
              ),
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Text(widget.computer.name,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MouseCalibration(),
                        ),
                      );
                    },
                    tooltip: 'Calibrate',
                    icon: const Icon(Icons.loop_rounded,size: 30,)),
              ],
            ):null,
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Trackpad(computer: widget.computer),
                Mouse(mouseLock: mouseLocked,computer: widget.computer,),
              ],
            ),
          ),
        ),
    );
  }

  Future<bool> onWillPopCallback() async {
    if (mouseLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unlock the mouse first to disconnect."),
          duration: Duration(seconds: 1),
        ),
      );
      return false;
    } else {
      return (await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to disconnect?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Disconnect', style: TextStyle(color: Colors.red),),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),

              ],
            ),
      )) ??
          false;
    }
  }
}
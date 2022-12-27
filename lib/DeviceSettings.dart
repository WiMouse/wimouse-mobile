
import 'package:flutter/material.dart';
import 'package:wimouse_mobile/mouse_controller/mouse_controller.dart';

import 'model/Computer.dart';

class DeviceSettings extends StatefulWidget {
  final Computer computer;

  const DeviceSettings({super.key, required this.computer});

  @override
  createState() => _DeviceSettingsState();
}

class _DeviceSettingsState extends State<DeviceSettings> {

  @override
  Widget build(BuildContext context) {
    Widget statIndicator = statusIndicator();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Settings"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            widget.computer.refresh();
            statIndicator = statusIndicator();
          });
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Icon(
                    Icons.computer_outlined,
                    size: 250,
                    color: Color(0xFF4FC3F7),
                  ),
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Device Name',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController.fromValue(TextEditingValue(text: widget.computer.name,selection: TextSelection.collapsed(offset: widget.computer.name.length))),
                          onChanged: (String value) {
                            if(value.isNotEmpty){
                              widget.computer.name = value;
                            }else{
                              widget.computer.name = "My PC";
                            }
                          },
                          onSubmitted: (String value) {
                            if(value.isNotEmpty){
                              widget.computer.name = value;
                            }
                          },
                          maxLength: 32,
                        ),
                      ),
                    ),
                    favoritesToggle(),
                  ],
                ),
                statIndicator,
                loadingButton(),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget favoritesToggle() {
    return SizedBox(
      width: 85,
      height: 85,
      child: Align(
        alignment: Alignment.topRight,
        child: RawMaterialButton(
          onPressed: () {
            setState(() {
              widget.computer.toggleFavorite();
            });
          },
          padding: const EdgeInsets.only(right:5.0),

          child: (widget.computer.isFavorite
              ? const Icon(Icons.star, size: 60, color: Color(0xFFFBC02D),)
              : const Icon(Icons.star_border, size: 60, color: Color(0xFFFBC02D)
          )),
        ),
      ),
    );
  }

  bool _isLoading = false;
  Widget loadingButton() {
    return Padding(
      padding: const EdgeInsets.only(top:30.0, left: 10.0, right: 10.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            Future.delayed(const Duration(seconds: 3), () {
              setState(() {
                _isLoading = false;
                if(widget.computer.connect()) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MouseController(computer: widget.computer),
//                      settings: RouteSettings(name: "MouseController", arguments: widget.computer)
                  ));
                }else {
                  var snackBar = const SnackBar(content: Text("Connection Failed."));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            });
          },
          style: ButtonStyle(
            backgroundColor: (_isLoading)? MaterialStateProperty.all(Colors.green) : MaterialStateProperty.all(Colors.lightBlue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: _isLoading
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Connecting...\t\t", style: TextStyle(fontSize: 20),),
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
              //SizedBox(width: 10),
            ],
          )
              : const Text("Connect", style: TextStyle(fontSize: 20),),),
      ),
    );
  }

  Widget statusIndicator(){
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Status: ", style: TextStyle(fontSize: 25),),
            Text(widget.computer.isOnline ? "Online" : "Offline", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600 ,color: widget.computer.isOnline ? Colors.green : Colors.red),),
          ],
        ),
      ),
    );
  }

}



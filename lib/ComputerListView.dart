import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wimouse_mobile/DeviceSettings.dart';

import 'model/Computer.dart';

class ComputerListView extends StatefulWidget {
  final bool favoritesView;
  const ComputerListView({super.key, required this.favoritesView});

  @override
  createState() => _ComputerListViewState();
}

class _ComputerListViewState extends State<ComputerListView> {
  Computer _selectedComputer = Computer.listOfComputers[0];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _refresh();
      },
      child: generateListView(),
    );
  }

  Widget generateListView() {
    if(widget.favoritesView) {
      if (Computer.isThereFavorites()) {
        List<Widget> listChildren = [],
            rowChildren = [];
        for (int i = 0; i < Computer.listOfComputers.length; i++) {
          if ((rowChildren.length <= 1) &&
              (Computer.listOfComputers[i].isFavorite)) {
            rowChildren.add(rowChild(widget.favoritesView,Computer.listOfComputers[i]));
            if (rowChildren.length == 2) {
              listChildren.add(Row(children: rowChildren));
              rowChildren = [];
            }
          }
        }
        if (rowChildren.length == 1) {
          listChildren.add(Row(children: rowChildren));
        }
        //print(listChildren.length);
        return ListView(
          children: listChildren,
        );
      } else {
        return ListView(
          children: const [
            Center(child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "No Favorites Found !", style: TextStyle(fontSize: 20,),),
            ),
            ),
          ],
        );
      }
    }else{
      if(Computer.isThereOnline()){
        List<Widget> listChildren = [], rowChildren = [];
        for (int i=0;i < Computer.listOfComputers.length;i++) {
          if((rowChildren.length<=1)&&(Computer.listOfComputers[i].isOnline)){
            rowChildren.add(rowChild(widget.favoritesView,Computer.listOfComputers[i]));
            if(rowChildren.length==2){
              listChildren.add(Row(children: rowChildren));
              rowChildren = [];
            }
          }
        }
        if(rowChildren.length==1){
          listChildren.add(Row(children: rowChildren));
        }
        return ListView(
          children: listChildren,
        );
      }else{
        return ListView(
          children: const [
            Center(child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "No Computers Found !", style: TextStyle(fontSize: 20,),),
            ),
            ),
          ],
        );
      }
    }
  }

  Widget rowChild(bool favoriteView, Computer computer) {
    return Expanded(
        flex: 2,
        child: GestureDetector(
          onTap: () {
            selectDevice(computer);
            modifySelectedDevice();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      (!favoriteView)? Icon((computer.isFavorite)?Icons.star:Icons.star_border,color: (computer.isFavorite)? const Color(0xFFFBC02D):const Color(0xFFFBC02D),):const SizedBox(),
                      const Spacer(),
                      Icon(
                        (computer.isOnline)
                            ? Icons.wifi
                            : Icons.wifi_off,
                        size: 30,
                        color: (computer.isOnline)
                            ? Colors.green[400]
                            : Colors.red[400],
                      ),
                    ],
                  ),
                  const Center(
                    child: Icon(
                      Icons.computer_outlined,
                      size: 100,
                      color: Color(0xFF4FC3F7),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            computer.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  selectDevice(Computer computer) {
    _selectedComputer = computer;
  }

  void _refresh() {
    setState(() {
      Computer.refreshComputerStatus();
    });
  }

  FutureOr onGoBack(dynamic value) {
    _refresh();
  }

  void modifySelectedDevice() {
    Route route = MaterialPageRoute(
        builder: (context) => DeviceSettings(
          computer: _selectedComputer,
        ),
    );
    Navigator.push(context,route).then(onGoBack);
  }
}

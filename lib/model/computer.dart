import 'dart:math';

class Computer{
  static int computerCounter = 0;
  static List<Computer> listOfComputers = [];
  int id=0;
  String name='';
  bool isOnline=false;
  bool isFavorite=false;

  static bool createdData=false;

  Computer(){
    computerCounter++;
    id = computerCounter;
    name = 'Computer $id';
    isOnline = Random().nextBool();
    isFavorite = true;
    listOfComputers.add(this);
  }

  Computer.defined(this.name, this.isOnline){
    computerCounter++;
    id = computerCounter;
    listOfComputers.add(this);
  }

  void toggleFavorite(){
    isFavorite = !isFavorite;
  }

  static void createDummyData(){
    if(!createdData) {
      Computer.defined("My PC", true);
      for (int i = 0; i < 7; i++) {
        Computer();
      }
      createdData=true;
    }
  }
  static void addNewComputer(){
    Computer();
  }
static void addNewComputerDefined(String name, bool isOnline){
    Computer.defined(name, isOnline);
  }
  static void removeComputer(Computer computer){
    listOfComputers.remove(computer);
  }
  static void refreshComputerStatus(){
    for(int i=0; i<computerCounter; i++){
      if(listOfComputers[i].name == 'My PC'){
        listOfComputers[i].isOnline = true;
      }else {
        listOfComputers[i].isOnline = Random().nextBool();
      }
    }
  }

  static int favoriteComputers() {
    int count = 0;
    for (int i = 0; i < computerCounter; i++) {
      if (listOfComputers[i].isFavorite) {
        count++;
      }
    }
    return count;
  }

  bool connect() {
    return isOnline;
  }
  void refresh(){
    isOnline = Random().nextBool();
  }
  static bool isThereFavorites(){
    for(int i=0; i<computerCounter; i++){
      if(listOfComputers[i].isFavorite){
        return true;
      }
    }
    return false;
  }

  static bool isThereOnline() {
    for (int i = 0; i < computerCounter; i++) {
      if (listOfComputers[i].isOnline) {
        return true;
      }
    }
    return false;
  }

  //void sendMouseClick(String button) {}

  void sendMouseEvent(int event, double value) {
    print("Mouse click: ${getEventName(event)} $value");
  }
  String getEventName(int event){
    switch(event){
      case 0:
        return 'Left';
      case 1:
        return 'Right';
      case 2:
        return 'Middle';
      case 3:
        return 'Scroll Up';
      case 4:
        return 'Scroll Down';
      default:
        return 'Unknown';
    }
  }
}
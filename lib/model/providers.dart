import 'package:flutter/material.dart';

// storage : id, password, location,  nickName
class UserProvider extends ChangeNotifier {
  String _id="", _nickName="";
  Image? _image;

  get getId => _id;
  get getNickName => _nickName;
  get getImage => _image;

  set setId(String id){
    _id = id;
    notifyListeners();
  }
  set setNickName(String name){
    _nickName = name;
    notifyListeners();
  }
  set setImage(Image image){
    _image = image;
    notifyListeners();
  }
  void logout(){
    _id = "";
    _nickName = "";
    _image = null;
    notifyListeners();
  }
}

class LocationProvider extends ChangeNotifier{
  List<String> _location = ["","",""];

  List<String> getLoc() => _location;

  void setLocIndex(String loc, int index){
    if(0 <= index && index < 3){
      _location[index] = loc;
      notifyListeners();
    }
  }
  set setLoc(List<String> loc){
    _location = loc;
    notifyListeners();
  }

}

class SMSResponse extends ChangeNotifier {
  bool isComplete = false;

  set setIsComplete(val){
    isComplete = val;
    notifyListeners();
  }
}
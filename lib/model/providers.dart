import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _id, _nickName;
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
}

class LocationProvider extends ChangeNotifier{
  String? _location_1, _location_2, _location_3;

  get getLoc1 => _location_1;
  get getLoc2 => _location_2;
  get getLoc3 => _location_3;

  set setLoc1(String loc){
    _location_1 = loc;
    notifyListeners();
  }
  set setLoc2(String loc){
    _location_2 = loc;
    notifyListeners();
  }
  set setLoc3(String loc){
    _location_3 = loc;
    notifyListeners();
  }
}
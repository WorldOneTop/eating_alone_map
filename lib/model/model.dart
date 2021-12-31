import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'enum.dart';

enum Storage {
  id, password
}

class User {
  String? _id,_password,_nickName,_image;

  get getId => _id;
  get getPassword => _password;
  get getNickName=> _nickName;
  get getImage=>_image;

  bool setId(String id){
    if((int.tryParse(id) != null) && 10 <= id.length && id.length <= 11){
      _id = id;
      return true;
    }
    return false;
  }
  bool setPassword(String pwd,{bool isChange = true}){
    if(pwd.isEmpty){
      return false;
    }
    if(isChange) {
      _password = '${sha256.convert(utf8.encode(pwd))}';
    }else{
      _password = pwd;
    }
    return true;
  }
  bool setNickName(String nickName){
    if(nickName.isNotEmpty && nickName.length <= 20){
      _nickName = nickName;
      return true;
    }
    return false;
  }
  bool setImage(String img){
    if(img.isNotEmpty && img.length <= 20){
      _image = img;
      return true;
    }
    return false;
  }
}

class Review {
  int? _id, _houseId;
  String? _userId, _body, _hashtag, _images, _time;
  double? _rating;

  get getId => _id;
  get getUserId => _userId;
  get getHouseId => _houseId;
  get getBody =>_body;
  get getHashtag => _hashtag;
  get getImages => _images;
  get getRating => _rating;
  get getTime => _time;

  bool setId(int id){
    if(0 <= id){
      _id = id;
      return true;
    }
    return false;
  }
  bool setUserId(String id){
    if(10 <= id.length && id.length <= 11){
      _userId = id;
      return true;
    }
    return false;
  }
  bool setHouseId(int id){
    if(0 <= id){
      _id = id;
      return true;
    }
    return false;
  }
  bool setBody(String s){
    if(s.isNotEmpty){
      _body = s;
    }
    return false;
  }
  bool setHashtag(String s){
    if(s.isNotEmpty && s.length <= 200){
      _hashtag = s;
      return true;
    }
    return false;
  }
  bool setImages(String s){
    if(s.isNotEmpty && s.length <= 104){
      _images = s;
      return true;
    }
    return false;
  }
  bool setRating(double d){
    if(0<= d && d <=5 && (d % 0.5 == 0.0)){
      _rating = d;
      return true;
    }
    return false;
  }
  bool setTime(String s){
    _time = s;
    return true;
  }
}

class ModelImage {
  int?  _reviewId;
  String? _url;

  get getReviewId => _reviewId;
  get getUrl => _url;

  bool setUrl(String s){
    if(s.length <= 20){
      _url = s;
      return true;
    }
    return false;
  }
  bool setReviewId(int id){
    if(0 <= id){
      _reviewId = id;
      return true;
    }
    return false;
  }
}
class HouseMain {
  int? _id,_reviewCount;
  String? _name,_category,_location,_location_1,_location_2,_location_3,_priceImage,_profileImage;
  double? _rating;

  get getId => _id;
  get getReviewCount => _reviewCount;
  get getPriceImage => _priceImage;
  get getProfileImage => _profileImage;
  get getName => _name;
  get getCategory => _category;
  get getLocation => _location;
  get getLocation_1 => _location_1;
  get getLocation_2 => _location_2;
  get getLocation_3 => _location_3;
  get getRating => _rating;

  bool setId(int id){
    if(0 <= id){
      _id = id;
      return true;
    }
    return false;
  }
  bool setReviewCount(int i){
    if(0 <= i){
      _reviewCount = i;
      return true;
    }
    return false;
  }
  bool setName(String s){
    if(s.isNotEmpty && s.length <= 20){
      _name = s;
      return true;
    }
    return false;
  }
  bool setCategory(String s){
    if(DataList.menuName.contains(s)){
      _category = s;
      return true;
    }return false;
  }
  bool setLocation(String s){
    if(s.isNotEmpty && s.length <= 30){
      _location = s;
      return true;
    }
    return false;
  }
  bool setLocation_1(String s){
    if(s.isNotEmpty && s.length <= 7){
      _location_1 = s;
      return true;
    }
    return false;
  }
  bool setLocation_2(String s){
    if(s.isNotEmpty && s.length <= 7){
      _location_2 = s;
      return true;
    }
    return false;
  }
  bool setLocation_3(String s){
    if(s.isNotEmpty && s.length <= 7){
      _location_3 = s;
      return true;
    }
    return false;
  }
  bool setPriceImage(String s){
    if(s.isNotEmpty && s.length <= 20){
      _priceImage = s;
      return true;
    }
    return false;
  }
  bool setProfileImage(String s){
    if(s.isNotEmpty && s.length <= 20){
      _profileImage = s;
      return true;
    }
    return false;
  }
  bool setRating(double d){
    if(0<= d && d <=5 && (d % 0.5 == 0.0)){
      _rating = d;
      return true;
    }
    return false;
  }
}

class HouseDetail {
  int? _houseId;
  String? _info, _time, _number;
  double? _lat, _lng;

  get getHouseId => _houseId;
  get getInfo => _info;
  get getTime => _time;
  get getNumber => _number;
  get getLat => _lat;
  get getLng => _lng;

  bool setHouseId(int i){
    if(0 <= i){
      _houseId = i;
      return true;
    }
    return false;

  }
  bool setInfo(String s){
    if(s.isNotEmpty && s.length <= 200){
      _info = s;
      return true;
    }
    return false;
  }
  bool setTime(String s){
    if(s.isNotEmpty && s.length <= 120){
      _time= s;
      return true;
    }
    return false;
  }
  bool setNumber(String s){
    if(s.isNotEmpty && s.length <= 11){
      _number = s;
      return true;
    }
    return false;
  }
  bool setLat(double d){
    if( 124 <= d && d<= 132 ){
      _lat = d;
      return true;
    }
    return false;
  }
  bool setLng(double d){
    if(33 <= d && d<= 43){
      _lng = d;
      return true;
    }
    return false;
  }
}

class HouseMenu{
  int? _houseId,_price;
  String? _name,_image;

  get getHouseId => _houseId;
  get getPrice => _price;
  get getName => _name;
  get getImage => _image;

  bool setHouseId(int i) {
    if (0 <= i) {
      _houseId = i;
      return true;
    }
    return false;
  }
  bool setPrice(int i){
    if(100 <= i && i < 1000000){
      _price = i;
      return true;
    }
    return false;
  }
  bool setName(String s){
    if(s.isNotEmpty && s.length <= 200){
      _name = s;
      return true;
    }
    return false;
  }
  bool setImage(String s){
    if(s.isNotEmpty && s.length <= 20){
      _image= s;
      return true;
    }
    return false;
  }
}
class Question{
  int? _id;
  String? _head,_body,_image,_category,_userId,_time;

  get getId => _id;
  get getHead => _head;
  get getBody => _body;
  get getImage => _image;
  get getCategory => _category;
  get getUserId => _userId;
  get getTime => _time;

  bool setId(int i){
    if(0 <= i){
      _id = i;
      return true;
    }
    return false;
  }
  bool setHead(String s){
    if(s.isNotEmpty && s.length <= 60){
      _head = s;
      return true;
    }
    return false;
  }
  bool setBody(String s){
    if(s.isNotEmpty){
      _body = s;
      return true;
    }
    return false;
  }
  bool setImage(String s){
    if(s.isNotEmpty && s.length <= 62){
      _image = s;
      return true;
    }
    return false;
  }
  bool setCategory(String s){
    if(DataList.questionCategory.contains(s)){
      _category = s;
      return true;
    }
    return false;
  }
  bool setUserId(String s){
    if(10 <= s.length && s.length <= 11){
      _userId = s;
      return true;
    }
    return false;
  }
  bool setTime(String s){
    _time = s;
    return true;
  }
}
class Answer{
  int? _questionId;
  String? _body;

  get getQuestionId => _questionId;
  get getBody => _body;

  bool setQuestionId(int i) {
    if(0 <= i){
      _questionId = i;
      return true;
    }
    return false;
  }
  bool setBody(String s){
    if(s.isNotEmpty){
      _body = s;
      return true;
    }
    return false;
  }
}
class Notice{
  String? _head,_body,_time;

  get getHead => _head;
  get getBody=> _body;
  get getTime => _time;

  bool setHead(String s){
    if(s.isNotEmpty && s.length <= 60){
      _head = s;
      return true;
    }
    return false;
  }
  bool setBody(String s){
    if(s.isNotEmpty){
      _body = s;
      return true;
    }
    return false;
  }
  bool setTime(String s){
    _time = s;
    return true;
  }
}

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:eating_alone/model/enum.dart';
import 'package:eating_alone/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum FailMsg{
  User_DoesNotExist, User_PasswordDoNotMatch, User_AlreadyExist, House_DoesNotExist, Review_DoesNotExist, ETC
}
class UserQuery {
  User user;
  UserQuery(this.user);

  Future<String> login() async {
    var response = await http.get(Uri.parse("${DataList.url}login?id=${user.getId}&password=${user.getPassword}"));
    return response.body;
  }
  Future<Map> userInfo() async {
    var response = await http.get(Uri.parse("${DataList.url}selectUserInfo?id=${user.getId}"));
    return jsonDecode(response.body);
  }
  Future<String> checkId() async {
    var response = await http.get(Uri.parse("${DataList.url}checkId?id=${user.getId}"));
    return response.body;
  }
  Future<String> signUp() async {
    var response = await http.get(Uri.parse("${DataList.url}signUp?id=${user.getId}&password=${user.getPassword}&nickName=${user.getNickName}"));
    return response.body;
  }
  Future<String> accoutOut() async {
    var response = await http.get(Uri.parse("${DataList.url}accoutOut?id=${user.getId}&password=${user.getPassword}"));
    return response.body;
  }
  Future<String> updatePwd(String newPwd) async {
    var response = await http.get(Uri.parse("${DataList.url}updatePassword?id=${user.getId}&password=${user.getPassword}&newPassword=$newPwd"));
    return response.body;
  }
  Future<String> updateName(String name) async {
    var response = await http.get(Uri.parse("${DataList.url}updateNickname?id=${user.getId}&nickName=$name"));
    return response.body;
  }
  Future<String> findAccount() async {
    var response = await http.get(Uri.parse("${DataList.url}findAccount?id=${user.getId}"));
    return response.body;
  }
}
class QuestionNotice {

  Future<List> notice() async {
    var response = await http.get(Uri.parse("${DataList.url}selectNotice"));
    return jsonDecode(response.body);
  }
  Future<List> faq() async {
    var response = await http.get(Uri.parse("${DataList.url}selectFAQ"));
    return jsonDecode(response.body);
  }
  Future<List> myQuestionList(String id) async {
    var response = await http.get(Uri.parse("${DataList.url}selectMyQuestion?id=$id"));
    return jsonDecode(response.body);
  }
  Future<String> qna(String head, String body, String category, String userId, {String? image}) async {
    var response = await http.get(Uri.parse("${DataList.url}createQnA?head=$head&body=$body&category=$category&user_id=$userId${
    image != null ? "&image=$image" : ""
    }"));
    return response.body;
  }
}

class HouseModel{

  Future<String> createHouse(House house) async {
    String time='', number='';
    if(house.time != null){
      time = "&time=${house.time}";
    }
    if(house.number != null){
      number = "&number=${house.number}";
    }

    var response = await http.get(Uri.parse("${DataList.url}createHouse?"
        "name=${house.name}&location=${house.location}&category=${house.category}&info=${house.info}&lat=${house.lat}&lng=${house.lng}$time$number"
        ));


    return response.body;
  }
//  Future<List> selectSearchHouse(String name,String loc1, {String? loc2, String? loc3}) async {
//    String l2 = '', l3 = '';
//    if(loc2 != null){
//      l2 = "&location_2=" + loc2;
//    }
//    if(loc3 != null){
//      l3 = "&location_3=" + loc3;
//    }
//    var response = await http.get(Uri.parse("${DataList.url}selectSearchHouse?"
//        "name=$name&location_1=$loc1" + l2 + l3
//    ));
//
//    //id, rating, name, review_count, category, profile_image
//    return jsonDecode(response.body);
//  }

  Future<List> selectCategoryHouse(String category, List<String>locations) async {
    String args = "category=$category&location_1=${locations[0]}";

    if(locations[1].isNotEmpty){
      args += "&location_2=${locations[1]}";
    }
    if(locations[2].isNotEmpty){
      args += "&location_3=${locations[2]}";
    }
    var response = await http.get(Uri.parse("${DataList.url}selectCategoryHouse?" + args));

    // id, rating, name, review_count, profile_image, location
    return jsonDecode(response.body);
  }

  Future<List> selectLocationHouse(List<String> loc, {String? category}) async {
    String l2 = '', l3 = '';
    String cate = '';

    if(loc[1].isNotEmpty){
      l2 = "&location_2=" + loc[1];
    }
    if(loc[2].isNotEmpty){
      l3 = "&location_3=" + loc[2];
    }
    if(category != null){
      cate = "&category=" + category;
    }
    var response = await http.get(Uri.parse("${DataList.url}selectLocationHouse?location_1=" + loc[0] + l2 + l3 + cate));

    //id, rating, name, review_count, profile_image, lat, lng, category
    return jsonDecode(response.body);
  }

  Future<String> createHouseMenu(int houseId, List<HouseMenu> menus) async {
    String getUrl = "[";
    for(HouseMenu m in menus){
      getUrl += m.toString()+",";
    }
    getUrl = getUrl.replaceRange(getUrl.length-1,getUrl.length,"]");

    var response = await http.get(Uri.parse("${DataList.url}createHouseMenu?"
        "houseId=$houseId&menus="+getUrl
    ));

    return response.body;
  }
  Future<String> deleteHouseMenu(List<String> id) async {
    String getUrl = "";

    for(String s in id){
      getUrl += s+"=&";
    }

    var response = await http.get(Uri.parse("${DataList.url}deleteHouseMenu?" +getUrl
    ));

    return response.body;
  }
  Future<String> updateHouseMenu(List<HouseMenu> menus) async { //id필요
    String getUrl = "[";
    for(HouseMenu m in menus){
      getUrl += m.toString()+",";
    }
    getUrl = getUrl.replaceRange(getUrl.length-1,getUrl.length,"]");

    var response = await http.get(Uri.parse("${DataList.url}updateHouseMenu?"
        "menus="+getUrl
    ));

    return response.body;
  }

  Future<Map> selectHouseInfo(houseId) async {
    var response = await http.get(Uri.parse("${DataList.url}selectHouseInfo?id=$houseId"));
    return jsonDecode(response.body);
  }
  Future<List> selectHouseMenu(houseId) async { //[{name, price, image}]
    var response = await http.get(Uri.parse("${DataList.url}selectHouseMenu?id=$houseId"));
    return jsonDecode(response.body);
  }
  Future<List> selectHouseReview(houseId) async { // [user_id, user_image, user_nickName, time, body, hashtag, rating, images]
    var response = await http.get(Uri.parse("${DataList.url}selectHouseReview?id=$houseId"));
    return jsonDecode(response.body);
  }


}

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
}
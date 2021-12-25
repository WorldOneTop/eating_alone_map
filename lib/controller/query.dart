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
  static Future<String> login(User user) async {
    var response = await http.get(Uri.parse("${DataList.url}login?id=${user.getId}&password=${user.getPassword}"));
    return response.body;
  }
  static Future<Map> userInfo(User user) async {
    var response = await http.get(Uri.parse("${DataList.url}selectUserInfo?id=${user.getId}"));
    return jsonDecode(response.body);
  }
}
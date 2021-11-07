import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eating_alone/view/layouts/inputfield.dart';

enum Appbar_mode {main, search, detail}

class CustomAppbar {
  static final CustomAppbar _instance = CustomAppbar._();

  CustomAppbar._(){}

  static CustomAppbar getInstance() {
    return _instance;
  }

  AppBar getAppBar(BuildContext context, Appbar_mode mode, String title_name) {
    Text? my_Title;
    Container? searchField;
    List<Widget>? my_Actions = null;

    if(mode == Appbar_mode.main) {
      my_Title = const Text('혼밥여지도');
      my_Actions = [IconButton( icon: const Icon(Icons.search),onPressed: () {
        Fluttertoast.showToast(msg: "검색창으로 이동");
        })];
    } else if(mode == Appbar_mode.search) {
      searchField = CustomTextField().normalInput( hint:title_name, suffixIcon: const Icon(Icons.search),size:1);
    } else if(mode == Appbar_mode.detail) {
      my_Title = Text(title_name,style:Theme.of(context).textTheme.bodyText1);
    }

    return AppBar(
    leadingWidth: 30,
    centerTitle: false,
    title: mode == Appbar_mode.search ? searchField : my_Title,
    leading: mode == Appbar_mode.main ? null :
      IconButton(icon:const Icon(Icons.navigate_before), onPressed: () {
        Navigator.pop(context);
      }),
    actions: mode == Appbar_mode.detail ? null : my_Actions
    );
  }

}
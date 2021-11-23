import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eating_alone/view/layouts/inputfield.dart';
import 'package:eating_alone/model/enum.dart';

import '../search_page.dart';


class CustomAppbar {
  static final CustomAppbar _instance = CustomAppbar._();

  CustomAppbar._(){}

  static CustomAppbar getInstance() {
    return _instance;
  }

  AppBar getAppBar(BuildContext context, Appbar_mode mode, String title_name, {var bottom,TextEditingController? ctr,Function(String)? onChange}) {
    Text? my_Title;
    Container? searchField;
    List<Widget>? my_Actions = null;

    if(mode == Appbar_mode.main) {
      my_Title = const Text('혼밥여지도');
      my_Actions = [IconButton( icon: const Icon(Icons.search),onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
})];
    } else if(mode == Appbar_mode.search) {
      searchField = CustomTextField.normalInput( hint:title_name, suffixIcon: const Icon(Icons.search),size:1,controller: ctr,onChange: onChange);
    } else if(mode == Appbar_mode.detail) {
      my_Title = Text(title_name,style:Theme.of(context).textTheme.headline6);
    }else if(mode == Appbar_mode.menu) {
      my_Title = Text(title_name,style: Theme.of(context).textTheme.headline4);
      my_Actions = [IconButton( icon: const Icon(Icons.map_outlined,),onPressed: () {
        Fluttertoast.showToast(msg: "메뉴창으로 이동");
      })];
    }

    return AppBar(
    leadingWidth: 30,
    centerTitle: mode == Appbar_mode.menu,
    bottom: bottom,
    title: mode == Appbar_mode.search ? searchField : my_Title,
    leading: mode == Appbar_mode.main ? null :
      IconButton(icon:const Icon(Icons.navigate_before,size: 35), onPressed: () {
        Navigator.pop(context);
      }),
    actions: mode == Appbar_mode.detail ? null : my_Actions,
    );
  }

}
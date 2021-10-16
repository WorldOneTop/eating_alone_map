import 'package:flutter/material.dart';

class CustomDrawer{
  String _name = "이름 없음", _location = "설정 안함";
  static CustomDrawer _instance = CustomDrawer._();

  CustomDrawer._(){}

  static CustomDrawer getInstance() {
    return _instance;
  }

  void setName(String name) {
    _name = name;
  }
  void setLocation(String location) {
    _location = location;
  }

  Drawer getDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
//              backgroundImage: ImageIcon(Icon(Icons.account_box)),
              backgroundColor: Colors.white,
            ),
            accountName: Text(_name),
            accountEmail: Text(_location),
            onDetailsPressed: (){
              print("arrow is Clicked");
            },
            decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)
                )
            ),
          ),
          ListTile(
            /*leading: Icon(Icons.home,
              color: Colors.grey[850],), */
            title: Text("계정 정보"),
            onTap: () {
              print("AccountInfo is Cicked");
              Navigator.pushNamed(context, '/AccountInfo');
            },
          ),
          ListTile(
            /*leading: Icon(Icons.home,
            color: Colors.grey[850],),*/
              title: Text("내 활동"),
              onTap: () {
                print("MyActivity is Clicked");
                Navigator.pushNamed(context, '/MyActivity');
              }
          ),
          ListTile(
            /*leading: Icon(Icons.home,
            color: Colors.grey[850],),*/
              title: Text("공지사항"),
              onTap: () {
                print("Notice is Clicked");
                Navigator.pushNamed(context, '/Notice');
              }
          ),
          ListTile(
            /*leading: Icon(Icons.home,
            color: Colors.grey[850],),*/
              title: Text("문의하기"),
              onTap: () {
                print("Question is Clicked");
                Navigator.pushNamed(context, '/Question');
              }
          ),
          ListTile(
            /*leading: Icon(Icons.home,
            color: Colors.grey[850],),*/
              title: Text("버그리포트"),
              onTap: () {
                print("Bug_Report is Clicked");
                Navigator.pushNamed(context, '/BugReport');
              }
          ),
        ],
      ),
    );
  }

}

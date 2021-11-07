import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDrawer{
  String _name = "로그인을 해주세요.", _location = "전국", _profileImage = 'assets/images/defaultProfile.png';
  static final CustomDrawer _instance = CustomDrawer._();

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
  void setProfileImage(String profileImage) {
    _profileImage = profileImage;
  }

  Drawer getDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
              onTap: (){
                // 로그인 확인하는 모델 생성 이후 처리
                Fluttertoast.showToast(msg: "로그인 페이지로 이동");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(children: [
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: AssetImage(_profileImage),
                  backgroundColor: const Color(0xFFF0F0F0F0),
                  radius: 30,
                ),
                const SizedBox(width: 15),
                Expanded(child:
                  Column(children: [
                    Text(_name,style: Theme.of(context).textTheme.headline5,overflow: TextOverflow.ellipsis,),
                    Text(_location,style: Theme.of(context).textTheme.subtitle1)
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,)
                )
              ]),
                decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius:  const BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)
                    )
                )
          )),
          const SizedBox(height: 10),
          ListTile(
            horizontalTitleGap: -5,
            leading: Icon(Icons.account_box,
              color: Colors.grey[850]),
            title: const Text("계정 정보"),
            onTap: () {
              print("AccountInfo is Cicked");
              Navigator.pushNamed(context, '/AccountInfo');
            },
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.directions_run,
                color: Colors.grey[850],),
              title: const Text("내 활동"),
              onTap: () {
                print("MyActivity is Clicked");
                Navigator.pushNamed(context, '/MyActivity');
              }
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.content_paste_rounded,
                color: Colors.grey[850],),
              title: Text("공지사항"),
              onTap: () {
                print("Notice is Clicked");
                Navigator.pushNamed(context, '/Notice');
              }
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.question_answer,
                color: Colors.grey[850],),
              title: Text("문의하기"),
              onTap: () {
                print("Question is Clicked");
                Navigator.pushNamed(context, '/Question');
              }
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.bug_report,
                color: Colors.grey[850],),
              title: Text("버그리포트"),
              onTap: () {
                print("Bug_Report is Clicked");
                Navigator.pushNamed(context, '/BugReport');
              }
          ),ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.settings,
                color: Colors.grey[850],),
              title: Text("설정"),
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

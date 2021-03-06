import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';

import '../login_page.dart';
import '../menu_pages.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget{
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+15,bottom: 20),
                  child: Row(children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage(_profileImage),
                      backgroundColor: const Color(0xFFF0F0F0),
                      radius: 30,
                    ),
                    const SizedBox(width: 15),
                    Expanded(child:
                    Column(children: [
                      Text(context.select<UserProvider, String>((user) => user.getNickName),
                        style: Theme.of(context).textTheme.headline5,overflow: TextOverflow.ellipsis,),
                      Text("",
//                          context.watch<LocationProvider>().getlocation[1],
//                        context.select((LocationProvider loc){
//                      if(loc.getLoc()[1].isNotEmpty){
//                        return loc.getLoc()[1];
//                      }
//                      return loc.getLoc()[0];
//                    }),
                          style: Theme.of(context).textTheme.subtitle1)
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
            title: const Text("계정 정보",style: TextStyle(height: 1)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfo()));
            },
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.directions_run,
                color: Colors.grey[850],),
              title: const Text("내 활동",style: TextStyle(height: 1.1)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyActivity()));
              }
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.content_paste_rounded,
                color: Colors.grey[850],),
              title: const Text("공지사항",style: TextStyle(height: 1.1)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Notice()));
              }
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.question_answer,
                color: Colors.grey[850],),
              title: const Text("문의하기",style: TextStyle(height: 1.1)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Question()));
              }
          ),
          ListTile(
              horizontalTitleGap: -5,
              leading: Icon(Icons.settings,
                color: Colors.grey[850],),
              title: const Text("환경설정",style: TextStyle(height: 1.1)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
              }
          ),
        ],
      ),
    );
  }


}

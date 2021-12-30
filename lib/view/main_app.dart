import 'package:eating_alone/model/providers.dart';
import 'package:eating_alone/view/menu_pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';
import './layouts/export_all.dart';
import './main_menu.dart';
import './main_map.dart';
import 'package:eating_alone/model/enum.dart';

class MainSelect extends StatelessWidget {
  TabBar tabBar = const TabBar(
      indicatorColor: Color(0xca000000),
      labelColor: Color(0xca000000),
      unselectedLabelColor: Color(0xFFFFFFFF),
      tabs: [
        Icon(Icons.home,size: 35),
        Icon(Icons.map_outlined,size: 35),
      ]);


//  https://another-light.tistory.com/76
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
        child: Scaffold(
          drawer: customDrawer(context),//CustomDrawer.getInstance(),
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.main, '',bottom : tabBar),
          body:
            TabBarView(children: [
              Container(child: MainMenu(), margin: const EdgeInsets.symmetric(horizontal: 15)),
              MainMap(context.read<LocationProvider>().getLoc())
            ],physics: const BouncingScrollPhysics())
        ));
  }


  String _profileImage = 'assets/images/defaultProfile.png';
  Drawer customDrawer(BuildContext context){
    String nickName = context.select<UserProvider, String>((UserProvider user){
      if(user.getId.toString() == 'anonymous'){
        return "로그인을 해주세요.";
      }else{
        return user.getNickName;
      }
    });
    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
              onTap: (){
                if(nickName == '로그인을 해주세요.') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
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
                      Text(nickName,
                        style: Theme.of(context).textTheme.headline5,overflow: TextOverflow.ellipsis,),
                      Text(context.select((LocationProvider loc){
                        return "${loc.getLoc()[0]} ${loc.getLoc()[1]}";
                      }),
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
          getUserPrivateMenu(context, nickName != '로그인을 해주세요.'),
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

  Visibility getUserPrivateMenu(BuildContext context, bool visible){
    return Visibility(
      visible: visible,
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}






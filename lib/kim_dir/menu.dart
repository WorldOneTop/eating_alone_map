import 'package:flutter/material.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      body: Padding(
        padding: EdgeInsets.fromLTRB(150.0, 100.0, 100.0, 500.0),
        child: Column(
          children: [
            Text("혼밥여지도",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing:  2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
              ),)
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("혼밥여지도"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0.0,

        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Search button is Clicked");
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('asset/idicon/png'),
                backgroundColor: Colors.white,
              ),
              accountName: Text("김대현"),
              accountEmail: Text("rlaeogus9269@naver.com"),
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
      ),

    );
  }
}
import 'package:flutter/material.dart';
import 'package:untitled3/menu.dart';
import 'package:untitled3/accountinfo.dart';
import 'package:untitled3/myactivity.dart';
import 'package:untitled3/notice.dart';
import 'package:untitled3/question.dart';
import 'package:untitled3/bugreport.dart';

void main() => runApp(Myapp());

class  Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " 혼밥여지도",
      //이니셜 라우트는 홈을 인텐트로 넘기기 수월하기 위해 그냥 지정해주는거 같음
      initialRoute: '/Home',
      routes: {
        '/Home' : (context) => Home(),
        '/Menu' : (context) => Menu(),
        '/AccountInfo': (context) => AccountInfo(),
        '/MyActivity' : (context) => MyActivity(),
        '/Notice' : (context) => Notice(),
        '/Question' : (context) => Question(),
        '/BugReport' : (context) => BugReport()
      },
        home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("혼밥여지도"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
           icon: Icon(Icons.menu),
          onPressed: () {
             Navigator.pushNamed(context, '/Menu');
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Search button is Clicked");
            },
          )
        ],
      ),
    );
  }
}









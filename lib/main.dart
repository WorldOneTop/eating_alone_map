import 'package:flutter/material.dart';
import './layouts/login_page.dart';
import './layouts/home.dart';
import './layouts/appbar.dart';
import './layouts/drawer.dart';
import './layouts/info_house.dart';

//  ThemeData 활용해 볼것
void main() {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Elice',

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFffeb56),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 22, letterSpacing: 3.0, color: Colors.white)
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 46, fontWeight: FontWeight.bold, letterSpacing: 8.0, color: Colors.black87),
          headline2: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, letterSpacing: 6.0, color: Colors.black87),
          headline3: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4.0,color: Colors.black87),
          headline4: TextStyle(fontSize: 26, color: Colors.black87,fontWeight: FontWeight.w600),
          headline5: TextStyle(fontSize: 18, color: Colors.black87,fontWeight: FontWeight.w600),
          headline6: TextStyle(fontSize: 18.0,  color: Colors.black87),
          subtitle1: TextStyle(fontSize: 18.0, color: Colors.black87,letterSpacing: 1.2),
          subtitle2: TextStyle(fontSize: 16.0, color: Colors.amberAccent),
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.black87),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.teal),
        ),
      ),
      home: const MyApp()
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView(children: [
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Text('Login Page Layout')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('home')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
              },
              child: Text('Intro Layout')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AppBarTest()));
              },
              child: Text('appbar Layout')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => InfoTest()));
              },
              child: Text('info_house , 식당간략정보')),
        ],)
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor:const Color(0xFFffeb56),
        body: Container(
          margin: const EdgeInsets.all(50),
          child: Center(
              child: ListView(children: [
                Text('헤드라인1', style:Theme.of(context).textTheme.headline1),
                Text('헤드라인2', style:Theme.of(context).textTheme.headline2),
                Text('헤드라인3', style:Theme.of(context).textTheme.headline3),
                Text('헤드라인4', style:Theme.of(context).textTheme.headline4),
                Text('헤드라인5', style:Theme.of(context).textTheme.headline5),
                Text('헤드라인6', style:Theme.of(context).textTheme.headline6),
                Text('서브타이틀1', style:Theme.of(context).textTheme.subtitle1),
                Text('서브타이틀2', style:Theme.of(context).textTheme.subtitle2),
                Text('바디1', style:Theme.of(context).textTheme.bodyText1),
                Text('바디2', style:Theme.of(context).textTheme.bodyText2),
              ],
              )
          ),
        )
    );
  }
}


class AppBarTest extends StatefulWidget {
  @override
  _AppBarTestState createState() => _AppBarTestState();
}

class _AppBarTestState extends State<AppBarTest> {
  Appbar_mode mode = Appbar_mode.main;
  String title = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: CustomDrawer.getInstance().getDrawer(context),
      appBar: CustomAppbar.getInstance().getAppBar(context, mode, title),
      body: Column(children: [
        const SizedBox(height: 50),
        ElevatedButton(onPressed: (){
          setState(() {
            mode = Appbar_mode.main;
          });}, child:const Text('main page appbar')),
        ElevatedButton(onPressed: (){
          setState(() {
            mode = Appbar_mode.search;
          });}, child: const Text('search page appbar')),
        ElevatedButton(onPressed: (){
          setState(() {
            mode = Appbar_mode.detail;
          });}, child: const Text('detail view page appbar')),
        TextField(decoration: const InputDecoration(labelText: 'detail에 들어갈 title'),
          onChanged: (value){setState(() {
            title = value;
        });},),
      ])
    );
  }
}

class InfoTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(children: [
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'두줄 길이의 식당 이름 및 overflow 테스트 ',category: '한식',heart: '♥', rating: 2,review: 1234 ),
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'찜하지 않은 식당',category: '한식',heart: '♡', rating: 2,review: 1234 ),
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'로그인 하지 않은 상태',category: '한식', rating: 2,review: 1234 ),
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'리뷰가 없을 때',category: '한식',heart: '♥'),
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'높이가 높을 때',category: '한식',heart: '♥', rating: 2,review: 1234 ,height:250),
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'작을경우 고정',category: '한식',heart: '♥', rating: 2,review: 1234 ,height:50),
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'이미지 테스트',image: 'assets/images/height.png'),
        SizedBox(height: 20,),
        InfoHouse().buildLayout(context,'이미지 테스트',image: 'assets/images/width.png'),
        SizedBox(height: 20,),
])
    );
  }
}
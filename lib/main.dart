import 'package:flutter/material.dart';
import './layouts/login_page.dart';
import './layouts/home.dart';

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
          headline4: TextStyle(fontSize: 26, color: Colors.black87),
          headline5: TextStyle(fontSize: 18, color: Colors.black87),
          headline6: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, color: Colors.pink),
          subtitle1: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, color: Colors.black87),
          subtitle2: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, color: Colors.amberAccent),
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.blue),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
              },
              child: Text('Intro Layout')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
              },
              child: Text('test')),
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

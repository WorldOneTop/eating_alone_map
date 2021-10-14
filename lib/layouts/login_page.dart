import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor:const Color(0xFFffeb56),
        body: Container(
          margin: const EdgeInsets.all(40),
            child: ListView(children: [
              Row(children:[const Icon(Icons.fastfood, size: 70),Text('혼밥여지도', style:Theme.of(context).textTheme.headline1)]),
              Center(child:Row(children:[
                IconButton(onPressed: (){Fluttertoast.showToast(
                    msg: "네이버로 로그인",
                  backgroundColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM
                );}, icon: Icon(Icons.assignment_ind)),
                IconButton(onPressed: (){Fluttertoast.showToast(
                  msg: "카카오톡으로 로그인",
                );}, icon: Icon(Icons.vignette)),
                IconButton(onPressed: (){Fluttertoast.showToast(
                  msg: "페이스북으로 로그인",
                );}, icon: Icon(Icons.facebook)),])),
              Container(
                  margin:EdgeInsets.symmetric(vertical: 5),
                  child:TextField(
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical:8, horizontal: 13),
                      filled: true,
                      fillColor: Colors.white70,
                      border: const OutlineInputBorder(),
                      labelText: 'ID',
                      labelStyle: Theme.of(context).textTheme.subtitle1
                  )),
              ),TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical:10, horizontal: 13),
                      filled: true,
                      fillColor: Colors.white70,
                      border: const OutlineInputBorder(),
                      labelText: 'PASSWORD',
                      labelStyle: Theme.of(context).textTheme.subtitle1
                  )
              ),




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
    );
  }

  ListTile _tile(String title, String subTitle, IconData icon) => ListTile(
    title: Text(
      title,
//      style: TextStyle(
//        fontWeight: FontWeight.w500,
//        fontSize: 20,
//      ),
    ),
    subtitle: Text(subTitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}
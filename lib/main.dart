import 'package:eating_alone/view/test.dart';
import 'package:flutter/material.dart';
import 'package:eating_alone/view/main_app.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/query.dart';
import 'model/model.dart';
import 'model/providers.dart';
import 'view/login_page.dart';



void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>UserProvider()),
            ChangeNotifierProvider(create: (context)=>LocationProvider()),
            ChangeNotifierProvider(create: (context)=>SMSResponse()),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
              fontFamily: 'Elice',
              scaffoldBackgroundColor: const Color(0xFFFEFEFE),
              textTheme: const TextTheme(
                headline1: TextStyle(fontSize: 46, fontWeight: FontWeight.bold, letterSpacing: 8.0, color: Colors.black87),
                headline2: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, letterSpacing: 6.0, color: Colors.black87),
                headline3: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4.0,color: Colors.black87),
                headline4: TextStyle(fontSize: 26, color: Colors.black87,fontWeight: FontWeight.w600),
                headline5: TextStyle(fontSize: 22, color: Colors.black87,fontWeight: FontWeight.w600),
                headline6: TextStyle(fontSize: 18.0,  color: Colors.black87,fontWeight: FontWeight.w600),
                subtitle1: TextStyle(fontSize: 18.0, color: Color(0xF0777777),letterSpacing: 1.2),
                subtitle2: TextStyle(fontSize: 16.0, color: Colors.amberAccent),
                bodyText1: TextStyle(fontSize: 18.0, color: Colors.black87,letterSpacing: 1.2),
                bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87)
              )),
              home:Splash()
          )));
}


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      setting();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body:Center(child:Text('혼밥여지도',style: Theme.of(context).textTheme.headline1))
    );
  }

  void setting() async{
    String? login = await isLoggedIn(context);
    if(login.isEmpty){// logged in
      SharedPreferences.getInstance().then((storage){
        context.read<UserProvider>().setId =  storage.getString('id')!;
        context.read<UserProvider>().setNickName =  storage.getString('nickName')!;
//        context.read<UserProvider>().setImage =  storage.getString('image')!;
        context.read<LocationProvider>().setLoc =  storage.getStringList('location')!;
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainSelect()),(route) => false);
      });
    }else if(login == 'anonymous'){
      context.read<UserProvider>().setId = "anonymous";
      SharedPreferences.getInstance().then((storage) {
        context.read<LocationProvider>().setLoc =  storage.getStringList('location')!;
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainSelect()),(route) => false);
      });
    }else{ // error or first
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            if(login != 'first'){
              Fluttertoast.showToast(msg: login);
            }
            SharedPreferences.getInstance().then((storage) {
              storage.setStringList('location', ['서울', '중구', '태평로1가']);
              context.read<LocationProvider>().setLoc = ['서울', '중구', '태평로1가'];
            });
            return LoginPage();
          }),(route) => false);
    }
  }

  Future<String> isLoggedIn(BuildContext context) async {
    final storage = await SharedPreferences.getInstance();
    String? id = storage.getString('id');
    String? pwd = storage.getString('password');
    if(id == 'anonymous'){
      return 'anonymous';
    }

    if(id == null || pwd == null){
      return "first";
    }
    User user = User();
    user.setId(id);
    user.setPassword(pwd,isChange: false);

    final login = await UserQuery(user).login();
    if(login.isNotEmpty){
      return login;
    }

    return "";
  }
}

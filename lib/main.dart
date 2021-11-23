//import 'package:eating_alone/view/create_review.dart';
import 'package:eating_alone/view/house_detail.dart';
import 'package:eating_alone/view/layouts/notice_tile.dart';
import 'package:eating_alone/view/menu_pages.dart';
import 'package:eating_alone/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:eating_alone/view/login_page.dart';
import 'package:eating_alone/view/layouts/home.dart';
import 'package:eating_alone/view/layouts/appbar.dart';
import 'package:eating_alone/view/layouts/drawer.dart';
//import 'package:eating_alone/view/layouts/info_house.dart';
import 'package:eating_alone/view/layouts/review.dart';
import 'package:eating_alone/view/layouts/enlarge_image.dart';
import 'package:eating_alone/view/signup_page.dart';
import 'package:eating_alone/view/account_find_page.dart';
import 'package:eating_alone/view/main_app.dart';
//import 'package:eating_alone/view/selected_menu.dart';
import 'package:eating_alone/model/enum.dart';

//  ThemeData 활용해 볼것
void main() {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Elice',
        scaffoldBackgroundColor: Color(0xFFFEFEFE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFffe62e),
          elevation: 0,
          centerTitle: true,
        ),
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
          bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
              },
              child: Text('폰트 확인')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Login Page Layout')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('home')),
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
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewTest()));
              },
              child: Text('Review Container')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnlargeImageTest()));
              },
              child: Text('이미지 크게보기 창')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: Text('회원가입 창')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountFindPage()));
              },
              child: Text('회원찾기 창')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainSelect()));
              },
              child: Text('메인 메뉴선택 창')),
          ElevatedButton(
              onPressed: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectMenu('한식')));
              },
              child: Text('메인 메뉴선택 이후 창')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: Text('검색창 페이지')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HouseDetail('24시전주명가콩나물국밥 강릉',category: '한식', rating: 4.0,review: 2 )));
              },
              child: Text('식당 정보 확인 페이지')),
          ElevatedButton(
              onPressed: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReview('24시전주명가콩나물국밥 강릉',category: '한식', rating: 4.0,review: 2 )));
              },
              child: Text('리뷰 작성 페이지')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfo()));
              },
              child: Text('메뉴 - 계정정보')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
              },
              child: Text('메뉴 - 설정')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyActivity()));
              },
              child: Text('메뉴 - 내 활동')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeTileTest()));
              },
              child: Text('notice tile layout')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Notice()));
              },
              child: Text('메뉴 - 공지사항')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Question()));
              },
              child: Text('메뉴 - 문의하기')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainSelect()));
              },
              child: Text('로그인 했다 치고 시작하기')),
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
      drawer: SafeArea(child:CustomDrawer.getInstance().getDrawer(context)),
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
//        InfoHouse('두줄 길이의 식당 이름 및 overflow 테스트 ',category: '패스트푸드',heart: '♥', rating: 2,review: 12345 ),
//        SizedBox(height: 20,),
//        InfoHouse('24시전주명가콩나물국밥 강릉점',category: '패스트푸드',heart: '♥', rating: 2,review: 12345 ),
//        SizedBox(height: 20,),
//        InfoHouse('찜하지 않은 식당',category: '네글자는',heart: '♡', rating: 2,review: 1234 ),
//        SizedBox(height: 20,),
//        InfoHouse('로그인 하지 않은 상태',category: '세글자', rating: 2,review: 1234 ),
//        SizedBox(height: 20,),
//        InfoHouse('리뷰가 없을 때',category: '한식',heart: '♥'),
//        SizedBox(height: 20,),
//        InfoHouse('높이가 높을 때',category: '한식',heart: '♥', rating: 2,review: 1234 ,height:250),
//        SizedBox(height: 20,),
//        InfoHouse('작을경우 고정',category: '한식',heart: '♥', rating: 2,review: 1234 ,height:50),
//        SizedBox(height: 20,),
//        InfoHouse('이미지 테스트',image: 'https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png'),
//        SizedBox(height: 20,),
//        InfoHouse('이미지 테스트',image: 'https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png'),
        SizedBox(height: 20,),
])
    );
  }
}

class ReviewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(height: 20,),
        ReviewContainer('이제일','글자만 있을 경우',DateTime.now()),
        SizedBox(height: 20,),
        ReviewContainer('이제일','점수 4',DateTime.now(),rating: 4,),
        SizedBox(height: 20,),
        ReviewContainer('이제일','점수 0.5',DateTime.now(),rating: 0.5,),
        SizedBox(height: 20,),
        ReviewContainer('이제일','해쉬태그들',DateTime.now(),hashtags: ['#가나','#다라','asfdasdfadsfsadfas']),
        SizedBox(height: 20,),
        ReviewContainer('이제일','긴 글자만 있을 경우 \n 제3항의 승인을 얻지 못한 때에는 그 처분 또는 명령은 그때부터 효력을 상실한다. 이 경우 그 명령에 의하여 개정 또는 폐지되었던 법률은 그 명령이 승인을 얻지 못한 때부터 당연히 효력을 회복한다. 모든 국민은 거주·이전의 자유를 가진다. 지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 국가는 대외무역을 육성하며, 이를 규제·조정할 수 있다. 국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경 제의 발전에 노력하여야 한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 제1항의 탄핵소추는 국회재적의원 3분의 1 이상의 발의가 있어야 하며, 그 의결은 국회재적의원 과반수의 찬성이 있어야 한다. 다만, 대통령에 대한 탄핵소추는 국회재적의원 과반수의 발의와 국회재적의원 3분의 2 이상의 찬성이 있어야 한다.',
            DateTime.now()),
        SizedBox(height: 20,),
        ReviewContainer('이제일','이미지 한장, 짧은 글',DateTime.now(),images:['https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png']),
        SizedBox(height: 20,),
        ReviewContainer('이제일','이미지 4장, 짧은 글',DateTime.now(),images:['https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png']),
        SizedBox(height: 20,),
        ReviewContainer('이제일',"이미지 여러장, 긴 글 \n 대통령은 조약을 체결·비준하고, 외교사절을 신임·접수 또는 파견하며, 선전포고와 강화를 한다. 모든 국민은 신속한 재판을 받을 권리를 가진다. 형사피고인은 상당한 이유가 없는 한 지체없이 공개재판을 받을 권리를 가진다. 국가는 주택개발정책등을 통하여 모든 국민이 쾌적한 주거생활을 할 수 있도록 노력하여야 한다. 대통령은 전시·사변 또는 이에 준하는 국가비상사태에 있어서 병력으로써 군사상의 필요에 응하거나 공공의 안녕질서를 유지할 필요가 있을 때에는 법률이 정하는 바에 의하여 계엄을 선포할 수 있다. 국가는 전통문화의 계승·발전과 민족문화의 창달에 노력하여야 한다. 농업생산성의 제고와 농지의 합리적인 이용을 위하거나 불가피한 사정으로 발생하는 농지의 임대차와 위탁경영은 법률이 정하는 바에 의하여 인정된다.",
            DateTime.now(),images: ['https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png']),
        SizedBox(height: 20,),
        ])
    );
  }
}

class EnlargeImageTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnlargeImage(['https://source.unsplash.com/user/c_v_r'])));
              },
              child: Text('이미지 하나')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnlargeImage(['https://picsum.photos/300/300','https://picsum.photos/10/30','https://picsum.photos/1000/1100','https://picsum.photos/4000/4400'])));
              },
              child: Text('이미지 4개(300x300),(10x30), (1000x1100), (4000x4400)')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnlargeImage(['assets/images/height.png'],isAssets: true,)));
              },
              child: Text('세로로 긴 이미지')),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EnlargeImage(['assets/images/width.png'],isAssets: true)));
              },
              child: Text('가로로 긴 이미지')),
        ],
      ),
    );
  }

}

class NoticeTileTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    return Scaffold(
      body: ListView(children: [
        NoticeTile('이벤트 관련 문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
            '${date.year}-${date.month}-${date.day}',false),
        NoticeTile('버그 관련 문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
            '${date.year}-${date.month}-${date.day}',false),
        NoticeTile('개인정보 관련 문의 개인 정보 관련 문의 개인정보관련문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
            '${date.year}-${date.month}-${date.day}',false,answer: NoticeTile('개인정보 관련 문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
            '${date.year}-${date.month}-${date.day}',true)),
      ],),
    );
  }
}

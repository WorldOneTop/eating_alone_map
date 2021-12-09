import 'package:eating_alone/model/enum.dart';
import 'package:eating_alone/view/layouts/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'layouts/area_setting.dart';
import 'layouts/info_house.dart';
import 'layouts/inputfield.dart';
import 'layouts/my_review.dart';
import 'layouts/notice_tile.dart';


class AccountInfo extends StatelessWidget {
  Map<String,String> accountTest = {
    'name':'이제일',
    'id':'010-5049-7758',
    'area':'강릉',
    'profileImage':'assets/images/defaultProfile.png'
  };
  TextEditingController ctrOld = TextEditingController();
  TextEditingController ctrNew = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '계정 정보'),
        body:Container(
            margin: const EdgeInsets.all(12),
            child:ListView(physics: const BouncingScrollPhysics(),children: [
              Row(children: [
                _profileLayout(),
                const SizedBox(width: 20),
                Expanded(child: Column(children: [
                  Text(accountTest['name']!,style: Theme.of(context).textTheme.headline3),
                ],crossAxisAlignment: CrossAxisAlignment.start,))
              ]),
              const SizedBox(height: 30),
              Text('검색 지역',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              AreaSetting(),
              const SizedBox(height: 30),
              Text('닉네임 변경',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              CustomTextField.normalInput(hint: accountTest['name']!,fillColor: 0xFdF0F0F0),
              const SizedBox(height: 30),
              Text('현재 비밀번호',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              CustomTextField.passwordInput(label: ''),
              const SizedBox(height: 20),
              Text('신규 비밀번호',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              CustomTextField.passwordInput(label: ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: (){
                      Fluttertoast.showToast(msg: '비번변경');
                    },
                    child: const Text('저장'))]),
              const SizedBox(height: 30),
              GestureDetector(onTap: (){
                  Fluttertoast.showToast(msg: '회원 탈퇴');
                },
                child:Text('회원 탈퇴',style: Theme.of(context).textTheme.headline4)),
            ]))
    );
  }
  GestureDetector _profileLayout(){
    return GestureDetector(
      onTap: (){
        Fluttertoast.showToast(msg: '사진 등록');
      },
      child: SizedBox(width: 80,height: 80,
          child: Stack(children: [
            CircleAvatar(
                backgroundImage: AssetImage(accountTest['profileImage']!),
                backgroundColor: const Color(0xFFF0F0F0),
                radius: 100),
            Positioned(bottom: 5, right: 10,child: Container(
              color: const Color(0x55000000),
              child: const Icon(Icons.content_cut,color: Colors.white,size: 18,),
            )),
          ])),
    );
  }
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '환경설정'),
        body:Container(
            margin: const EdgeInsets.all(12),
            child:ListView(physics: const BouncingScrollPhysics(),children: [
              Text('알림',style: Theme.of(context).textTheme.subtitle1),
              Row(children: [Text(' push 알림',style: Theme.of(context).textTheme.headline5),SettingSwitch('전체알림')],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              Row(children: [Text('  이벤트 알림 수신',style: Theme.of(context).textTheme.headline5),SettingSwitch('이벤트알림')],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              Row(children: [Text('  공지 알림 수신',style: Theme.of(context).textTheme.headline5),SettingSwitch('공지알림')],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              Row(children: [Text('  소리',style: Theme.of(context).textTheme.headline5),SettingSwitch('소리알림')],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              Row(children: [Text('  진동',style: Theme.of(context).textTheme.headline5),SettingSwitch('진동알림')],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
              const SizedBox(height: 30),
              Text('기타',style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height:10),
              GestureDetector(
                onTap: (){
                  Fluttertoast.showToast(msg: '로그아웃');
                },child: Text(' 로그아웃',style: Theme.of(context).textTheme.headline5)
              ),
              const SizedBox(height:10),
              GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(msg: '최신버전입니다?');
                  },child: Text(' 버전:${1.1234}',style: Theme.of(context).textTheme.headline5)
              ),

            ])));
  }
}
class SettingSwitch extends StatefulWidget {
  String name;
  SettingSwitch(this.name);

  @override
  _SettingSwitchState createState() => _SettingSwitchState();
}

class _SettingSwitchState extends State<SettingSwitch> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
    );
  }
}

class MyActivity extends StatelessWidget {
  TabBar tabBar = const TabBar(
      indicatorColor: Color(0xca000000),
      labelColor: Color(0xca000000),
      unselectedLabelColor: Color(0xFd333333),
      unselectedLabelStyle: TextStyle(fontSize:20,fontWeight: FontWeight.w100),
      labelStyle: TextStyle(fontSize:20,fontWeight: FontWeight.w700),
      tabs: [
        Text('내가 쓴 리뷰'),
        Text('찜한 식당'),
      ]);

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '내 활동', bottom: tabBar),
            body: TabBarView(physics: const BouncingScrollPhysics(),children: [ MyReview(),MyHouse()])
        ));
  }
}

class MyReview extends StatefulWidget {
  @override
  _MyReviewState createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {

  List<Widget> test = [
    MyReviewContainer('가나다라식당',DateTime.now(),'가나다라'),
    MyReviewContainer('병천순대',DateTime.now(),'긴 글자만 있을 경우 \n 제3항의 승인을 얻지 못한 때에는 그 처분 또는 명령은 그때부터 효력을 상실한다. 이 경우 그 명령에 의하여 개정 또는 폐지되었던 법률은 그 명령이 승인을 얻지 못한 때부터 당연히 효력을 회복한다. 모든 국민은 거주·이전의 자유를 가진다. 지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 국가는 대외무역을 육성하며, 이를 규제·조정할 수 있다. 국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경 제의 발전에 노력하여야 한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 제1항의 탄핵소추는 국회재적의원 3분의 1 이상의 발의가 있어야 하며, 그 의결은 국회재적의원 과반수의 찬성이 있어야 한다. 다만, 대통령에 대한 탄핵소추는 국회재적의원 과반수의 발의와 국회재적의원 3분의 2 이상의 찬성이 있어야 한다.'),
    MyReviewContainer('전주명가 콩나물국밥?',DateTime.now(),'짧은 글자들\n 및 엔터키'),
    MyReviewContainer('가나다라식당',DateTime.now(),'가나다라'),
    MyReviewContainer('병천순대',DateTime.now(),'긴 글자만 있을 경우 \n 제3항의 승인을 얻지 못한 때에는 그 처분 또는 명령은 그때부터 효력을 상실한다. 이 경우 그 명령에 의하여 개정 또는 폐지되었던 법률은 그 명령이 승인을 얻지 못한 때부터 당연히 효력을 회복한다. 모든 국민은 거주·이전의 자유를 가진다. 지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 국가는 대외무역을 육성하며, 이를 규제·조정할 수 있다. 국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경 제의 발전에 노력하여야 한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 제1항의 탄핵소추는 국회재적의원 3분의 1 이상의 발의가 있어야 하며, 그 의결은 국회재적의원 과반수의 찬성이 있어야 한다. 다만, 대통령에 대한 탄핵소추는 국회재적의원 과반수의 발의와 국회재적의원 3분의 2 이상의 찬성이 있어야 한다.'),
    MyReviewContainer('전주명가 콩나물국밥?',DateTime.now(),'짧은 글자들\n 및 엔터키'),
    MyReviewContainer('가나다라식당',DateTime.now(),'가나다라'),
    MyReviewContainer('병천순대',DateTime.now(),'긴 글자만 있을 경우 \n 제3항의 승인을 얻지 못한 때에는 그 처분 또는 명령은 그때부터 효력을 상실한다. 이 경우 그 명령에 의하여 개정 또는 폐지되었던 법률은 그 명령이 승인을 얻지 못한 때부터 당연히 효력을 회복한다. 모든 국민은 거주·이전의 자유를 가진다. 지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 국가는 대외무역을 육성하며, 이를 규제·조정할 수 있다. 국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경 제의 발전에 노력하여야 한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 제1항의 탄핵소추는 국회재적의원 3분의 1 이상의 발의가 있어야 하며, 그 의결은 국회재적의원 과반수의 찬성이 있어야 한다. 다만, 대통령에 대한 탄핵소추는 국회재적의원 과반수의 발의와 국회재적의원 3분의 2 이상의 찬성이 있어야 한다.'),
    MyReviewContainer('전주명가 콩나물국밥?',DateTime.now(),'짧은 글자들\n 및 엔터키'),
    MyReviewContainer('가나다라식당',DateTime.now(),'가나다라'),
    MyReviewContainer('병천순대',DateTime.now(),'긴 글자만 있을 경우 \n 제3항의 승인을 얻지 못한 때에는 그 처분 또는 명령은 그때부터 효력을 상실한다. 이 경우 그 명령에 의하여 개정 또는 폐지되었던 법률은 그 명령이 승인을 얻지 못한 때부터 당연히 효력을 회복한다. 모든 국민은 거주·이전의 자유를 가진다. 지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 국가는 대외무역을 육성하며, 이를 규제·조정할 수 있다. 국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경 제의 발전에 노력하여야 한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 제1항의 탄핵소추는 국회재적의원 3분의 1 이상의 발의가 있어야 하며, 그 의결은 국회재적의원 과반수의 찬성이 있어야 한다. 다만, 대통령에 대한 탄핵소추는 국회재적의원 과반수의 발의와 국회재적의원 3분의 2 이상의 찬성이 있어야 한다.'),
    MyReviewContainer('전주명가 콩나물국밥?',DateTime.now(),'짧은 글자들\n 및 엔터키'),
  ];
@override
  void initState() {
    test.insert(0, Text('   총 리뷰 수 : ${test.length}',style:const TextStyle(color: Colors.grey, fontSize: 18,height: 2)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  test[0] = Text('   총 리뷰 수 : ${test.length}',style:const TextStyle(color: Colors.grey, fontSize: 18,height: 2));
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: test.length,
        separatorBuilder: (context, index){
          return const Divider();
        },
        itemBuilder: (context, index){
          return test[index];
        });
  }
}
class MyHouse extends StatefulWidget {
  @override
  _MyHouseState createState() => _MyHouseState();
}

class _MyHouseState extends State<MyHouse> {
  List<Widget> test = [
    InfoHouse('24시 전주 명가 콩나물국밥 강릉점',true,category: '한식',heart: '♥', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
    InfoHouse('강릉 육사시미',true,category: '한식',heart: '♥', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
    InfoHouse('24시 전주 명가 콩나물국밥 강릉점',true,category: '한식',heart: '♥', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
    InfoHouse('강릉 육사시미',true,category: '한식',heart: '♥', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
    InfoHouse('24시 전주 명가 콩나물국밥 강릉점',true,category: '한식',heart: '♥', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
    InfoHouse('강릉 육사시미',true,category: '한식',heart: '♥', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
    InfoHouse('24시 전주 명가 콩나물국밥 강릉점',true,category: '한식',heart: '♥', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
    InfoHouse('강릉 육사시미',true,category: '한식',heart: '♥', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: test.length,
        itemBuilder: (context, index){
          return Container(margin: const EdgeInsets.all(10),child:test[index]);
        });
  }
}

class Notice extends StatelessWidget {
  List<Widget> test = [
    NoticeTile('리뷰 이벤트 당첨자 발표','보이는 것은 거친 모래뿐일 것이다 이상의 꽃이 없으면 쓸쓸한 인간에 남는 것은 영락과 부패 뿐이다 낙원을 장식하는 천자만홍이 어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는 무엇을 위하여 설산에서 고행을 하였으며 예수는 무엇을 위하여 광야에서 방황하였으며 공자는 무엇을 위하여 천하를 ',
        '${2021}-${11}-${19}',false),
    NoticeTile('리뷰 이벤트 안내','굳세게 살 수 있는 것이다 석가는 무엇을 위하여 설산에서 고행을 하였으며 예수는 무엇을 위하여 광야에서 방황하였으며 공자는 무엇을 위하여 천하를 철환하였는가? 밥을 위하여서 옷을 위하여서 미인을 구하기',
        '${2021}-${11}-${19}',false),
    NoticeTile('일부 서비스 중단 안내','도 보이는 것은 거친 모래뿐일 것이다 이상의 꽃이 없으면 쓸쓸한 인간에 남는 것은 영락과 부패 뿐이다 낙원을 장식하는 천자만홍이 어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이',
        '${2021}-${11}-${19}',false),
    NoticeTile('개인정보 처리 방침 개정에 따른 안내 사항을 알려드립니다.','을 장식하는 천자만홍이 어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는 무엇을 위하여 설산에서 고행을 하였으며 예수는 무엇을 위하여 광야에서 방황하였으며 공자는 무엇을 위하여 천하를 철환하였는가? 밥을 위하여서 옷을 위하여서 미인을 구하기 위하여서 그리하였는가? 아니다 그들은 커다란 이상 곧 만천하의 대중을\n\n\n\n아니한 목숨을 사는가 싶이 살았으며 그들의 그림자는 천고에 사라지지 않는 것이다 이것은 현저하게 일월과 같은 예가 되려니와 그',
        '${2021}-${11}-${19}',false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '공지사항'),
        body:ListView.separated(
            physics: const BouncingScrollPhysics(),
          itemCount: test.length,
          separatorBuilder: (context, index){return Divider();},
          itemBuilder: (context, index){
            return test[index];
          }
        ));
  }
}

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferredSize tabBar = PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        color: Colors.white,
        height: 40,
        child: const TabBar(
            indicatorColor: Color(0xca000000),
            labelColor: Color(0xca000000),
            unselectedLabelColor: Color(0xca666666),
            tabs: [
              Text('문의하기', style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
              Text('문의내역', style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
              Text('FAQ', style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600))
            ]
        ),
      ),
    );

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '문의하기',bottom: tabBar),
            body: TabBarView(physics: const BouncingScrollPhysics(),
                children: [
              QuestionReport(),MyQuestion(),FAQ(),
            ])
        ));
  }
}
class QuestionReport extends StatefulWidget {
  @override
  _QuestionReportState createState() => _QuestionReportState();
}

class _QuestionReportState extends State<QuestionReport> {
  String? _selectedCategory;
  bool emailReceive = false;
  bool checkTerm = false;
  bool openTerm = false;
  SizedBox? marginBottom;

  @override
  Widget build(BuildContext context) {
    marginBottom = SizedBox(height: MediaQuery.of(context).size.height < 700 ? 20 : MediaQuery.of(context).size.height - 697);
    return ListView(
        physics: const BouncingScrollPhysics(),
          children: [
            Container(margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Row(children: [
              Expanded(flex: 1, child: getTitleText('분류')),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(flex:4, child: DropdownButton(
                value: _selectedCategory,
                hint: const Text('분류 선택'),
                style: const TextStyle(fontSize: 20,color: Colors.black),
                isExpanded: true,
                items: DataList.questionCategory.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value as String;
                  });},
              )),
            ]),
            const SizedBox(height:8),
            Row(children: [
              Expanded(flex: 1,child: getTitleText('제목')),
              const Expanded(flex: 1,child: SizedBox()),
              Expanded(flex: 4,child: CustomTextField.normalInput(
                hint: '제목을 입력해주세요.',fillColor: 0xFFF6F6F6,inputColor: Colors.black
              )),
            ]),
            getTitleText('문의 내용'),
            const SizedBox(height:8),
            CustomTextField.textInput(minLines: 4,fillColor: 0xFFF8F8F8),
            Row(children: [getTitleText('첨부파일'),const Expanded(child: SizedBox()),imageUploadLayout(),imageUploadLayout(),imageUploadLayout()]),
            Row(children:const [Expanded(child:SizedBox()),Text('이미지는 최대 3장까지 업로드 가능합니다.', style: TextStyle(fontSize: 14,color: Colors.grey),textAlign: TextAlign.end,)]),
            const SizedBox(height:12),
            Row(children: [
              getTitleText('약관 동의'),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary:Color(checkTerm ? 0xFC2296F3 : 0xFFF0F0F0),padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2)
                ),onPressed: (){
                  setState(() {
                    checkTerm = !checkTerm;
                  });
              }, child: Row(children:[Text('개인정보 수집 및 이용 동의 ',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Color(checkTerm ? 0xFFFFFFFF : 0xFF000000),height: 1.1),),
                  Icon(checkTerm ? Icons.check_box : Icons.check_box_outline_blank,size: 20,color: checkTerm ? null : Colors.black)
              ]))
            ]),
            InkWell(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    const Text('개인정보 수집 및 이용 동의 내용보기', style: TextStyle(fontSize: 14,color: Colors.grey)),
                    Icon(openTerm ? Icons.arrow_drop_up : Icons.arrow_drop_down)
                  ]),
              onTap: (){
                setState(() {
                  openTerm = !openTerm;
                });
              },
            ),
            Container(child:!openTerm ? null :
                Container(
                  padding: const EdgeInsets.all(15),
                  color: const Color(0xFFF0F0F0),
                  child: const Text('것은 거친 모래뿐일 것이다 이상의 꽃이 없으면 쓸쓸한 인간에 남는 것은 영락과 부패 뿐이다 낙원을 장식하는 천자만홍이 어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는 무엇을 위하여 설산에서 고행을 하였으며 예수는 무엇을 위하여 광야에서 방황하였으며 공자는 무엇을 위하여 천하를 철환하였는가? 밥을 위하여서 옷을 위하여서 미인을 구하기 위하여서 그리하였는가? 아니다 그들은 커다란 이상 곧 만천하의 대중을 품에 안고 그들에게 밝은 길을 찾아',
                    style: TextStyle(fontSize: 15,color: Colors.black)
                  )
                )
            ),
          ])),
    marginBottom!,
    Row(children: [
    Expanded(child: InkWell(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    color: const Color(0xFFF0F0F0),
    child: Center(child: getTitleText('취소'))
    ),onTap: (){
    Fluttertoast.showToast(msg: '취소 버튼');
    })),
    Expanded(child: InkWell(child:Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    color: const Color(0xFF2ECC71),
    child: Center(child: getTitleText('작성 완료'))
    ),onTap: (){
    Fluttertoast.showToast(msg: '작성 버튼');
    })),
    ])
          ]);
  }
  Text getTitleText(String title) {
    return Text(title,style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold));
  }
  InkWell imageUploadLayout(){
    return InkWell(child:Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(15),
      margin:  const EdgeInsets.all(6),
      child: const Center(child: Icon(Icons.camera_alt,size: 25 ))
    ),onTap: (){
      Fluttertoast.showToast(msg: '이미지 업로드 버튼 ');
    });
  }
}




class MyQuestion extends StatelessWidget {
  List<Widget> test =  [
    NoticeTile('이벤트 관련 문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
        '${2021}-${11}-${19}',false),
    NoticeTile('버그 관련 문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
        '${2021}-${11}-${19}',false),
    NoticeTile('개인정보 관련 문의 개인 정보 관련 문의 개인정보관련문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
        '${2021}-${11}-${19}',false,answer: NoticeTile('개인정보 관련 문의','어디 있으며 인생을 풍부하게 하는 온갖 과실이 어디 있으랴? 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다 사람은 크고 작고 간에 이상이 있음으로써 용감하고 굳세게 살 수 있는 것이다 석가는',
            '${2021}-${11}-${19}',true)),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: test.length,
          separatorBuilder: (context,index){
            return const Divider();
          },itemBuilder: (context,index){
        return test[index];
      })
    );
  }
}

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List category = ['계정','이용문의','불편문의','정보등록','기타'];
  int select = 0;
  bool isSearchMode = false;


  Map<String,List<List<String>>> test = {
    '계정':[
      ['계정','것이다 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 창공에 반짝이는 뭇 별과 같이 산야'],
      ['asdf','는 소금이라 할지니 인생에 가치를 주는 원질이 되는 것이다 그들은 앞이 긴지라 착목한는 곳이'],
    ],
    '이용문의':[
      ['이용문의에 관해서','꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다 보이는 끝까지 찾아다녀도 목숨이 있는 때까지 방황하여도 보이는 것은 거친 모래뿐일 것이다 이상의 꽃이 없으면 쓸쓸한 인간에 남는 것은 영락과 부패 뿐이다 낙원을 장식하는 천자만홍이 어디 있으며 인생을 풍부하게 '],
    ],
    '불편문의':[
      ['불편사항','ㅁㄹ'],['불편사항','ㅁㄹ'],['불편사항','ㅁㄹ'],['불편사항','ㅁㄹ'],['불편사항','ㅁㄹ'],['불편사항','ㅁㄹ'],['불편사항','ㅁㄹ'],
    ],
    '정보등록':[
      ['정','ㅁㄴㅊㅁㅇㅁㅇㄹㅇㄴㅍㅇㄹㄴㅁㄹㅇㄼㄷㅈ'],['보','ㅊㅁㅋㅌㅌㅋㅊㅍㄴㅇㄹ퓽ㄴㅇㅍㄴㅍㅊㅌㅊㅌㅍ'],['등','gcfhujilbhgjkihjgjugcgfyhu'],['록','jbhxgtyjkg,kutyjgu67f576885645768'],
    ],
    '기타':[
      ['기타','배우고싶다']
    ]
  };

  List<Widget> a = [];
  @override
  void initState() {
    for(int i=0;i<test[category[select]]!.length;i++){
      a.add(NoticeTile(test[category[select]]![i][0],test[category[select]]![i][1],'',false));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Container gridCategory = Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        margin: const EdgeInsets.only(bottom: 15),
        color: const Color(0xcacacaca),
        child: isSearchMode ? null : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2/1,
          ),itemCount: category.length+1,
            itemBuilder: (context, index){
              if(category.length <= index) return Container(color: Colors.white,margin: const EdgeInsets.all(1));
              return getGridItem(index, index == select);
            })
    );

    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: test[category[select]]!.length+2,
        separatorBuilder: (context,index){
          if(index < 2) return const SizedBox();
          return const Divider();
        },itemBuilder: (context,index){
          if(index == 0 ) return CustomTextField.normalInput(hint: '검색 내용 입력(제목 or 내용)',prefixIcon: const Icon(Icons.search),fillColor: 0xFCFCFCFC,onSubmited: searchSubmit);
          if(index == 1) return gridCategory;
          return a[index-2];
    });
  }
  Container getGridItem(int index,bool isSelected) {
    return Container(
      color: Color(isSelected ? 0xFFffeb56 : 0xFFFFFFFF),
      margin: const EdgeInsets.all(1),
      child: InkWell(
        onTap: (){
          if(index != select) {
            setState(() {
              select = index;
              a = [];
              for(int i=0;i<test[category[select]]!.length;i++){
                a.add(NoticeTile(test[category[select]]![i][0],test[category[select]]![i][1],'',false,sureFold: true,));
              }
              Fluttertoast.showToast(msg: '${category[index]} 카테고리 선택');
            });
          }
        },
        child: Center(child: Text(category[index]))
      ));
  }

  void searchSubmit(String str) {
    if(isSearchMode == false){
      setState(() {
        isSearchMode = true;
      });
    }
    Fluttertoast.showToast(msg: '검색 : $str');
  }
}
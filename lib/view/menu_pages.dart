import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/model/enum.dart';
import 'package:eating_alone/model/model.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:eating_alone/view/layouts/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layouts/area_setting.dart';
import 'layouts/info_house.dart';
import 'layouts/inputfield.dart';
import 'layouts/loading.dart';
import 'layouts/my_review.dart';
import 'layouts/notice_tile.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'main_app.dart';

class AccountInfo extends StatelessWidget {
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
                  Text(context.watch<UserProvider>().getNickName,style: Theme.of(context).textTheme.headline3),
                ],crossAxisAlignment: CrossAxisAlignment.start,))
              ]),
              const SizedBox(height: 30),
              Text('검색 지역',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              AreaSetting(),
              const SizedBox(height: 30),
              Text('닉네임 변경',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              CustomTextField.normalInput(hint:context.watch<UserProvider>().getNickName,fillColor: 0xFdF0F0F0,onSubmited: (String text){
                if(text.isEmpty){
                  Fluttertoast.showToast(msg: '변경할 닉네임을 입력해주세요.');
                  return;
                }else if(text.length > 20){
                  Fluttertoast.showToast(msg: '닉네임은 20글자까지 가능합니다.');
                  return;
                }
                User user = User();
                user.setId(context.read<UserProvider>().getId);
                user.setNickName(text);
                UserQuery(user).updateName(text).then((response) {
                  if(response.isEmpty){
                    SharedPreferences.getInstance().then((storage){
                      storage.setString('nickName', text);
                      Fluttertoast.showToast(msg: '변경되었습니다.');
                      context.read<UserProvider>().setNickName = text;
                  });
                  }else{
                    Fluttertoast.showToast(msg: response);
                  }
                });
              }),
              const SizedBox(height: 30),
              Text('현재 비밀번호',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              CustomTextField.passwordInput(label: '',controller: ctrOld),
              const SizedBox(height: 20),
              Text('신규 비밀번호',style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1)),
              CustomTextField.passwordInput(label: '',controller: ctrNew),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: (){
                    if(ctrOld.text.isEmpty){
                      Fluttertoast.showToast(msg: '현재 비밀번호를 입력해주세요.');
                    }else if(ctrNew.text.isEmpty){
                      Fluttertoast.showToast(msg: '변경할 비밀번호를 입력해주세요.');
                    }else{
                      User user = User();
                      user.setId(context.read<UserProvider>().getId);
                      user.setPassword(ctrOld.text);
                      UserQuery(user).updatePwd(ctrNew.text).then((response) {
                        if(response.isEmpty){
                          SharedPreferences.getInstance().then((storage){
                            storage.setString('password', ctrNew.text);
                            Fluttertoast.showToast(msg: '변경되었습니다.');
                            ctrOld.text = "";
                            ctrNew.text = "";
                          });
                        }else{
                          Fluttertoast.showToast(msg: response);
                        }
                      });
                    }},
                    child: const Text('저장'))]),
              const Divider(height: 40,color: Colors.black54),
              GestureDetector(onTap: (){
                    context.read<UserProvider>().logout();
                    SharedPreferences.getInstance().then((storage){
                      storage.setString('id','anonymous');
                      storage.remove('password');
                      storage.remove('nickName');
                    });
                    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainSelect()),(route) => false);
                  },
                child:Text('로그아웃',style: Theme.of(context).textTheme.headline4)),

              GestureDetector(onTap: (){
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return accountOutDialog(TextEditingController(), context);});
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
                backgroundImage: AssetImage('assets/images/defaultProfile.png'),
                backgroundColor: const Color(0xFFF0F0F0),
                radius: 100),
            Positioned(bottom: 5, right: 10,child: Container(
              color: const Color(0x55000000),
              child: const Icon(Icons.content_cut,color: Colors.white,size: 18,),
            )),
          ])),
    );
  }
  AlertDialog accountOutDialog(TextEditingController ctr, BuildContext context){
    return AlertDialog(
        title: const Text("탈퇴하시겠습니까?"),
        content: CustomTextField.passwordInput(controller: ctr),
        actions: <Widget>[
          TextButton(onPressed: (){
            if(ctr.text.isEmpty){
              Fluttertoast.showToast(msg: "비밀번호를 입력해주세요.");
            }else{
              User user = User();
              user.setId(context.read<UserProvider>().getId);
              user.setPassword(ctr.text);
              UserQuery(user).accoutOut().then((response) {
                if(response.isEmpty){
                  context.read<UserProvider>().logout();
                  SharedPreferences.getInstance().then((storage){
                    storage.remove('id');
                    storage.remove('password');
                    storage.remove('nickName');
                  });
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainSelect()),(route) => false);
                }else{
                  Fluttertoast.showToast(msg: response);
                }
              });
            }
          }, child: const Text("예")),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("아니오")),
        ]);
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

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  List<Widget> tiles = [];

  @override
  Widget build(BuildContext context) {
    if(tiles.isEmpty) {
      getData();
    }
    return Scaffold(
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '공지사항'),
        body: tiles.isEmpty ? const Center(child: CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent)) : ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: tiles.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index){
          return tiles[index];
        }
    ));
  }
  void getData(){
    QuestionNotice().notice().then((response) {
      List<Widget> cache = [];
      for(Map value in response){
        cache.add(NoticeTile(value['head'],value['body'], value['time'],false));
      }
      setState(() {
        tiles = cache;
      });
    });
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
                  context.read<UserProvider>().getId == "anonymous" ? anonymousLayout(context) : QuestionReport(),
                  context.read<UserProvider>().getId == "anonymous" ? anonymousLayout(context) : MyQuestion(),
                  FAQ(),
            ])
        ));
  }
  Widget anonymousLayout(BuildContext context){
    return  Center(child: TextButton(child: const Text("로그인 이후 사용가능합니다.",style: TextStyle(fontSize: 18)),onPressed:  (){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPage()));
    },));
  }
}
class QuestionReport extends StatefulWidget {
  @override
  _QuestionReportState createState() => _QuestionReportState();
}

class _QuestionReportState extends State<QuestionReport> {
  String? _selectedCategory;
  bool checkTerm = false;
  bool openTerm = false;
  SizedBox? marginBottom;
  TextEditingController headCtr = TextEditingController();
  TextEditingController bodyCtr = TextEditingController();

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
//            Row(children: [
//              Expanded(flex: 1,child: getTitleText('제목')),
//              const Expanded(flex: 1,child: SizedBox()),
//              Expanded(flex: 4,child: CustomTextField.normalInput(
//                hint: '제목을 입력해주세요.',fillColor: 0xFFF6F6F6,inputColor: Colors.black,controller: headCtr
//              )),
//            ]),
            getTitleText('제목'),
            const SizedBox(height:8),
            CustomTextField.normalInput(
                hint: '제목을 입력해주세요.',fillColor: 0xFFF6F6F6,inputColor: Colors.black,controller: headCtr
              ),
            getTitleText('문의 내용'),
            const SizedBox(height:8),
            CustomTextField.textInput(hint:'내용을 입력해주세요.',minLines: 4,fillColor: 0xFFF8F8F8,controller: bodyCtr),
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
    questionSubmit();
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

  void questionSubmit(){
    if(headCtr.text.isEmpty || bodyCtr.text.isEmpty || _selectedCategory == null){
      Fluttertoast.showToast(msg: "내용을 모두 입력해주세요.");
    }else if(!checkTerm){
      Fluttertoast.showToast(msg: "개인정보 이용 약관에 동의해주세요.");
    }else{
      LoadingDialog(context);
      QuestionNotice().qna(headCtr.text,bodyCtr.text,_selectedCategory!,context.read<UserProvider>().getId).then((value) {
        if(value.isEmpty){
          setState(() {
            headCtr.text = "";
            bodyCtr.text = "";
            checkTerm = false;
            _selectedCategory = null;
            Fluttertoast.showToast(msg: "성공적으로 전달되었습니다.");
          });
        }else{
          Fluttertoast.showToast(msg: value);
        }
        Navigator.pop(context);
      });
    }
  }
}



class MyQuestion extends StatefulWidget {
  @override
  _MyQuestionState createState() => _MyQuestionState();
}

class _MyQuestionState extends State<MyQuestion> with AutomaticKeepAliveClientMixin {
  List<Widget> data = [];

  @override
  Widget build(BuildContext context) {
    if(data.isEmpty){
      getData();
    }
    return data.isEmpty ? const Center(child: CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent)) :
      Container(
        margin: const EdgeInsets.only(top: 10),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (context,index){
              return const Divider();
            },itemBuilder: (context,index){
          return data[index];
        })
    );
  }
  void getData(){
    QuestionNotice().myQuestionList(context.read<UserProvider>().getId).then((value) {
      setState(() {
        for(Map val in value){
          bool addAnswer = val['answer'].isNotEmpty;
          NoticeTile? answer = addAnswer ? NoticeTile('',val['answer'],'',true) : null;
          data.add(
            NoticeTile(val['head'],val['body'],val['time'],addAnswer, answer:answer)
          );
        }

      });
    });
  }
  @override
  bool get wantKeepAlive => true;
}

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> with AutomaticKeepAliveClientMixin {
  List category = DataList.questionCategory;
  int select = 0;
  Map<String,List<List<String>>> data= {};



  @override
  Widget build(BuildContext context) {
    if(data.isEmpty){
      getData();
    }
    Container gridCategory = Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        margin: const EdgeInsets.only(bottom: 15),
        color: const Color(0xcacacaca),
        child: GridView.builder(
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
    return Column(
      children: [
        gridCategory,
        data.isEmpty ? const Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent))) :
        FAQList(data[category[select]]!)
      ]
    );
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
            });
          }
        },
        child: Center(child: Text(category[index]))
      ));
  }
  void getData(){
    QuestionNotice().faq().then((response){
      setState(() {
        for(String value in category){
          data[value] = [];
        }
        for(Map value in response){
            data[value['category']]!.add([value['head'], value['body']]);
        }
      });
    });
  }
  @override
  bool get wantKeepAlive => true;
}


class FAQList extends StatelessWidget{
  List<List<String>> tiles;
  FAQList(this.tiles);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount:tiles.length,
        separatorBuilder: (context,index){
          return const Divider();
        },itemBuilder: (context,index){
          return NoticeTile(tiles[index][0],tiles[index][1],'',false);
    });
  }
}

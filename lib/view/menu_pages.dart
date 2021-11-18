import 'package:eating_alone/model/enum.dart';
import 'package:eating_alone/view/layouts/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'layouts/area_setting.dart';
import 'layouts/inputfield.dart';


class AccountInfo extends StatelessWidget {
  Map<String,String> accountTest = {
    'name':'이제일',
    'id':'dlwpdlf147@naver.com',
    'area':'강릉',
    'profileImage':'assets/images/defaultProfile.png'
  };
  TextEditingController ctrOld = TextEditingController();
  TextEditingController ctrNew = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '계정 정보'),
        body:Container(margin: const EdgeInsets.all(12),child:ListView(
            children: [
              Row(children: [
                _profileLayout(),
              const SizedBox(width: 20),
              Expanded(child: Column(children: [
                Text(accountTest['name']!,style: Theme.of(context).textTheme.headline3),
                Text(accountTest['id']!,style: Theme.of(context).textTheme.subtitle1),
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
            Row(mainAxisAlignment: MainAxisAlignment.end,
    children: [ElevatedButton(onPressed: (){Fluttertoast.showToast(msg: '비번변경');}, child: const Text('저장'))]
    ),
    const SizedBox(height: 30),

            GestureDetector(onTap: (){
              Fluttertoast.showToast(msg: '회원 탈퇴');
            },child:Text('회원 탈퇴',style: Theme.of(context).textTheme.headline4)),
          ]))
    );
  }
  GestureDetector _profileLayout(){
    return GestureDetector(
      onTap: (){
        Fluttertoast.showToast(msg: '사진 등록');
      },
      child: SizedBox(width: 60,height: 60,
          child: Stack(children: [
            CircleAvatar(
                backgroundImage: AssetImage(accountTest['profileImage']!),
                backgroundColor: const Color(0xFFF0F0F0),
                radius: 100),
            Positioned(bottom: 4, right: 4,child: Container(
              color: const Color(0x55000000),
              child: const Icon(Icons.content_cut,color: Colors.white,size: 18,),
            )),
          ])),
    );
  }
}

class AccountSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, '환경설정'),
        body:Container(
            margin: const EdgeInsets.all(12),
            child:ListView(children: [
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

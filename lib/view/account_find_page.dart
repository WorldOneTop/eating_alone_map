import 'package:flutter/material.dart';
import './layouts/inputfield.dart';

class AccountFindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFffeb56),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('회원 찾기', style: Theme.of(context).textTheme.headline2!),
                  const SizedBox(height: 50),
                  Text('가입한 이메일을 통해 \n초기화된 비밀번호를 보내드립니다.',
                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.blue[400])),
                  const SizedBox(height: 20),
                  SendEmail(),
                  const SizedBox(height: 100),
                ])
        )
    );
    //아이디가 이메일이고 특별한 정보가 없으니 비밀번호만 찾을수있게끔
  }
}

class SendEmail extends StatefulWidget {
  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  String? exist;
  Text? isSend;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomTextField.idInput(hint: '가입한 email',label: 'EMAIL',error: exist, enable: isSend == null),
      ElevatedButton(onPressed: isSend != null ? null :checkEmail, child: const Text('발송')),
      Container(child: isSend)
    ]);
  }

  void checkEmail() {
    //if 해당 이메일 유저 없음
    setErrorMsg();
    //else
    successSend();
  }
  void setErrorMsg() {
    setState(() {
      exist = '존재하지 않는 이메일입니다.';
    });
  }

  void successSend() {
    setState(() {
      exist = null;
      isSend = const Text('이메일을 확인해주세요.',style: TextStyle(color: Colors.red),);
    });
  }
}

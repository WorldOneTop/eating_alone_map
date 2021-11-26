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
                  Text('가입한 휴대폰 번호를 통해 \n초기화된 비밀번호를 보내드립니다.',
                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.blue[400])),
                  const SizedBox(height: 20),
                  SendEmail(),
                  const SizedBox(height: 100),
                ])
        )
    );
  }
}

class SendEmail extends StatefulWidget {
  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  String? exist;
  Text? isSend;
  String idPattern = r'^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$';
  TextEditingController ctr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomTextField.idInput(hint: '휴대폰 번호를 - 없이 입력해주세요.',label: 'PHONE NUMBER',error: exist, enable: isSend == null,controller: ctr),
      ElevatedButton(onPressed: isSend != null ? null :checkEmail, child: const Text('발송')),
      Container(child: isSend)
    ]);
  }

  void checkEmail() {
    setState(() {
      if(!RegExp(idPattern).hasMatch(ctr.text)){
        exist = '휴대폰 번호 형식으로 입력해주세요.';
      }else{
        exist = null;
        isSend = const Text('문자를 확인해주세요.',style: TextStyle(color: Colors.red),);
        }
      });
  }
}

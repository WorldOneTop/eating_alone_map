import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './layouts/export_all.dart';

class SignupPage extends StatelessWidget {
  TextEditingController ctr1 = TextEditingController();
  TextEditingController ctr2 = TextEditingController();
  TextEditingController ctr3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFffeb56),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('회원가입', style: Theme.of(context).textTheme.headline2!),
                  const SizedBox(height: 50),
                  CheckEmail(ctr1,ctr2),
                  const SizedBox(height: 30),
                  CustomTextField.passwordInput(),
                  const SizedBox(height: 40),
                  ElevatedButton(onPressed: signupCheck, child: const Text('가입하기',style:TextStyle(fontSize: 20))),
                  const SizedBox(height: 100),
                ])
        )
    );
  }

  void signupCheck() {
    Fluttertoast.showToast(msg: "가입 성공");
  }
}

class CheckEmail extends StatefulWidget {
  TextEditingController ctr1,ctr2;
  CheckEmail(this.ctr1, this.ctr2);

  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  String? idError;
  bool idLock = false,numberLock = false;
  String idPattern = r'^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(child:CustomTextField.idInput(hint:'번호를 - 없이 입력해주세요.',label: 'PHONE NUMBER',controller: widget.ctr1,
        error: idError, enable: !idLock)),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: idLock ? null : checkNumber, child: const Text('발송')),
      ]),
      const SizedBox(height: 5),
      Row(children: [
        Expanded(
          child: CustomTextField.normalInput(hint:'인증 번호 입력',controller: widget.ctr2,enable: numberLock),
        ),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: numberLock ? null : sendNumber, child: const Text('확인')),
      ])
    ]);
  }

  void checkNumber() {

    setState(() {
      if(!RegExp(idPattern).hasMatch(widget.ctr1.text)){
        idError = '휴대폰 번호 형식으로 입력해주세요.';
      }else{
        idError = null;
        idLock = true;
        Fluttertoast.showToast(msg: "인증 번호를 발송하였습니다.");
      }
//      successCheck = true;
    });
  }
  void sendNumber() {
    Fluttertoast.showToast(msg: "인증에 성공하였습니다.");
    setState(() {
//      successSend = true;
    });
  }
}

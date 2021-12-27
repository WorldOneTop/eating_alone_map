import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/controller/signup_api.dart';
import 'package:eating_alone/model/model.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './layouts/export_all.dart';
import 'main_app.dart';
import 'package:provider/provider.dart';


class SignupPage extends StatelessWidget {
  TextEditingController ctr1 = TextEditingController(); // id
  TextEditingController ctr2 = TextEditingController(); // checkNum
  TextEditingController ctr3 = TextEditingController(); // nickName
  TextEditingController ctr4 = TextEditingController(); // pwd
  BuildContext? _context;
  SMS? sms;
  CheckEmail? checkEmail;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    _context = context;
    sms = SMS((msg){
      if(msg.message == 'success'){
        Fluttertoast.showToast(msg: "인증에 성공하였습니다.");
        context.read<SMSResponse>().setIsComplete = true;
        isComplete = true;
      }else if(msg.message == 'fail'){
        Fluttertoast.showToast(msg: "인증번호가 일치하지않습니다.");
      }else if(msg.message == 'error'){
        Fluttertoast.showToast(msg: "오류가 발생했습니다. 잠시 후 시도해주세요.");
      }else if(msg.message == 'pass'){
        // 리캡챠 통과
      }
    });
    checkEmail = CheckEmail(ctr1,ctr2,sms!);

    return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFFffeb56),
          body: ListView(
              physics: const BouncingScrollPhysics(),children: [Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('회원가입', style: Theme.of(context).textTheme.headline2!),
              const SizedBox(height: 50),
              checkEmail!,
              const SizedBox(height: 30),
              CustomTextField.normalInput(hint: "닉네임",controller: ctr3,inputColor: Colors.black),
              const SizedBox(height: 20),
              CustomTextField.passwordInput(controller: ctr4),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: signupCheck, child:const Text('가입하기',style:TextStyle(fontSize: 20))),
              const SizedBox(height: 100),
              sms!,
              ])
      )])
    );
  }

  void signupCheck() {
    if(!isComplete){
      Fluttertoast.showToast(msg: "휴대폰 인증을 완료해주세요.");
    }else if(ctr3.text.isEmpty){
      Fluttertoast.showToast(msg: "닉네임을 입력해주세요.");
    }else if(ctr3.text.length > 10){
      Fluttertoast.showToast(msg: "닉네임은 10글자까지입니다.");
    }else if(ctr4.text.isEmpty){
      Fluttertoast.showToast(msg: "비밀번호를 입력해주세요.");
    }else{
      User user = User();
      user.setId(ctr1.text);
      user.setPassword(ctr4.text);
      user.setNickName(ctr3.text);
      UserQuery(user).signUp().then((response){
        SharedPreferences.getInstance().then((storage) {
          storage.setString('id', ctr1.text);
          storage.setString('password', user.getPassword);
          storage.setString('nickName', ctr3.text);
          storage.setStringList('location', ['서울', '중구', '태평로1가']);
          _context!.read<UserProvider>().setId = ctr1.text;
          _context!.read<UserProvider>().setNickName = ctr3.text;
//          _context!.read<UserProvider>().setImage = user.getId;
          _context!.read<LocationProvider>().setLoc = ['서울', '중구', '태평로1가'];
          Fluttertoast.showToast(msg: "환영합니다!");
          Navigator.pushAndRemoveUntil(
          _context!,
          MaterialPageRoute(builder: (context) => MainSelect()),
          (route) => false);
        });
      });
    }
  }
}

class CheckEmail extends StatefulWidget {
  TextEditingController ctr1,ctr2;
  SMS smsInstance;

  CheckEmail(this.ctr1, this.ctr2,this.smsInstance);

  @override
  _CheckEmailState createState() => _CheckEmailState();


}

class _CheckEmailState extends State<CheckEmail> {
  String? idError,numError;
  bool idLock = false,numberLock = false;
  String idPattern = r'^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(child:CustomTextField.idInput(hint:'번호를 - 없이 입력해주세요.',label: 'PHONE NUMBER',controller: widget.ctr1,
        error: idError, enable: !idLock,onSubmited: (str)=>checkNumber())),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: idLock ? null : checkNumber, child: const Text('발송')),
      ]),
      const SizedBox(height: 5),
      Visibility(child:
      Row(children: [
        Expanded(
          child: CustomTextField.normalInput(hint:'인증 번호 입력',controller: widget.ctr2,
              enable: !context.watch<SMSResponse>().isComplete,error: numError,onSubmited: widget.smsInstance.sendCheckNumber),
        ),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: context.watch<SMSResponse>().isComplete ? null : () => widget.smsInstance.sendCheckNumber(widget.ctr2.text),
            child: const Text('확인')),
      ]),
        visible: idLock),

    ]);
  }

  // 인증번호 발송
  void checkNumber() {
    setState(() {
      if(!RegExp(idPattern).hasMatch(widget.ctr1.text)){
        idError = '올바르게 입력해주세요.';
      }else{
        User user = User();
        user.setId(widget.ctr1.text);
        UserQuery(user).checkId().then((response){
          if(response.isEmpty){
            setState(() {
              idError = null;
              idLock = true;
            });
            widget.smsInstance.sendSMS(widget.ctr1.text);
            Fluttertoast.showToast(msg: "인증 번호를 발송하였습니다.");
          }else{
            Fluttertoast.showToast(msg:response);
          }
        });
      }
//      successCheck = true;
    });
  }
}

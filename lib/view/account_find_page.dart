import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/controller/signup_api.dart';
import 'package:eating_alone/model/model.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'layouts/check_id.dart';
import 'package:provider/provider.dart';

import 'layouts/loading.dart';

class AccountFindPage extends StatefulWidget {
  @override
  _AccountFindPageState createState() => _AccountFindPageState();
}

class _AccountFindPageState extends State<AccountFindPage> {
  TextEditingController ctr1 = TextEditingController(),ctr2 = TextEditingController();
  String password = "";


  @override
  Widget build(BuildContext context) {
    SMS sms = SMS((msg){
      if(msg.message == 'success'){
        LoadingDialog(context);
        context.read<SMSResponse>().setIsComplete = true;
        User user = User();
        user.setId(ctr1.text);
        UserQuery(user).findAccount().then((value) {
          Navigator.pop(context);
          setState(() {
            password = "변경된 비밀번호\n$value";
          });
        });
      }else if(msg.message == 'fail'){
        Fluttertoast.showToast(msg: "인증번호가 일치하지않습니다.");
      }else if(msg.message == 'error'){
        Fluttertoast.showToast(msg: "오류가 발생했습니다. 잠시 후 시도해주세요.");
      }else if(msg.message == 'pass'){
        // 리캡챠 통과
      }
    });
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFffeb56),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('회원 찾기', style: Theme.of(context).textTheme.headline2!),
            const SizedBox(height: 50),
            Text('가입하신 휴대폰 번호를 통해 \n비밀번호를 초기화합니다.',
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.blue[400])),
        const SizedBox(height: 20),
//                  SendEmail(),
        CheckID(ctr1,ctr2,sms,true),
        const SizedBox(height: 60),
        Text(password,textAlign: TextAlign.center,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        sms
        ])
    )
    );
  }
}


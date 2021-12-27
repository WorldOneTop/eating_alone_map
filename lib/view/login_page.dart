import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/model/model.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:eating_alone/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './layouts/inputfield.dart';
import 'account_find_page.dart';
import 'layouts/loding.dart';
import 'main_app.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  FocusNode pwdNode = FocusNode();
  TextEditingController idController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFffeb56),
        body: Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          const SizedBox(height:70),
          Text('혼밥여지도',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center),
          Row(children: [
            const Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            Expanded(flex:8,child:Column(children: [
              Row(
                // 소셜로그인
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: "소셜 로그인",
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Image.asset(
                                  'assets/images/icons/kakaotalk.png',
                                  width: 40,
                                  height: 40)))),
                  GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: "소셜 로그인",
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Image.asset(
                                  'assets/images/icons/naver.png',
                                  width: 40,
                                  height: 40)))),
                  GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: "소셜 로그인",
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Image.asset(
                                  'assets/images/icons/facebook.png',
                                  width: 40,
                                  height: 40)))),
                ],
              ),
                CustomTextField.idInput(label: 'PHONE NUMBER',controller: idController,onSubmited: (str){pwdNode.requestFocus();}),
              const SizedBox(height:10),
              CustomTextField.passwordInput(controller: pwdController, focusNode: pwdNode,onSubmited: (str){login(context);}),
              const SizedBox(height:20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<SMSResponse>().setIsComplete = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: const Text('회원가입')),
                const SizedBox(width: 15),
                ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    child: const Text(' 로그인 '))
              ]),
              const SizedBox(height:10),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: const Color(0xcaaaaaaa),
                      padding: const EdgeInsets.symmetric(horizontal: 36)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainSelect()),
                            (route) => false);
                  },
                  child: const Text('비회원으로 이용하기')),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountFindPage()),
                    );
                  },
                  child: const Text('비밀번호가 기억나지 않는다면')),
              const SizedBox(height: 50),
            ])),
            const Expanded(
              child: SizedBox(),
              flex: 1,
            ),
          ]),
              const SizedBox(height: 50)
        ]));

  }
  void login(BuildContext context) {
    User user = User();
    if(!(user.setId(idController.text))){
      Fluttertoast.showToast(msg: "올바른 ID를 입력해주세요.");
      return;
    }
    if(!(user.setPassword(pwdController.text))){
      Fluttertoast.showToast(msg: "비밀번호를 입력해주세요.");
      pwdNode.requestFocus();
      return;
    }
    LodingDialog(context);
    UserQuery(user).login().then((value){
          Navigator.of(context).pop();
          if(value.isNotEmpty){
            Fluttertoast.showToast(msg: value);
          }else{
              // 로그인 정보 저장
            SharedPreferences.getInstance().then((storage) {
              storage.setString('id', user.getId);
              storage.setString('password', user.getPassword);
              UserQuery(user).userInfo().then((request) {
                storage.setString('nickName',request['nickName']);
                context.read<UserProvider>().setId = user.getId;
                context.read<UserProvider>().setNickName = request['nickName'];
//                context.read<UserProvider>().setImage = "";

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainSelect()),
                        (route) => false);
              });
            });
          }
        })
        .catchError((e){
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: '일시적인 오류가 발생했습니다.\n 잠시후 이용해주십시오.');
        });
  }

}

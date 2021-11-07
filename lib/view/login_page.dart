import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './layouts/title.dart';
import './layouts/inputfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFffeb56),
        body: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              TitleLayout(),
              const SizedBox(height: 20),
              Row( // 소셜로그인
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){Fluttertoast.showToast(msg: "소셜 로그인",);},
                      child: Container(
                        padding: const EdgeInsets.all(20),color: const Color(0xFFffeb56),
                        child:Image.asset('assets/images/icon_kakaotalk.png',width: 40,height: 40))),
                  GestureDetector(
                      onTap: (){Fluttertoast.showToast(msg: "소셜 로그인",);},
                      child: Container(
                          padding: const EdgeInsets.all(20),color: const Color(0xFFffeb56),
                      child: Image.asset('assets/images/icon_naver.png',width: 40,height: 40))),
                  GestureDetector(
                      onTap: (){Fluttertoast.showToast(msg: "소셜 로그인",);},
                    child: Container(
                        padding: const EdgeInsets.all(20),color: const Color(0xFFffeb56),
                      child: Image.asset('assets/images/icon_facebook.png',width: 40,height: 40))),
                ],
              ),
              Container( // 아이디,비번 입력
                  margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: Column(children: [
                    CustomTextField.idInput(),
                    const SizedBox(height: 10),
                    CustomTextField.passwordInput(),
                  ],)
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  child:Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () {
                            Fluttertoast.showToast(msg: "회원가입 창으로 이동",);
                          },
                              child: const Text('회원가입')),
                          const SizedBox(width:30),
                          ElevatedButton(onPressed: () {
                            Fluttertoast.showToast(msg: "메인으로 이동",);
                          },
                              child: const Text(' 로그인 '))
                        ]),
                    TextButton(
                        style:TextButton.styleFrom(
                            primary:Colors.black,
                            backgroundColor: const Color(0xcaaaaaaa),
                            padding: const EdgeInsets.symmetric(horizontal: 36)
                        ),
                        onPressed: (){
                          Fluttertoast.showToast(msg: "메인으로 이동",);
                          },
                        child: const Text('비회원으로 이용하기'))
                  ])
              ),
              TextButton(onPressed: () {
                Fluttertoast.showToast(msg: "회원찾기 창으로 이동",);
              },
                  child: const Text('아이디 혹은 비밀번호가 기억이 안난다면?')),
                const SizedBox(height: 40),
            ])
        ));
  }
}
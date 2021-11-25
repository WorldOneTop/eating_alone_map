import 'package:eating_alone/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './layouts/inputfield.dart';
import 'main_app.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFffeb56),
        body: Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          const SizedBox(height:70),
          Text('혼밥여지도',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center),
          const SizedBox(height:30),
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
                CustomTextField.idInput(label: 'PHONE NUMBER'),
              const SizedBox(height:10),
              CustomTextField.passwordInput(),
              const SizedBox(height:20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: const Text('회원가입')),
                const SizedBox(width: 15),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainSelect()),
                      );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainSelect()),
                    );
                  },
                  child: const Text('비회원으로 이용하기')),
              TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: "회원찾기 창으로 이동",
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
              const SizedBox(height: 10)
        ]));

  }
}

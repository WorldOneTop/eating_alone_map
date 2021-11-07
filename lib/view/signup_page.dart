import 'package:flutter/material.dart';
import './layouts/export_all.dart';

class SignupPage extends StatelessWidget {
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
                  Text('회원가입', style: Theme.of(context).textTheme.headline2!),
                  const SizedBox(height: 50),
                  CheckEmail(),
                  const SizedBox(height: 15),
                  CustomTextField.idInput(label: '닉네임'),
                  const SizedBox(height: 15),
                  CustomTextField.passwordInput(),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: (){}, child: const Text('가입하기',style:TextStyle(fontSize: 20))),
                  const SizedBox(height: 100),
                ])
        )
    );
  }
}

class CheckEmail extends StatefulWidget {
  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  bool _isCheck = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextField emailField;
    if(_isCheck) {
      emailField = CustomTextField.idInput(hint: controller.text,enable: false);
    }else {
      emailField = CustomTextField.idInput(label: 'EMAIL',controller: controller);
    }

    return Column(children: [
      emailField,
      Row(children: [
        ElevatedButton(
            onPressed: _isCheck ? null : allowEmail,
            child: const Text('인증 메일 발송',style: TextStyle(fontSize: 16))),
        Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: _isCheck, onChanged: (value){},
              checkColor: Colors.red,
              activeColor:  const Color(0xFFffeb56),
            )),
      ])
    ]);
  }

  void allowEmail() {
    // 여기서 메일 인증 성공시 처리
    setState(() {
      _isCheck = true;
    });
  }
}

import 'package:flutter/material.dart';

class CustomTextField {

  static Container normalInput({double? width, String hint = '입력해주세요.', Icon? suffixIcon, Icon? prefixIcon, int? size,
    var onChange, TextEditingController? controller, int fillColor = 0xb2ffffff}) {

    double height = 50, fontSize = 20;
    if(size == 1) { // 작은 사이즈
      height = 40; fontSize = 18;
    }else if(size == 2) {} // 중간사이즈
    else if(size == 3) { //큰 사이즈
      height = 60; fontSize = 22;
    }
    return Container(
        width: width,
        height: height,
        child:TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          fillColor: Color(fillColor),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(fontSize: fontSize, height: size==1 ? 1.4 : 1),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
      ),
              onChanged: onChange,
          controller: controller,
    ));
  }
  static TextField passwordInput() {
    return const TextField(
        obscureText: true,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: 8, horizontal: 13),

          filled: true,
          fillColor: Colors.white70,
          border: OutlineInputBorder(),
          labelText: 'PASSWORD',
        ));
  }
  static TextField idInput() {
    return const TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: 8, horizontal: 13),
          filled: true,
          fillColor: Colors.white70,
          border: OutlineInputBorder(),
          labelText: 'ID',
        ));
  }
}
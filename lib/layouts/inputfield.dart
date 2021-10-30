import 'package:flutter/material.dart';

class CustomTextField {

  Container normalInput({double? width, String hint = '입력해주세요.', Icon? suffixIcon, Icon? prefixIcon, int? size}) {
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
            contentPadding: EdgeInsets.all(10),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          fillColor: const Color(0xb2ffffff),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(fontSize: fontSize, height: size==1 ? 1.4 : 1),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
      )
    ));
  }
}
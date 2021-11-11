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
  static TextField passwordInput({String label ='PASSWORD',TextEditingController? controller,}) {
    return TextField(
        obscureText: true,
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 8, horizontal: 13),

          filled: true,
          fillColor: Colors.white70,
          border: const OutlineInputBorder(),
          labelText: label,
        ));
  }
  static TextField idInput({String label='ID',TextEditingController? controller, String? hint, bool enable=true,String? error}) {
    return TextField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        enabled: enable,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 8, horizontal: 13
          ),
          filled: true,
          fillColor: Colors.white70,
          border: const OutlineInputBorder(),
          labelText: label,
          errorText: error
        ));
  }
}
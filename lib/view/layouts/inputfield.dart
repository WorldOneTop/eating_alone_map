import 'package:flutter/material.dart';

class CustomTextField {

  static Container normalInput({double? width, String hint = '입력해주세요.', Icon? suffixIcon, Icon? prefixIcon, int size = 2,
  Function(String)? onChange,Function(String)? onSubmited, TextEditingController? controller, int fillColor = 0xb2ffffff,Color? inputColor, int? maxLines = 1}) {

    double height = 50, fontSize = 20;
    if(size == 1) { // 작은 사이즈
      height = 42; fontSize = 18;
    }else if(size == 2) {} // 중간사이즈
    else if(size == 3) { //큰 사이즈
      height = 60; fontSize = 22;
    }
    return Container(
        width: width,
        height: height,
        child:TextField(
          style: TextStyle(color: inputColor),
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
              maxLines: maxLines,
              onChanged: onChange,
          controller: controller,
        onSubmitted: onSubmited,
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
  static Container textInput({double? height, String hint = '입력해주세요.',  int size = 2,
Function(String)? onChange, TextEditingController? controller, int fillColor = 0xb2ffffff, int? minLines})  {
    return Container(
        height: height,
        child:TextField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            fillColor: Color(fillColor),
            filled: true,
            hintText: hint,
        ),
        maxLines: null,
        minLines: minLines,
        onChanged: onChange,
        controller: controller,
));
}
}
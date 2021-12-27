
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SMS extends StatelessWidget{
  WebViewController? controller;
  void Function(JavascriptMessage)? msgListener;

  SMS(this.msgListener);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double ratio = MediaQuery.of(context).devicePixelRatio;
    return Visibility(
//        visible:false, // 리캡챠 필요하면 바꿀 거
    visible: true,
        child: SizedBox(
//          width: width,
//          height: width*1.455,
          width: 1,
          height: 1,
          child: ClipRect(
            child: Transform.scale(
              alignment: FractionalOffset.topCenter,
              scale: ratio,//https://github.com/firebase/firebase-js-sdk/issues/3356
              child: WebView(
                initialUrl: "https://jeil.pythonanywhere.com/firebase",
                onWebViewCreated: (controller) {
                  this.controller = controller;
                  },
                javascriptChannels: {
                  JavascriptChannel(
                    name: 'responseMsg', onMessageReceived: msgListener!)
                  },
                javascriptMode: JavascriptMode.unrestricted,
              )
            ))
    ));
  }
  void sendCheckNumber(String num){
    controller!.runJavascript('codeCheck("$num")');
  }
  void sendSMS(String num){
    controller!.runJavascript("smsSend(${num.substring(1)})");
  }
}
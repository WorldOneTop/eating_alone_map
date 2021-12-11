import 'package:eating_alone/model/enum.dart';
import 'package:flutter/foundation.dart';
//import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class UserQuery {
  void getCurrentAddress(double lat, double lng, Function(JavascriptMessage) messageCallback) {
    print("ASD?");
    WebView(
      initialUrl: "${DataList.url}${describeEnum(URL.currentLocation)}?lat=$lat&lng=$lng",
//      onWebViewCreated: (controller) {
//        this.controller = controller;
//      },
      javascriptChannels: {JavascriptChannel(
          name: 'messageCallback', onMessageReceived: messageCallback)
      },
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
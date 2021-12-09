import 'package:eating_alone/controller/static_functions.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class KakaoMapItem {
  final String imageFile,name;
  final double lat,lng;

  KakaoMapItem(this.name, this.lat, this.lng, this.imageFile);

  @override
  String toString() {
    return '{"name":"$name","lat":"$lat","lng":"$lng","image_file":"$imageFile.png"}';
  }
}

class KakaoMap extends StatelessWidget {
  final double width, height, ratio;
  double centerLat, centerLng;
  int zoomLevel;
  List<KakaoMapItem> items;

  WebViewController? controller;

  final void Function(JavascriptMessage)? clickListener;

  final void Function(JavascriptMessage)? coordConvert;

  KakaoMap(
      {required this.width,
      required this.height,
      required this.ratio,
      required this.centerLat,
      required this.centerLng,
      required this.items,
      this.clickListener,
      this.coordConvert,
      this.zoomLevel = 3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ClipRect(
            child: Transform.scale(
                scale: ratio,
                child: WebView(
                  initialUrl: _getURL(),
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  onPageFinished: (str) {
                    // str = 페이지 주소
                    controller!.runJavascript("postMessage('$items');");
                  },
                  javascriptChannels: _getChannel,
                  javascriptMode: JavascriptMode.unrestricted,
                ))));
  }

  Set<JavascriptChannel>? get _getChannel {
    Set<JavascriptChannel>? channels = {};

    if (clickListener != null) {
      channels.add(JavascriptChannel(
          name: 'onClickMarker', onMessageReceived: clickListener!));
    }
    if (coordConvert != null) {
      channels.add(JavascriptChannel(
          name: 'CoordConvertListener', onMessageReceived: coordConvert!));
    }
    if (channels.isEmpty) {
      return null;
    }

    return channels;
  }



  void createCurrentMarker() {
    StaticFunctions.getCurrentLocation().then((value) => {
      if(value != null) {
        controller!.runJavascript('createCurrentMarker(${value[0]},${value[1]})')
      }
    });
  }

  void getCurrentAddrByListener() {
    if (coordConvert!= null) {
      StaticFunctions.getCurrentLocation().then((value) => {
        if(value != null) {
          controller!.runJavascript('sendCoordConvert(${value[0]},${value[1]})')
        }
      });
    }
  }

  String _getURL() {
    return 'https://jeil.pythonanywhere.com/kakaomap/?'
        'width=${width * ratio}&height=${height * ratio}&'
        'centerLat=$centerLat&centerLng=$centerLng&'
        'hasListener=${clickListener != null ? 1 : 0}&'
        'zoomLevel=$zoomLevel';
  }
}
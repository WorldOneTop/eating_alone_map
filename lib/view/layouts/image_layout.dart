import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageUpload extends StatefulWidget {
  double size;

  ImageUpload(this.size);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return InkWell(child:Column(crossAxisAlignment:CrossAxisAlignment.center,children: [
      Container(
          color: Colors.grey[300],
          padding: EdgeInsets.all(widget.size/3),
          child: Center(child: Icon(Icons.camera_alt,size: widget.size ))
      )
    ],),onTap: (){
      Fluttertoast.showToast(msg: '메뉴 이미지 업로드 버튼 ');
    });
  }
}

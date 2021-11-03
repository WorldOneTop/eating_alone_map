import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoHouse {

  Container buildLayout(BuildContext context, String title,{String? image,  String category = '?', int? rating, int review=0,double height = 100,String heart=''}) {
    String inputRating = '';
    Image inputImage;
    if(rating != null) {
      inputRating = '★ $rating/5 ㅣ ';
    }if(height < 65) {
      height = 65;
    }
    if(image == null) {
      inputImage = Image.asset('assets/images/tempImage.png',fit:BoxFit.cover,height: height);
    }else{
      inputImage = Image.asset(image,fit:BoxFit.cover,height: height);
      //네트워크 이미지 다루기
    }

//    Container(child:Center(child:inputImage,widthFactor: null,heightFactor: null,),color: Colors.black38,)
    return Container(
      height: height,
      color: const Color(0xFFF5F5F5),
      child: Row(children: [
        Expanded(flex: 1,child: Stack( children: [
          GestureDetector(child:Center(child:inputImage), onTap: (){
            Fluttertoast.showToast(msg: "이미지 새창으로 띄우기 처리");
          },),
          Positioned( bottom: 2, left: 4,
              child: Text(heart,style:const TextStyle(color: Color(0xF0F86A5B), fontSize: 18)))
        ])),
        Expanded(flex: 3,
            child:Column(children: [
              const SizedBox(height: 5),
              Text(title, maxLines:height > 94 ? 2 : 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3?.copyWith(height: 1.0),),
              Expanded(child: Container()),
              Text('$category ㅣ $inputRating리뷰 수 : $review',
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5)
            ])
        )
      ],
      )
    );
  }
}
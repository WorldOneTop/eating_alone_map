import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

import '../house_detail.dart';
import 'enlarge_image.dart';

class InfoHouse extends StatelessWidget{
  String title,heart='',category = '?';
  String? image;
  double? rating;
  int review=0;
  double height = 110;
  bool onTap;

  InfoHouse(this.title,this.onTap,{this.image,  this.category = '기타', this.rating, this.review=0,this.heart=''});

  @override
  Widget build(BuildContext context) {
    String inputRating = '';
    Image inputImage;
    int fontSize = 2 - category.length;

    if(review > 9999) {
      review = 9999;
    }

    if(rating != null) {
      inputRating = '★ $rating/5';
    }else{
      inputRating = '별점 없음';
    }

    if(image == null) {
      inputImage = Image.asset('assets/images/tempImage.png',fit:BoxFit.cover,height: height);
    }else{
      inputImage = Image.network(image!,fit:BoxFit.cover,height: height);
    }
    return GestureDetector(
        onLongPress: (){
          Fluttertoast.showToast(msg: "좋아요 처리");
        },onTap:(){
          if(onTap){
            Navigator.push(context, MaterialPageRoute(builder:(context) => HouseDetail(title,image: image,category: category,rating: rating,review: review,heart: heart)),);
          }
    },child:
      Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: const Color(0xFFF5F5F5),
        child: Row(children: [
          Expanded(flex: 1,child: GestureDetector(child:
            Stack( children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child:inputImage
              ),
              Positioned( bottom: 2, left: 4,
                child: Text(heart,style:const TextStyle(color: Color(0xF0F86A5B), fontSize: 18)))
            ]), onTap: (){
            if(image != null){
              Navigator.push(context, MaterialPageRoute(builder:(context) => EnlargeImage([image!])));
            }
          },)),
          Expanded(flex: 3,
              child:Column(children: [
                const SizedBox(height: 4),
              Expanded(child: WrappedKoreanText(title,maxLines: 2 ,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline4?.copyWith(height: 1.2),)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('$category',textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18.0+fontSize),),
                      Container(height: 18,width: 3,color: const Color(0xCA333333)),
                      Text(inputRating,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6),
                      Container(height: 18,width: 3,color: const Color(0xCA333333)),
                      Text('리뷰:$review',textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6)
                ]),
              ])
          )
        ],
        )
    ));
  }
}
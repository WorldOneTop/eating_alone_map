import 'package:eating_alone/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hashtagable/hashtagable.dart';
import 'layouts/appbar.dart';
import 'layouts/info_house.dart';
import 'layouts/output_star.dart';

class CreateReview extends StatefulWidget {
  String title,heart,category;
  String? image;
  double? rating;
  int review;

  CreateReview(this.title,{this.image,  this.category = '기타', this.rating, this.review=0,this.heart=''});


  @override
  _CreateReviewState createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  double rating = 0;
  List<String>? images;
  TextEditingController ctrText = TextEditingController();
  TextEditingController ctrHashtag = TextEditingController();

//  String? rating;
  // 필수자료 : 이미지, 내용, 별점, 해시태그, 사용자 아이디
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, widget.title),
        body: Container(margin: const EdgeInsets.all(15),child:ListView(children: [
          InfoHouse(widget.title, image: widget.image,
              category: widget.category,
              rating: widget.rating,
              review: widget.review,
              heart: widget.heart),
          const SizedBox(height: 10),
          Row(children:[inputRating()], mainAxisAlignment: MainAxisAlignment.center),
          const SizedBox(height: 10),
          ImageUpdateList(),
          const SizedBox(height: 10),
          HashTagTextField(
            decoratedStyle: const TextStyle(fontSize: 20, color: Colors.blue),
            basicStyle: const TextStyle(fontSize: 20, color: Colors.black),
            maxLines: null,
            controller: ctrHashtag,
            decoration: const InputDecoration(
              hintText: '리뷰를 작성해주세요.',
              filled: true,
              fillColor: Color(0xFBF0F0F0),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.end,children: [
            ElevatedButton(onPressed: (){
              Fluttertoast.showToast(msg: extractHashTags(ctrHashtag.text).toString());
            }, child: const Text('작성 완료'))])
        ])
        ));
  }

  GestureDetector inputRating() {
    return GestureDetector(
        onTapDown: (event){
          setState(() {
            rating = (event.localPosition.dx / 20).round()/2;
            if(rating > 5) rating = 5;
          });
        },
        onHorizontalDragUpdate: (event){
          setState(() {
            rating = (event.localPosition.dx / 20).round()/2;
            if(rating > 5) rating = 5;
          });
        },
        child: OutputStar(rating,40,color:const Color(0xFFFCFC00))
    );
  }
}

class ImageUpdateList extends StatefulWidget {
  @override
  _ImageUpdateListState createState() => _ImageUpdateListState();
}

class _ImageUpdateListState extends State<ImageUpdateList> {


  @override
  Widget build(BuildContext context) {
    return Container(height:100,color:Colors.white,child: const Center(child:Text('이미지 추가하기?')));
  }
}

import 'package:eating_alone/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hashtagable/hashtagable.dart';
import 'layouts/appbar.dart';
import 'layouts/info_house.dart';
import 'layouts/output_star.dart';

class CreateReview extends StatefulWidget {

  InfoHouse infoHouse;
  CreateReview(this.infoHouse);


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
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, widget.infoHouse.title),
        body: ListView(children: [
          widget.infoHouse,
          const SizedBox(height: 10),
          Row(children:[inputRating()], mainAxisAlignment: MainAxisAlignment.center),
          Container(margin: const EdgeInsets.all(20),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const Text('이미지 업로드',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ImageUpdateList(),
                const SizedBox(height: 10),
            const Text('리뷰 내용',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
          HashTagTextField(
            decoratedStyle: const TextStyle(fontSize: 20, color: Colors.blue),
            basicStyle: const TextStyle(fontSize: 20, color: Colors.black),
            maxLines: null,
            controller: ctrHashtag,
            minLines: 4,
            decoration: const InputDecoration(
              hintText: '리뷰를 작성해주세요.',
              filled: true,
              fillColor: Color(0xFBF0F0F0),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,),
          )])),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: InkWell(child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: const Color(0xFFF0F0F0),
                child: const Center(child: Text('취소',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)))
            ),onTap: (){
              Navigator.pop(context);
            })),
            Expanded(child: InkWell(child:Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: const Color(0xFF2ECC71),
                child: const Center(child: Text('작성 완료',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)))
            ),onTap: (){
              Fluttertoast.showToast(msg: '작성 버튼');
            })),
          ])
        ])
        );
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
        child: OutputStar(rating,40,color:const Color(0xFFffe62e))
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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eating_alone/controller/static_functions.dart';

import '../search_page.dart';
import 'enlarge_image.dart';
import 'output_star.dart';

class ReviewFootLayout extends StatefulWidget {
  String text;
  List<String>? images;
  TextStyle textStyle;
  double screenWidth;

  ReviewFootLayout(this.text,this.images,this.textStyle,this.screenWidth);

  @override
  _ReviewFootLayoutState createState() => _ReviewFootLayoutState(text,images,textStyle,screenWidth);
}

class _ReviewFootLayoutState extends State<ReviewFootLayout> {
  String text;
  List<String>? images;
  bool isFold = true;
  bool isOverflow = false;
  TextStyle? textStyle;
  double screenWidth;

  _ReviewFootLayoutState(this.text,this.images, this.textStyle,this.screenWidth){
    isOverflow = StaticFunctions.hasTextOverflow(text, textStyle!,maxLines: 4,
        maxWidth: screenWidth - (images != null ? 120 : 50));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> inputTop = [];
    Widget inputBottom;

    /*리뷰 이미지 처리*/
    if(images != null) {
      final double imageSize = isFold ? 80 : screenWidth - 50;
      List<Widget> inputImages = [GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => EnlargeImage(images!)));
          },
        child:Image.network(images![0],fit: BoxFit.cover, width: imageSize, height: imageSize,))];

      if(images!.length == 1) {
        inputTop.add(inputImages[0]);
        inputTop.add(const SizedBox(width: 10));
      }
      else {
        if(isFold) {
          inputImages.add(Positioned(bottom: 4, right: 4,
              child: Container(
                color: const Color(0x55000000),
                child: Row(children: [
                    const Icon(Icons.photo_library_rounded,
                    color: Color(0xFFFFFFFF), size: 18),
                const SizedBox(width: 5),
                Text(images!.length.toString(),
                style: const TextStyle(fontSize: 13, color: Colors.white),)
              ]),
              padding: const EdgeInsets.symmetric(
                  vertical: 2, horizontal: 4))));

        inputTop.add(Stack(children: inputImages));
        inputTop.add(const SizedBox(width: 10));
        }else {
          for(int i=0;i<images!.length;i++) {
            inputTop.add(
              GestureDetector(
                onTap: (){ Navigator.push(context, MaterialPageRoute(builder:(context) => EnlargeImage(images!,index: i,))); },
                child:Image.network(images![i],fit: BoxFit.cover, width: imageSize, height: imageSize))
            );
            inputTop.add(const SizedBox(height: 12));
          }
        }
      }
    }
    /* 리뷰 텍스트 처리*/
    if(isFold) {
      inputTop.add(Expanded(child: Text(text,maxLines: 4,overflow: TextOverflow.ellipsis, style:textStyle)));
    }else {
      inputTop.add(Text(text, style:textStyle));
    }

    /* 리뷰 더보기 버튼 처리 */
    if(!isFold) {
      inputBottom = const Icon(Icons.arrow_drop_up,size: 35);
    }else if(isOverflow) {
      inputBottom = const Icon(Icons.arrow_drop_down,size: 35);
    }else {
      inputBottom = Container();
    }

    return InkWell(onTap: (){
      if(isOverflow) {
          setIsFoldSwitch();
        }},
      child: Stack(children:[
          Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: !isFold ? Column(children: inputTop) : Row(children: inputTop)),
          Positioned(child: inputBottom,bottom: 0 ,right: 0,)
      ])
    );
  }
  void setIsFoldSwitch() {
    setState(() {
      isFold = !isFold;
    });
  }
}


class ReviewContainer extends StatelessWidget {
  int id;
  String name, text;
  DateTime time;
  String? profileImage;
  List<String>? hashtags, images;
  double? rating;

  ReviewContainer(this.id,this.name, this.text, this.time, {this.profileImage, this.hashtags, this.images, this.rating});

  @override
  Widget build(BuildContext context) {

    ImageProvider inputProfileImage;
    ListView inputHashtag = ListView(children: []);

    /* 프로필 이미지 설정(기본 or 설정값)*/
    if(profileImage == null ) {
      inputProfileImage = AssetImage('assets/images/defaultProfile.png');//,width: profileWidth,height: profileHeight,fit: BoxFit.cover,);
    }else {
      inputProfileImage = NetworkImage(profileImage!);
    }
    /* 해시태그 추가 여부에 따른 레이아웃*/
    if(hashtags != null) {
      inputHashtag = ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: hashtags!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(margin:const EdgeInsets.symmetric(horizontal: 4), child:ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => SearchPage(initStr: hashtags![index])));
              },
              child: Text(hashtags![index],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w100)),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 1),minimumSize: Size.zero),
            ));}
      );
    }

    return InkWell(onLongPress: (){
      Fluttertoast.showToast(msg: "삭제 여부");
    },child:
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(children: [
          Row(children: [
          Container( // 프로필이미지
          width: 50,height: 50, margin: const EdgeInsets.symmetric(horizontal: 3),
              child: CircleAvatar(
                backgroundImage: inputProfileImage,
                backgroundColor: const Color(0xFFF0F0F0),
                radius: 30,
              )),
          const SizedBox(width: 6),
          Expanded(child:
            Column( // 닉네임, 작성 시간
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(name, style: Theme.of(context).textTheme.headline5),
                  Expanded(child:Container()),
                  rating == null ? Container() : OutputStar(rating!,22)
                ]),
                Text('${time.year}.${time.month}.${time.day}',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16))
              ]))
    ]),
    const SizedBox(height: 8),
    SizedBox(height: hashtags == null ? 0 : 25, child:inputHashtag),
    const SizedBox(height: 12),
    ReviewFootLayout(text, images,Theme.of(context).textTheme.bodyText2!, MediaQuery.of(context).size.width),
    ])));
  }
}
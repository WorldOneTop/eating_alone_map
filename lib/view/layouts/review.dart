import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eating_alone/model/static_functions.dart';

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
    Row inputBottom;

    /*리뷰 이미지 처리*/
    if(images != null) {
      final double imageSize = isFold ? 80 : screenWidth - 50;
      List<Widget> inputImages = [GestureDetector(
        onTap: (){Fluttertoast.showToast(msg: "이미지 확대");},
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
                onTap: (){ Fluttertoast.showToast(msg: "이미지 확대"); },
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
      inputBottom = Row(children:[Expanded(child:Container()), const SizedBox(height: 5,child:Icon(Icons.arrow_drop_up))]);
    }else if(isOverflow) {
      inputBottom = Row(children:[Expanded(child:Container()), const SizedBox(height: 5,child:Icon(Icons.arrow_drop_down))]);
    }else {
      inputBottom = Row(children:[Expanded(child:Container())]);
    }



    return GestureDetector(
      onTap: (){
        if(isOverflow) {
          setIsFoldSwitch();
        }},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        !isFold ? Column(children: inputTop) : Row(children: inputTop),
        inputBottom
        ],
      )
    );
  }
  void setIsFoldSwitch() {
    setState(() {
      isFold = !isFold;
    });
  }
}


class ReviewContainer extends StatelessWidget {
  String name, text;
  DateTime time;
  String? profileImage;
  List<String>? hashtags, images;
  String? rating;

  ReviewContainer(this.name, this.text, this.time, {this.profileImage, this.hashtags, this.images, this.rating});

  @override
  Widget build(BuildContext context) {
    const double profileWidth = 45 ,profileHeight = 45;

    Image inputProfileImage;
    ListView inputHashtag = ListView(children: []);

    /* 프로필 이미지 설정(기본 or 설정값)*/
    if(profileImage == null ) {
      inputProfileImage = Image.asset('assets/images/tempImage.png',width: profileWidth,height: profileHeight,fit: BoxFit.cover,);
    }else {
      inputProfileImage = Image.network(profileImage!);
    }
    /* 해시태그 추가 여부에 따른 레이아웃*/
    if(hashtags != null) {
      inputHashtag = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hashtags!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(margin:const EdgeInsets.symmetric(horizontal: 4), child:ElevatedButton(
              onPressed: (){
                Fluttertoast.showToast(msg: "검색창으로 가서 해시태그 검색");
              },
              child: Text(hashtags![index],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w100)),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 1),minimumSize: Size.zero),
            ));}
      );
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(children: [
          Row(children: [
          Container( // 프로필이미지
          width: 50,height: 50, margin: const EdgeInsets.symmetric(horizontal: 3),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: inputProfileImage)),
          const SizedBox(width: 6),
          Expanded(child:
            Column( // 닉네임, 작성 시간
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(name, style: Theme.of(context).textTheme.headline5),
                  Expanded(child:Container()),
                  Text(rating ?? '', style: Theme.of(context).textTheme.headline5)
                ]),
                Text('${time.year}.${time.month}.${time.day}',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16))
              ]))
    ]),
    const SizedBox(height: 8),
    SizedBox(height: hashtags == null ? 0 : 25, child:inputHashtag),
    const SizedBox(height: 12),
    ReviewFootLayout(text, images,Theme.of(context).textTheme.bodyText2!, MediaQuery.of(context).size.width),
    const SizedBox(height: 5),
    ]));
  }
}
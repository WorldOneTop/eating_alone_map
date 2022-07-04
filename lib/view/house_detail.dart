import 'package:eating_alone/controller/kakaomap.dart';
import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/model/enum.dart';
import 'package:eating_alone/model/model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'create_review.dart';
import 'layouts/appbar.dart';
import 'layouts/info_house.dart';
import 'layouts/review.dart';
import 'update_house.dart';


class HouseDetail extends StatefulWidget {
  InfoHouse infoHouse;
  late int houseId;
  HouseDetail(this.infoHouse) {
    houseId = infoHouse.id;
  }

  @override
  _HouseDetailState createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _tabController;
  PreferredSize? inputTabBottom;

  PageInfo? pageInfo;
  Widget? pageMenu;
  Widget? pageReview;


  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3,initialIndex: 1);
    inputTabBottom= PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        color: Colors.white,
        height: 40,
        child: TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xca000000),
            labelColor: const Color(0xca000000),
            unselectedLabelColor: const Color(0xca666666),
            tabs: const [
              Text('상세정보', style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
              Text('메뉴', style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),//style: Theme.of(context).textTheme.headline6),
              Text('리뷰', style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600))//,style: Theme.of(context).textTheme.headline6),
            ]
        ),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(pageInfo == null && pageMenu == null && pageReview == null){
      getData();
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, widget.infoHouse.title),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: widget.infoHouse,
                pinned: true,
                floating: true,
                snap: false,
                forceElevated: innerBoxIsScrolled,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                toolbarHeight: 102,
                bottom: inputTabBottom
              ),
            ];
          },
          body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                      child: pageInfo ?? const Center(child:  CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent))
                  ),Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      child: pageMenu ?? const Center(child:  CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent))
                  ),Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: pageReview ?? const Center(child:  CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent))
                  )
                ],
          ),
        ),
    );
  }
  void getData(){
    HouseModel().selectHouseInfo(widget.houseId).then((value){
      setState(() {
        pageInfo = PageInfo(House(
            id:widget.houseId,
            info:value['info'],
            lat:double.parse(value['lat']),
            lng:double.parse(value['lng']),
            time:value['time'] ?? "\n",
            number:value['number'] ?? "\n",
            location:widget.infoHouse.location
        ),KakaoMap(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width*2/3,
          centerAddr: value['lat']+","+value['lng'],
          zoomLevel: 6,
          items: [KakaoMapItem(widget.houseId,double.parse(value['lat']),double.parse(value['lng']),widget.infoHouse.category)],
        ));
      });
    });
    HouseModel().selectHouseMenu(widget.houseId).then((value){ //[{name, price, image}]
      setState(() {
        List<HouseMenu> menus = [];
        for(Map m in value){
          HouseMenu h = HouseMenu();
          h.setId(m['id']);
          h.setName(m['name']);
          h.setPrice(m['price']);
          // h.setImage();
          menus.add(h);
        }//이미지필요
        if(menus.isEmpty){
          pageMenu = const Text("메뉴가 없습니다.");
        }else {
          pageMenu = PageMenu(menus);
        }
      });
    });
    HouseModel().selectHouseReview(widget.houseId).then((value){
      setState(() {
        List<ReviewContainer> reviews = [];
        for(Map m in value){
          ReviewContainer review = ReviewContainer(m['user_id'],m['user_nickName'],m['body'],m['time']);
          if(m['hashtag'] != null){

          }
          if(m['images'] != null){

          }
          if(m['rating'] != null){

          }
          if(m['user_image'] != null){

          }
          reviews.add(review);
        }
        if(reviews.isEmpty){
          pageReview = const Text("리뷰가 없습니다.");
        }else {
          pageReview = PageReview(widget.infoHouse, reviews);
        }
      });
    });
  }
}


class PageInfo extends StatefulWidget{
  House house;
  KakaoMap kakaoMap;
  PageInfo(this.house,this.kakaoMap);

  @override
  _PageInfoState createState() => _PageInfoState();
}

class _PageInfoState extends State<PageInfo> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Row(children:  [
          const Expanded(child: SizedBox()),
          TextButton(child: const Text('♡',style: TextStyle(color: Color(0xF0F86A5B), fontSize: 25)),
              onPressed: (){
                Fluttertoast.showToast(msg: '좋아요');
              })
        ]),
        _getTitleText(context, '가게 설명'),
        _getBodyText(context,widget.house.info),
        _getTitleText(context, '전화번호'),
        _getBodyText(context,widget.house.number),
        _getTitleText(context, '영업시간'),
        _getBodyText(context,widget.house.time),
        _getTitleText(context, '위치'),
        widget.kakaoMap,
        _getBodyText(context,widget.house.location),
        Row(children: [
          const Expanded(child: SizedBox()),
          TextButton(child: const Text('잘못된 정보 신고하기',style: TextStyle(fontSize: 17)),
              onPressed: (){
                Fluttertoast.showToast(msg: '신고');
              })
        ]),
        Row(children: [
          const Expanded(child: SizedBox()),
          TextButton(child: const Text('정보 변경하기',style: TextStyle(fontSize: 17)),
              onPressed: (){
//            House house = House();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HouseUpdate(null)));
              })
        ]),
      ],
    );
  }
  Text _getTitleText(BuildContext context, String str) {
    return Text(str,style: Theme.of(context).textTheme.subtitle1);
  }
  Container _getBodyText(BuildContext context, String? str) {
    if(str == null) {
      return Container();
    }
    return Container(
        margin: const EdgeInsets.only(left: 8,bottom: 20),
        child:Text(str,style: Theme.of(context).textTheme.bodyText1)
    );
  }
  void changeHeart(){

  }
  @override
  bool get wantKeepAlive => true;
}


// class PageInfoo extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       physics: const BouncingScrollPhysics(),
//       children: [
//         Row(children:  [
//           const Expanded(child: SizedBox()),
//           TextButton(child: const Text('♡',style: TextStyle(color: Color(0xF0F86A5B), fontSize: 25)),
//               onPressed: (){
//                 Fluttertoast.showToast(msg: '좋아요');
//           })
//         ]),
//         _getTitleText(context, '가게 설명'),
//         _getBodyText(context,house.info),
//         _getTitleText(context, '전화번호'),
//         _getBodyText(context,house.number),
//         _getTitleText(context, '영업시간'),
//         _getBodyText(context,house.time),
//         _getTitleText(context, '위치'),
//         kakaoMap,
//         _getBodyText(context,house.location),
//         Row(children: [
//           const Expanded(child: SizedBox()),
//           TextButton(child: const Text('잘못된 정보 신고하기',style: TextStyle(fontSize: 17)),
//             onPressed: (){
//             Fluttertoast.showToast(msg: '신고');
//             })
//         ]),
//         Row(children: [
//           const Expanded(child: SizedBox()),
//           TextButton(child: const Text('정보 변경하기',style: TextStyle(fontSize: 17)),
//               onPressed: (){
// //            House house = House();
//             Navigator.push(context, MaterialPageRoute(builder: (context) => HouseUpdate(null)));
//               })
//         ]),
//       ],
//     );
//   }
//   Text _getTitleText(BuildContext context, String str) {
//     return Text(str,style: Theme.of(context).textTheme.subtitle1);
//   }
//   Container _getBodyText(BuildContext context, String? str) {
//     if(str == null) {
//       return Container();
//     }
//     return Container(
//       margin: const EdgeInsets.only(left: 8,bottom: 20),
//         child:Text(str,style: Theme.of(context).textTheme.bodyText1)
//     );
//   }
//   void changeHeart(){
//
//   }
// }

class PageMenu extends StatelessWidget {
  List<HouseMenu> menu;

  PageMenu(this.menu);

  @override
  Widget build(BuildContext context) {
    List<Widget> inputMenuList = [
      Row(mainAxisAlignment: MainAxisAlignment.end,children: [TextButton(onPressed: () {
        Fluttertoast.showToast(msg: "메뉴판 사진이 존재하지않습니다 판별 여부 해야함",);
      },
          child: const Text('메뉴판 사진으로 보기',style: TextStyle(fontSize: 18),))])
    ];
    inputMenuList.add(const SizedBox(height: 15));



    for(HouseMenu m in menu) {
      inputMenuList.add(
        Row(crossAxisAlignment:CrossAxisAlignment.start,children: [
          SizedBox(width: 20, child:Container(margin:const EdgeInsets.only(top: 5),child:const Icon(Icons.circle,size: 10,))),
          Expanded(child:Text(m.getName,style: const TextStyle(fontSize: 20,height: 1.2 ))),
          Text('${NumberFormat.currency(locale: "ko_KR",symbol: '').format(m.getPrice)}원',style: const TextStyle(fontSize: 20,height: 1.2),textAlign: TextAlign.end,)]
        ),
      );
    }

    return ListView.separated(
        physics: const BouncingScrollPhysics(),
      itemCount: inputMenuList.length,
      itemBuilder: (BuildContext context, int index){
        return inputMenuList[index];
      },separatorBuilder: (BuildContext context, int index){
        return const SizedBox(height: 15);
      });
  }
}

class PageReview extends StatelessWidget {
  InfoHouse infoHouse;

  List<ReviewContainer> data;

  PageReview(this.infoHouse,this.data);

  @override
  Widget build(BuildContext context) {


    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length+1,
        itemBuilder: (context, index) {
          if(index==0){
            return Row(children: [Expanded(child:Container()),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReview(infoHouse)));
              }, child: const Text('리뷰 작성'))]);
          }
          return data[index-1];
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
    );
  }
}

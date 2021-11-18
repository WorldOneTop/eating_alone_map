import 'package:eating_alone/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'layouts/appbar.dart';
import 'layouts/info_house.dart';
import 'layouts/review.dart';


class HouseDetail extends StatefulWidget {
  String title,heart,category;
  String? image;
  double? rating;
  int review;

  HouseDetail(this.title,{this.image,  this.category = '기타', this.rating, this.review=0,this.heart=''});

  @override
  _HouseDetailState createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _tabController;
  PreferredSize? inputTabBottom;
  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);

    inputTabBottom= PreferredSize(
      preferredSize: Size.fromHeight(30),
      child: Container(
        color: Colors.white,
        height: 30,
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, widget.title),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: InfoHouse(widget.title,image: widget.image, category: widget.category,rating: widget.rating, review: widget.review,heart: widget.heart),
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
                    margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 30),
                    child: PageInfo('직접 업데이트하거나 없애거나 정보수정가능하게 하거나','033-1234-5678','월~금 05:00~22:00, 토 일 휴무 등등','강원 춘천시 삭주로 98 (우)24254')
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                    child: PageMenu({
                      '장칼국수':7000,
                      '장칼국수옹심이':8000,
                      '쥐눈이콩(약콩)냉콩국수':8000,
                      '어린이를 위한 영양주먹밥어린이를 위한 영양주먹밥':3000
                    })
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    child: PageReview()
                  ),
                ],
          ),
        ),
    );
  }
}



class PageInfo extends StatelessWidget {
  String mainInfo, number, time, location;
  String note;

  PageInfo(this.mainInfo, this.number, this.time, this.location, {this.note = ''});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _getTitleText(context, '가게 설명'),
        _getBodyText(context,mainInfo),
        _getTitleText(context, '전화번호'),
        _getBodyText(context,number),
        _getTitleText(context, '영업시간'),
        _getBodyText(context,time),
        _getTitleText(context, '위치'),
        Container(height: 80,color: Colors.blueGrey),
        _getBodyText(context,location),
        _getTitleText(context, '비고'),
        _getBodyText(context,note),
      ],
    );
  }
  Text _getTitleText(BuildContext context, String str) {
    if(str == '비고' || note == null) {
      return const Text('');
    }
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
}

class PageMenu extends StatelessWidget {
  Map<String,int> menu;

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



    for(String name in menu.keys) {
      inputMenuList.add(
        Row(crossAxisAlignment:CrossAxisAlignment.start,children: [
          Expanded(flex:2, child:Container(margin:const EdgeInsets.only(top: 5),child:const Icon(Icons.circle,size: 10,))),
          const Text(' ',style: TextStyle(fontSize: 22)),
          Expanded(flex:30, child:Text(name,style: const TextStyle(fontSize: 20,height: 1.2 ))),
          Expanded(child: Container()),
          Expanded(flex:9, child:Text('${NumberFormat.currency(locale: "ko_KR",symbol: '').format(menu[name])}원',style: const TextStyle(fontSize: 20,height: 1.2)))]
        ),
      );
    }

    return ListView(children: inputMenuList,);
  }
}

class PageReview extends StatelessWidget {

  List<Widget> test = [
  ReviewContainer('이제일','글자만 있을 경우',DateTime.now()),
  ReviewContainer('이제일','점수 4',DateTime.now(),rating: 4),
  ReviewContainer('이제일','해쉬태그들',DateTime.now(),hashtags: ['#가나','#다라','asfdasdfadsfsadfas']),
  ReviewContainer('이제일','긴 글자만 있을 경우 \n 제3항의 승인을 얻지 못한 때에는 그 처분 또는 명령은 그때부터 효력을 상실한다. 이 경우 그 명령에 의하여 개정 또는 폐지되었던 법률은 그 명령이 승인을 얻지 못한 때부터 당연히 효력을 회복한다. 모든 국민은 거주·이전의 자유를 가진다. 지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 국가는 대외무역을 육성하며, 이를 규제·조정할 수 있다. 국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경 제의 발전에 노력하여야 한다. 저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 제1항의 탄핵소추는 국회재적의원 3분의 1 이상의 발의가 있어야 하며, 그 의결은 국회재적의원 과반수의 찬성이 있어야 한다. 다만, 대통령에 대한 탄핵소추는 국회재적의원 과반수의 발의와 국회재적의원 3분의 2 이상의 찬성이 있어야 한다.',
  DateTime.now()),
  ReviewContainer('이제일','이미지 한장, 짧은 글',DateTime.now(),images:['https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png']),
  ReviewContainer('이제일','이미지 4장, 짧은 글',DateTime.now(),images:['https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_3_320x240.png']),
  ReviewContainer('이제일',"이미지 여러장, 긴 글 \n 대통령은 조약을 체결·비준하고, 외교사절을 신임·접수 또는 파견하며, 선전포고와 강화를 한다. 모든 국민은 신속한 재판을 받을 권리를 가진다. 형사피고인은 상당한 이유가 없는 한 지체없이 공개재판을 받을 권리를 가진다. 국가는 주택개발정책등을 통하여 모든 국민이 쾌적한 주거생활을 할 수 있도록 노력하여야 한다. 대통령은 전시·사변 또는 이에 준하는 국가비상사태에 있어서 병력으로써 군사상의 필요에 응하거나 공공의 안녕질서를 유지할 필요가 있을 때에는 법률이 정하는 바에 의하여 계엄을 선포할 수 있다. 국가는 전통문화의 계승·발전과 민족문화의 창달에 노력하여야 한다. 농업생산성의 제고와 농지의 합리적인 이용을 위하거나 불가피한 사정으로 발생하는 농지의 임대차와 위탁경영은 법률이 정하는 바에 의하여 인정된다.",
  DateTime.now(),images: ['https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png','https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_6_640x480.png']),
  ];

  @override
  Widget build(BuildContext context) {
    test.insert(0,Row(children: [Expanded(child:Container()),
        ElevatedButton(onPressed: (){
          Fluttertoast.showToast(msg: "리뷰작성페이지",);
          }, child: const Text('리뷰 작성'))],)
    );

    return ListView.separated(
        itemCount: test.length,
        itemBuilder: (context, index) {
          return test[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
    );
  }
}

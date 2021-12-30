import 'package:eating_alone/controller/kakaomap.dart';
import 'package:flutter/material.dart';
import 'layouts/area_setting.dart';
import 'layouts/info_house.dart';

class MainMap extends StatefulWidget {
  List<String> location;
  MainMap(this.location);

  @override
  _MainMapState createState() => _MainMapState();
}


class _MainMapState extends State<MainMap> with AutomaticKeepAliveClientMixin {
  KakaoMap? kakao;


  @override
  Widget build(BuildContext context) {
    kakao = KakaoMap(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width+80,
      centerAddr: "${widget.location[0]} ${widget.location[1]} ${widget.location[2]}",
      zoomLevel: widget.location[2].isNotEmpty ? 5 : widget.location[1].isNotEmpty ? 7 : 9,
      items: [],
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
        Text('주변식당',style: Theme.of(context).textTheme.headline4),
        kakao!,
        const Divider(),
        HouseList()
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HouseList extends StatefulWidget {
  @override
  _HouseListState createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  List<Widget> houseList = [];

  @override
  void initState() {
    for(int i=0;i<10;i++){
      houseList.add(SizedBox(height: 20,));
      houseList.add(InfoHouse('강릉 육사시미',true,category: '한식', rating: 4.5,review: 93,image: 'https://picsum.photos/100'));
      houseList.add(SizedBox(height: 20,));
      houseList.add(InfoHouse('24시 전주 명가 콩나물 국밥 강릉점',true,category: '한식',heart: '♡', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: houseList.length,
        itemBuilder: (context, index) {
          return houseList[index];
        }
    );
  }
}

import 'package:eating_alone/controller/kakaomap.dart';
import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'layouts/area_setting.dart';
import 'layouts/info_house.dart';
import 'layouts/loading.dart';
import 'package:provider/provider.dart';

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
      clickListener: (message){
        Fluttertoast.showToast(msg: message.message);
      },
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
        Text('주변식당',style: Theme.of(context).textTheme.headline4),
        kakao!,
        const Divider(),
          HouseList(kakao!)
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HouseList extends StatefulWidget {
  KakaoMap kakao;

  HouseList(this.kakao);

  @override
  _HouseListState createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  List<Widget> houseList = [];


  @override
  Widget build(BuildContext context) {
    if(houseList.isEmpty){
      houseList = [const Center(child:  CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent))];
      getData();
    }
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: houseList.length,
        itemBuilder: (context, index) {
          return houseList[index];
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height:20);
        },
    );
  }
  void getData(){
    HouseModel().selectLocationHouse(context.watch<LocationProvider>().getLoc()).then((value){
      setState(() {
        if(value.isEmpty){
          houseList = [const Center(child:Text('주변에 위치한 식당이 없습니다.',style: TextStyle(fontSize: 32,color: Colors.black),textAlign: TextAlign.center))];
          return;
        }

        List<KakaoMapItem> items = [];
        houseList = [];
        for(Map val in value){
          houseList.add(InfoHouse(val['id'], val['name'],true,category: val['category'], rating: val['rating'],
              review: val['review_count'], image: 'https://picsum.photos/100'));
          items.add(KakaoMapItem(val['id'],val['lat'], val['lng'],val['category']));
        }
        if(items.isNotEmpty) {
          widget.kakao.createMarkers(items);
        }
      });
    });
  }
}

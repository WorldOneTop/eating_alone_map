import 'package:flutter/material.dart';
import 'layouts/area_setting.dart';
import 'layouts/info_house.dart';


class MainMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: ListView(children: [
        Text('주변식당',style: Theme.of(context).textTheme.headline4),
        Container(
          height: 350,
          color: Colors.blueGrey,
          margin: const EdgeInsets.all(20)
        ),
        HouseList()
      ]),
    );
  }
}

class HouseList extends StatefulWidget {
  @override
  _HouseListState createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  List<Widget> houseList = [AreaSetting()];

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

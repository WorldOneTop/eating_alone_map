import 'package:eating_alone/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'layouts/area_setting.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Text('지역',style: Theme.of(context).textTheme.subtitle1),
          AreaSetting(),
          Container(height: 1,margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),color: const Color(0xa0000000),),
          const SizedBox(height: 10),
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: List.generate(DataList.menuName.length, (index) {
                return MenuItem('assets/images/icons/${DataList.menuName[index]}.png', DataList.menuName[index]);})
          ),
        ]
    );
  }
}

class MenuItem extends StatelessWidget {
  String image,name;

  MenuItem(this.image,this.name);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child:
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 33,height: 33,
              margin: const EdgeInsets.all(6),
              child:Image.asset(image)
          ),
          Text(name,textAlign: TextAlign.center,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)]
    ),
      onTap: (){Fluttertoast.showToast(msg: "$name 메뉴 선택 창으로 이동");},
    );
  }
}
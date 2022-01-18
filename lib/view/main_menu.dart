import 'package:eating_alone/model/enum.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';

import 'layouts/area_setting.dart';
import 'selected_menu.dart';
import 'package:provider/provider.dart';

import 'update_house.dart';
class MainMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int crossAxisCount,size;
    if(MediaQuery.of(context).size.width > 760){
      crossAxisCount = 5;
      size = 28;
    }else if(MediaQuery.of(context).size.width > 350){
      crossAxisCount = 4;
      size = 18;
    }else{
      crossAxisCount = 3;
      size = 18;
    }
    return Column(
        children: [
          const SizedBox(height: 6),
          Row(children:[Text('지역',style: Theme.of(context).textTheme.subtitle1),const Expanded(child:SizedBox())]),
          AreaSetting(),
          Container(height: 1,color: const Color(0xa0000000),),
          const SizedBox(height: 30),
          GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 20,
              children: List.generate(DataList.menuName.length+1, (index) {
                if(index == DataList.menuName.length){
                  return MenuItem('assets/images/icons/add_house.png', '가게 등록',-1,size);
                }
                return MenuItem('assets/images/icons/${DataList.menuName[index]}.png', DataList.menuName[index],index,size);})
          ),
        ]
    );
  }
}

class MenuItem extends StatelessWidget {
  String image,name;
  int index;
  int size;

  MenuItem(this.image,this.name,this.index,this.size);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(child:
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: size*2+4,height: size*2+4,
              margin: const EdgeInsets.all(3),
              child:Image.asset(image)
          ),
          Text(name,textAlign: TextAlign.center,style:TextStyle(fontSize: size * 1.0,fontWeight: FontWeight.bold),),
        ]
    ),
      onTap: (){
      if(index == -1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HouseUpdate(null)));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectMenu(name,index)));
      }},
    );
  }
}
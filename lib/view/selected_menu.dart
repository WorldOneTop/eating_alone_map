import 'package:flutter/material.dart';
import './layouts/export_all.dart';
import 'package:eating_alone/model/enum.dart';

class SelectMenu extends StatelessWidget {
  String menu;
  PreferredSize? tabBar ;
  List<Container> tabBarView = [];
  static DropdownButton? selectSort;
  
  SelectMenu(this.menu){
    List<Text> tabList = [];
    TabBar initTabBar;
    selectSort = DropdownButton(
      onChanged: (val){},
        hint: Text('인기순'),
        items: const [
      DropdownMenuItem(child: Text('인기순'),value: 1,),
      DropdownMenuItem(child: Text('이름순'),value: 2),
      DropdownMenuItem(child: Text('거리순'),value: 3),
    ]);

    for(int i=0; i<DataList.menuName.length; i++) {
      tabList.add(Text(DataList.menuName[i]));
      tabBarView.add(buildTabLayout(DataList.menuName[i]));
    }
    initTabBar =  TabBar(
        indicatorColor: const Color(0xca000000),
        isScrollable: true,
        labelColor: const Color(0xca000000),
        unselectedLabelColor: const Color(0xca666666),
        tabs: tabList
    );

    tabBar= PreferredSize(
      preferredSize: initTabBar.preferredSize,
      child: Container(
        color: Colors.white,
        height: 30,
        child: initTabBar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: DataList.menuName.length,
        child: Scaffold(
            drawer: CustomDrawer.getInstance().getDrawer(context),
            resizeToAvoidBottomInset: false,
            appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.menu, menu,bottom : tabBar),
            body: TabBarView(children: tabBarView)
        ));
  }
  
  Container buildTabLayout(String menu) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(children: [
          Row(mainAxisAlignment: MainAxisAlignment.end,children: [selectSort!],),
          SizedBox(height: 20,),
          InfoHouse('강릉 육사시미',category: '한식', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
          SizedBox(height: 20,),
          InfoHouse('24시 전주 명가 콩나물     국밥 강릉점',category: '한식',heart: '♡', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
          SizedBox(height: 20,),
          InfoHouse('로그인 하지 않은 상태',category: '세글자', rating: 2,review: 1234,image: 'https://picsum.photos/100' ),
          SizedBox(height: 20,),
          InfoHouse('리뷰가 없을 때',category: '한식',heart: '♥',image: 'https://picsum.photos/100'),
          SizedBox(height: 20,),
          InfoHouse('작을경우 고정',category: '한식',heart: '♥', rating: 2,review: 1234 ,height:50,image: 'https://picsum.photos/100'),
          SizedBox(height: 20,),
        ])
        );
  }
}
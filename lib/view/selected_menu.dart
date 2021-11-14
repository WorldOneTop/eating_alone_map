import 'package:flutter/material.dart';
import './layouts/export_all.dart';
import 'package:eating_alone/model/enum.dart';

class SelectMenu extends StatefulWidget {
  String menu;

  SelectMenu(this.menu);

  @override
  _SelectMenuState createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenu> with SingleTickerProviderStateMixin {
  TabController? ctr;
  PreferredSize? tabBar;
  List<ListView> tabBarView = [];
  Widget? selectSort;
  TabBarView? inputTabBarView;



  @override void initState() {
    super.initState();
    List<Text> tabList = [];
    TabBar initTabBar;

    ctr = TabController(vsync: this, length: DataList.menuName.length);
    selectSort = SelectSort();

    for(int i=0; i<DataList.menuName.length; i++) {
      tabList.add(Text(DataList.menuName[i],style: const TextStyle(fontSize: 17)));
      tabBarView.add(buildTabLayout(DataList.menuName[i]));
    }

    initTabBar =  TabBar(
      controller: ctr,
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
        height: 40,
        child: initTabBar,
      ),
    );
    inputTabBarView = TabBarView(children: tabBarView,controller: ctr,);

    ctr!.addListener(() {
      setAppBarTitle(ctr!.index);
    });
  }
  @override void dispose() {
    ctr!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.menu, widget.menu,bottom : tabBar),
        body: inputTabBarView
    );
  }
  void setAppBarTitle(int index){
    setState(() {
      widget.menu = DataList.menuName[index];
    });
  }

  ListView buildTabLayout(String menu) {
    List<Widget> test = [
      Row(mainAxisAlignment: MainAxisAlignment.end,children: [selectSort!]),
      SizedBox(height: 20,),
      InfoHouse('강릉 육사시미',category: '한식', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
      SizedBox(height: 20,),
      InfoHouse('24시 전주 명가 콩나물     국밥 강릉점',category: '한식',heart: '♡', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
      SizedBox(height: 20,),
      SizedBox(height: 20,),
      InfoHouse('강릉 육사시미',category: '한식', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
      SizedBox(height: 20,),
      InfoHouse('24시 전주 명가 콩나물     국밥 강릉점',category: '한식',heart: '♡', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
      SizedBox(height: 20,),
      SizedBox(height: 20,),
      InfoHouse('강릉 육사시미',category: '한식', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
      SizedBox(height: 20,),
      InfoHouse('24시 전주 명가 콩나물     국밥 강릉점',category: '한식',heart: '♡', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
      SizedBox(height: 20,),
      SizedBox(height: 20,),
      InfoHouse('강릉 육사시미',category: '한식', rating: 4.5,review: 93,image: 'https://picsum.photos/100'),
      SizedBox(height: 20,),
      InfoHouse('24시 전주 명가 콩나물     국밥 강릉점',category: '한식',heart: '♡', rating: 4.3,review: 824,image: 'https://picsum.photos/100' ),
      SizedBox(height: 20,)];
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: test.length,
        itemBuilder: (BuildContext context, int index){
          return Container(child:test[index]);
        }
    );
  }
}


/* 식당 정렬 드롭다운버튼*/
class SelectSort extends StatefulWidget {
  int sortNum = 0;
  @override
  _SelectSortState createState() => _SelectSortState();

  int getSortNum() => sortNum;
}

class _SelectSortState extends State<SelectSort> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        onChanged: (val){
          setState(() {
            widget.sortNum = val as int;
          });},
        value: widget.sortNum,
        items: const [
          DropdownMenuItem(child: Text('이름순'),value: 0),
          DropdownMenuItem(child: Text('리뷰순'),value: 1),
          DropdownMenuItem(child: Text('별점순'),value: 2),
          DropdownMenuItem(child: Text('거리순'),value: 3),
        ]);
  }
}


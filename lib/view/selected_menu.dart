import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import './layouts/export_all.dart';
import 'package:eating_alone/model/enum.dart';

class SelectMenu extends StatefulWidget {
  String menu;
  int index;

  SelectMenu(this.menu,this.index);

  @override
  _SelectMenuState createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenu> with SingleTickerProviderStateMixin {
  TabController? ctr;
  PreferredSize? tabBar;
  List<ListView> tabBarView = [];
  Widget? selectSort;
  TabBarView? inputTabBarView;
  Map<String,List<Widget>?> houseList= { for (var v in DataList.menuName) v : null };



  @override void initState() {
    super.initState();
    List<Text> tabList = [];
    TabBar initTabBar;

    ctr = TabController(vsync: this, length: DataList.menuName.length,initialIndex: widget.index);
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
    print("그럼 이게 재실행?");
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
    if(houseList[menu] == null){
      houseList[menu] = [const Center(child:  CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent))];
      getData(menu);
    }
    print(menu);
    print(houseList[menu]!.length+1);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: houseList[menu]!.length+1,
        itemBuilder: (BuildContext context, int index){
          if(index==0){
            return const SizedBox(height: 10);
          }
          return Container(child:houseList[menu]![index-1]);
        }
    );
  }

  void getData(String menu){

    HouseModel().selectCategoryHouse(menu, context.read<LocationProvider>().getLoc()).then((value){
      setState(() {
        if(value.isEmpty){
          houseList[menu] = [ Center(child:Text('주변에 위치한 $menu 식당이 없습니다.',style:const TextStyle(fontSize: 32,color: Colors.black),textAlign: TextAlign.center))];
          return;
        }
        houseList[menu] = transformHouseList(value,menu);
      });
    });
  }
  List<InfoHouse> transformHouseList(List value, String menu){
    List<InfoHouse> list = [];
    for(Map val in value){
      list.add(InfoHouse(val['id'], val['name'],true,val['location'],category: menu, rating: val['rating'],
          review: val['review_count'], image: 'https://picsum.photos/100'));
    }
    print(list.toString());
    return list;
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


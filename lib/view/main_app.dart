import 'package:flutter/material.dart';
import './layouts/export_all.dart';
import './main_menu.dart';
import './main_map.dart';
import 'package:eating_alone/model/enum.dart';

class MainSelect extends StatelessWidget {
  TabBar tabBar = const TabBar(
      indicatorColor: Color(0xca000000),
      labelColor: Color(0xca000000),
      unselectedLabelColor: Color(0xFFFFFFFF),
      tabs: [
        Icon(Icons.home,size: 35),
        Icon(Icons.map_outlined,size: 35),
      ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2 ,
        child: Scaffold(
          drawer: CustomDrawer.getInstance().getDrawer(context),
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.main, '',bottom : tabBar),
          body:
            TabBarView(children: [
              Container(child: MainMenu(), margin: const EdgeInsets.symmetric(horizontal: 15)),
              MainMap()
            ])
        ));
  }
}






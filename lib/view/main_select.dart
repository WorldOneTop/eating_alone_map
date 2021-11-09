import 'package:flutter/material.dart';
import './layouts/export_all.dart';

class MainSelect extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = const TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xFFFFFFFF),//aaaaaa),
        tabs: [
          Icon(Icons.home,size: 35),
          Icon(Icons.map_outlined,size: 35),
        ]);
    return DefaultTabController(
      length: 2 ,
        child: Scaffold(
          drawer: CustomDrawer.getInstance().getDrawer(context),
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.main, '',bottom : tabBar),
      body:
        TabBarView(children: [
          MainMenu(),
          MainMap()
        ])
    ));
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MainMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



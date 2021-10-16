import 'package:flutter/material.dart';
import './drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("혼밥여지도"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Search button is Clicked");
            },
          )
        ],
      ),
      drawer: CustomDrawer.getInstance().getDrawer(context),
    );
  }
}
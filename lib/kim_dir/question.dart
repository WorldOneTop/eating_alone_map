import 'package:flutter/material.dart';

class Question extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("문의하기"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0.0,

        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Search button is Clicked");
            },
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TitleLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // 타이틀
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/tempImage.png', width: 70,
                height: 70,),
              const SizedBox(width: 8),
              Text('혼밥여지도', style: Theme.of(context).textTheme.headline1)
            ]
        )
    );
  }
}

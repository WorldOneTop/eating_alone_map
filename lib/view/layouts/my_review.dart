import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyReviewContainer extends StatelessWidget {
  String text,houseName;
  DateTime time;

  MyReviewContainer(this.houseName,this.time,this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
            Text(houseName,maxLines: 1,overflow:TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline5),
            Text('${time.year}.${time.month}.${time.day}',style: Theme.of(context).textTheme.subtitle1),
          ]),
          Row(children: [
            GestureDetector(onTap: (){Fluttertoast.showToast(msg: "해당 리뷰로 이동");},
                child: const Icon(Icons.arrow_right_alt,size: 35)),
            GestureDetector(onTap: (){Fluttertoast.showToast(msg: "리뷰 삭제");},
                child: const Icon(Icons.close,size: 30)),
          ]),
        ]),
        const SizedBox(height: 6),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(text,maxLines: 4,overflow:TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText2))
      ]));
  }
}

import 'package:flutter/material.dart';

class OutputStar extends StatelessWidget {
  double rating;
  double size;
  Color color;
  int starCount;
  OutputStar(this.rating,this.size,{this.color = Colors.black,this.starCount = 5});

  @override
  Widget build(BuildContext context) {
    List<Icon> inputStar = [];
    for(; 1 <= rating;rating--) {
      inputStar.add( Icon(Icons.star,size: size,color: color,));
    }
    if(rating==0.5) {
      inputStar.add(Icon(Icons.star_half,size: size,color: color,));
      rating -= 0.5;
    }
    int leftRating = starCount-inputStar.length;
    for(int i=0;i<leftRating;i++) {
      inputStar.add(Icon(Icons.star_border,size: size,color: color,));
    }
    return Row(children: inputStar);
  }

}
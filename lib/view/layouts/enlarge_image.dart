import 'package:flutter/material.dart';

class EnlargeImage extends StatefulWidget {
  List<String> images;
  bool isAssets;
  int index;

  EnlargeImage(this.images,{this.isAssets = false,this.index = 0});

  @override
  _EnlargeImageState createState() => _EnlargeImageState();
}

class _EnlargeImageState extends State<EnlargeImage> {

  @override
  Widget build(BuildContext context) {
    Image selectImage;
    Widget inputTop;

    if(widget.isAssets) {
      selectImage = Image.asset(widget.images[widget.index]);
    }else {
      selectImage = Image.network(widget.images[widget.index]);
    }

    if(widget.images.length > 1) {
      inputTop = Row(children: [
          const Icon(Icons.photo_library,color: Colors.white,size: 18),
          const SizedBox(width: 10),
          Text('${widget.index+1} / ${widget.images.length}', style: const TextStyle(color: Colors.white, fontSize: 18))
      ]);
    }else{
      inputTop = const SizedBox();
    }


    return Scaffold(
        body: GestureDetector(child:
        Stack(
        alignment: Alignment.center,
        children: [
        SizedBox.expand(
          child: Container(color: Colors.black,),
        ),
          Positioned(top: 30, child: inputTop),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 70,horizontal: 5),
            child: selectImage
          ),
          Positioned(
              left: 2,
              child: IconButton(onPressed: prevImage, icon: Icon(Icons.chevron_left,color: Colors.grey,
                  size: widget.images.length == 1 ? 0 : 40))),
          Positioned(
              right: 2,
              child: IconButton(onPressed: nextImage, icon: Icon(Icons.chevron_right,color: Colors.grey,
                  size: widget.images.length == 1 ? 0 : 40))),
          Positioned(
              right: 4,top: 25,
              child: IconButton(onPressed: (){ Navigator.pop(context); }, icon: const Icon(Icons.close,color: Colors.grey,size: 40))),
        ],
      ),onHorizontalDragEnd: (event){
          if(event.primaryVelocity! == 0) return;

          if(event.primaryVelocity! < 0 ){
            nextImage();
          }else{
            prevImage();
          }
        },
    ));
  }
  void prevImage() {
    setState(() {
      widget.index--;
      if(widget.index < 0) {
        widget.index = widget.images.length - 1;
      }
    });
  }
  void nextImage() {
    setState(() {
      widget.index = (widget.index+1) %widget.images.length;
    });
  }
}

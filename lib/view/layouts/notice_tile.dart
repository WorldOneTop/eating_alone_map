import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class NoticeTile extends StatefulWidget {
  String title,text;
  String? date;
  bool isAnswer;
  NoticeTile? answer;
  bool? sureFold;

  NoticeTile(this.title, this.text,this.date,this.isAnswer,{this.answer,this.sureFold});

  @override
  _NoticeTileState createState() => _NoticeTileState();
}

class _NoticeTileState extends State<NoticeTile> {
  bool isFold = true;
  List<Widget> layoutTop = [];
  Widget? layoutText;
  ClipRRect? checkAnswer;

  @override
  void initState() {

    if(!widget.isAnswer && widget.date==null){ //null safety?
      return;
    }
    if(widget.isAnswer) {
      layoutTop.addAll([
        const Icon(Icons.subdirectory_arrow_right,size: 20,),
        const Text('답변 내용',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        const Expanded(child: SizedBox())
      ]);
      layoutText = Container(margin: const EdgeInsets.fromLTRB(20,5,5,5),child:WrappedKoreanText(widget.text));
    }else{
      checkAnswer = ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              color: const Color(0xFdF0F0F0),
              child: const Text('답변완료', style: TextStyle(fontSize: 13))
          ));}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.sureFold != null) {
      isFold = widget.sureFold!;
      widget.sureFold = null;
    }
    if(!widget.isAnswer) {
      layoutTop=  [Expanded(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Row(children: [
            Expanded(child:Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: isFold ? null : FontWeight.bold))),
            Container(
                margin: const EdgeInsets.only(left: 8),
                child: widget.answer != null && isFold ? checkAnswer: null)
          ]),
            Text(widget.date!, style: TextStyle(fontSize: widget.date!.isEmpty ? 0 : 15,color: Colors.grey))
          ])),Icon(isFold ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up, size: 30,color: Colors.grey)];
      layoutText = Container(margin:const EdgeInsets.all(5),child:Text(widget.text));
    }
    return InkWell(
      onTap: changeFold,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(left: 8),
        color: isFold ? null : const Color(0xFdF0F0F0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: layoutTop),
              Container(child: isFold  && !widget.isAnswer ? null : layoutText),
              Container(child: !isFold && widget.answer != null ? const Divider(color: Colors.black) : null),
              Container(child: isFold ? null : widget.answer)
          ]),
    ));
  }
  void changeFold(){
    setState(() {
      isFold = !isFold;
    });
  }
}

import 'package:flutter/material.dart';
import 'layouts/appbar.dart';
import 'package:eating_alone/model/enum.dart';

class SearchPage extends StatefulWidget {
  TextEditingController? controller;
  String initStr;

  SearchPage({this.initStr = ''}){
    controller = TextEditingController(text: initStr);
  }

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> default_wordList = ['자동완성 되어 보여질 식당 이름들 리스트','enum class에 저장해서 onchange event로 list update','아무 것도 입력 안했을 때는',
      '로그 관리해서 최근 검색 기록 순서대로','보여주기',
    '테스트 워드','가나다라마바사','가나다라마바','가나다라','가마바','나라마바','가나다라 가나다라 가나다라 가나다라'];
  List<RichText>? input_wordList;
  @override
  void initState() {
    if(!widget.controller!.text.isEmpty) {
      setInputWordList(widget.controller!.text);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.search, '검색어를 입력하세요.',ctr: widget.controller,
            onChange: (text){setState(() {
            if(text.isEmpty) {
              input_wordList = null;
            }else {
              setInputWordList(text);
            }});
        }),
        body:ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            itemBuilder: wordBuilder,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: (input_wordList ?? default_wordList).length
        ));
  }
  Widget wordBuilder(BuildContext context,int index) {
    if(widget.controller!.text.isEmpty) {
      return GestureDetector(
        onTap: (){
          widget.controller!.text = default_wordList[index];
          setInputWordList(widget.controller!.text);
          setState(() {
          });
        },
        child: Text(default_wordList[index],overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 18),));
    }else  {
      return GestureDetector(
          onTap: (){
            widget.controller!.text = input_wordList![index].text.toPlainText();
            setInputWordList(widget.controller!.text);
            setState(() {
            });
          },
          child: input_wordList![index]
    );}
  }
  void setInputWordList(String text){
    input_wordList = [];
    for(String str in default_wordList) {
      List<String> strSplit = str.split(text);
      if(strSplit.length != 1) { // 일치문자열 있을때
        List<TextSpan> inputText = []; // 강조할 텍스트 구분
        TextStyle boldTextStyle = const TextStyle(fontWeight: FontWeight.bold);

        if(strSplit[0].isEmpty) {
          inputText.add(TextSpan(text: text,style: boldTextStyle));
        }
        for(int i=0;i<strSplit.length-1;i++) {
          if(strSplit[i].isNotEmpty){
            inputText.add(TextSpan(text: strSplit[i]));
            inputText.add(TextSpan(text: text,style: boldTextStyle));
          }
        }
        if(strSplit.last.isNotEmpty) {
          inputText.add(TextSpan(text: strSplit.last));
        }
        input_wordList!.add(RichText(
          text:TextSpan(
            style: const TextStyle(fontSize: 18,color: Colors.black,fontFamily:'Elice' ),
            children: inputText)));
      }
    }
  }
}
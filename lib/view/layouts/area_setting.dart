import 'package:eating_alone/controller/kakaomap.dart';
import 'package:flutter/material.dart';

class AreaSetting extends StatefulWidget {
  @override
  _AreaSettingState createState() => _AreaSettingState();
}

class _AreaSettingState extends State<AreaSetting> {
  List<String> _locations = ['서울', '중구', '태평로1가'];

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Row(children: [getLocText(0), getLocText(1), getLocText(2)]),
//        Text(_selectedArea, style: Theme.of(context).textTheme.headline5),
        const Expanded(child: SizedBox()),
        InkWell(
            onTap: () { selectCurrentLocation();},
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                child: Container(color: const Color(0xFFF5F5F5),padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
                margin: const EdgeInsets.only(bottom: 4),
                child: Row(children: const [Text('지역 설정  '),Icon(Icons.my_location)]))
            )
        )
      ]
    );
  }

  void selectCurrentLocation(){
    KakaoMap kakao = KakaoMap(
      width: 400,
      height: 500,
      centerAddr: "${_locations[0]} ${_locations[1]} ${_locations[2]}",
      hasClickListener: true,
      zoomLevel: _locations[2].isNotEmpty ? 5 : _locations[1].isNotEmpty ? 7 : 9,
      items: [],
      coordConvert: (message){
        setState(() {
          setLocText(message.message);
        });
        Navigator.pop(context);
      },
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          kakao.createCurrentMarker();
          return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            content: kakao,
            actions: <Widget>[
              TextButton(
                child: const Text("설정"),
                onPressed: () {
                  kakao.getMarkerAddr();
                },
              ),TextButton(
                child: const Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  void setLocText(String str){print(str);
    List<String> splitStr = str.split(' ');
    _locations[0] = splitStr[0];
    _locations[1] = splitStr[1];

    if(splitStr[0] != '세종특별자치시'){
      _locations[2] = splitStr[2];
    }
  }
  Widget getLocText(int index){
    if(index==0){
      return Text(_locations[index],style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600));
    }else if(_locations[index].isEmpty){
      return const SizedBox();
    }
    return InkWell(
      onTap: (){
        setState(() {
          _locations[index] = '';
          if(index==1){
            _locations[2] = '';
          }
        });
      },
      child: Stack(
          children: [
            Container(
                padding: const EdgeInsets.only(right: 8),
                child: Text(_locations[index],style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            const Positioned(child: Icon(Icons.close,size: 10,),top: 3,right: 0,)
          ])
    );
  }
  

}


import 'package:eating_alone/controller/kakaomap.dart';
import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/model/enum.dart';
import 'package:eating_alone/model/model.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'layouts/appbar.dart';
import 'layouts/image_layout.dart';
import 'layouts/inputfield.dart';
import 'package:provider/provider.dart';

import 'layouts/loading.dart';

class HouseUpdate extends StatefulWidget {
  House? house;

  HouseUpdate(this.house);

  @override
  _HouseUpdateState createState() => _HouseUpdateState();
}

class _HouseUpdateState extends State<HouseUpdate> {
  late TextEditingController ctrName;
//  late TextEditingController ctrImage;
  late TextEditingController ctrInfo;
  late TextEditingController ctrNumber;
  late TextEditingController ctrTime;
  bool dialogClose = false;
  List<bool> checkTime = [false,false,false,false,false,false,false,false];
  late TimeContent timeContent;

  @override
  void initState() {
    if(widget.house != null){ // 변경
//      ctrName = TextEditingController();
//      ctrInfo = TextEditingController();
//      ctrNumber = TextEditingController();
//      ctrTime = TextEditingController();
    }else{    // 생성
      widget.house = House();
      widget.house!.location = '';
      widget.house!.time = '';
      widget.house!.category = DataList.menuName[0];
      ctrName = TextEditingController();
      ctrInfo = TextEditingController();
      ctrNumber = TextEditingController();
      ctrTime = TextEditingController();
      timeContent = TimeContent(null,null);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, "식당 등록"),
        bottomSheet:
            Container(height: 60,
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: const Color(0xFFffe62e),
                child: Row(children: [
                  Expanded(child: InkWell(child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('등록하기  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
                        Icon(Icons.check,size: 30)
                      ]),
                      onTap: submitHouse)),
                  const VerticalDivider(thickness: 2,color: Colors.white,),
                  Expanded(child: InkWell(child:
                  const Center(child: Text('메뉴 등록하기    →',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black))),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MenuUpdate(widget.house!))))),
                ])),
        body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
            children: [
              Row(children: [
                InkWell(child:Column(children: [
                  Container(
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(15),
                      margin:  const EdgeInsets.all(6),
                      child: const Center(child: Icon(Icons.camera_alt,size: 45 ))
                  ),const Text('대표 사진')
                ],),onTap: (){
                  Fluttertoast.showToast(msg: '이미지 업로드 버튼 ');
                }),
                const SizedBox(width: 20),
                Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(children: const [Text('*가게 명',style: TextStyle(fontSize: 20)),Expanded(child: SizedBox())]),
                      CustomTextField.normalInput(hint: '',fillColor: 0xFFF8F8F8,inputColor: Colors.black,size: 3,controller: ctrName,maxLength: 20),
                      DropdownButton(
                          onChanged: (val){
                            setState(() {
                              widget.house!.category = val as String;
                            });},
                          value: widget.house!.category,
                          items:  DataList.menuName.map(
                                  (value){
                                return DropdownMenuItem(child: Text(value),value: value);
                              }
                          ).toList())
                    ]))
              ]),
              const Divider(height: 30),
              Text('*가게 설명',style: Theme.of(context).textTheme.subtitle1),
              CustomTextField.textInput(hint: '',fillColor: 0xFFF8F8F8,maxLength: 200,controller: ctrInfo),
              Text('전화번호',style: Theme.of(context).textTheme.subtitle1),
              CustomTextField.normalInput(hint: '',  fillColor: 0xFFF8F8F8,controller: ctrNumber,maxLength: 13,size: 3),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                const SizedBox(width: 10),
                Expanded(child: InkWell(
                    onTap: () {
                      setLocation(context.read<LocationProvider>().getLoc());
                    },
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(7)),
                        child: Container(color: const Color(0xFFF8F8F8),padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: const [Text('*위치  ',style: TextStyle(fontSize: 18),),Icon(Icons.my_location)]))
                    )
                )),
                const SizedBox(width: 15,),
                Expanded(child: InkWell(
                    onTap: () { setTime();},
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(7)),
                        child: Container(color: const Color(0xFFF8F8F8),padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: const [Text('영업 시간  ',style: TextStyle(fontSize: 18),),Icon(Icons.access_time)]))
                    )
                )),
                const SizedBox(width: 10),
              ]),
              Row(children: [
                const SizedBox(width: 10),
                Expanded(child: Text(widget.house!.location!,textAlign: TextAlign.center)),
                const SizedBox(width: 15,),
                Expanded(child: Text(widget.house!.time!)),
                const SizedBox(width: 10),
              ]),
              const SizedBox(height: 60)
            ]));
  }

  void setLocation(List<String> _locations){
    KakaoMap kakao = KakaoMap(
      width: 400,
      height: 500,
      centerAddr: "${_locations[0]} ${_locations[1]} ${_locations[2]}",
      hasClickListener: true,
      zoomLevel: _locations[2].isNotEmpty ? 5 : _locations[1].isNotEmpty ? 7 : 9,
      items: [],
      coordConvert: (message){
        setState(() {
          widget.house!.location = message.message;
        });
        if(dialogClose){
          dialogClose = false;
          Navigator.pop(context);
        }else{
          dialogClose = true;
        }
      },
      getLatLng: (message){
        List<String> splitStr = message.message.split(',');
        widget.house!.lat = double.parse(splitStr[0]);
        widget.house!.lng = double.parse(splitStr[1]);
        if(dialogClose){
          dialogClose = false;
          Navigator.pop(context);
        }else{
          dialogClose = true;
        }
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
                  kakao.getMarkerLatLng();
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
  void setTime(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            content: timeContent,
            actions: <Widget>[
              TextButton(
                child: const Text("설정"),
                onPressed: () {
                  if(timeContent.times![0] == '00:00' || timeContent.times![1] == '00:00'){
                    Fluttertoast.showToast(msg: "운영 시간을 알려주세요.");
                    return;
                  }
                  setState(() {
                    widget.house!.time = timeContent.getStringTime();
                  });
                  Navigator.pop(context);
                },
              ),TextButton(
                child: const Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
    }
    void submitHouse(){
      if(ctrName.text.isEmpty){
        Fluttertoast.showToast(msg: '가게 명을 입력해주세요.');
        return;
      }else if(ctrInfo.text.isEmpty){
        Fluttertoast.showToast(msg: '가게 설명을 입력해주세요.');
        return;
      }else if(widget.house!.location!.isEmpty){
        Fluttertoast.showToast(msg: '가게 위치를 입력해주세요.');
        return;
      }
      widget.house!.name = ctrName.text;
      widget.house!.info = ctrInfo.text;

      if(ctrNumber.text.isNotEmpty){
      widget.house!.number = ctrNumber.text;
      }
      LoadingDialog(context);

      HouseModel().createHouse(widget.house!).then((value) {
        Navigator.pop(context);
        if (int.tryParse(value) == null) {
          Fluttertoast.showToast(msg: value);
        }else{
          Navigator.pop(context);
          Fluttertoast.showToast(msg: '등록이 완료되었습니다!');
        }
      });
    }
}
class TimeContent extends StatefulWidget {
  List<bool>? checkDay;
  List<String>? times;
  List<String> days = ['월','화','수','목','금','토','일','공휴일'];

  TimeContent(this.checkDay,this.times);

  @override
  _TimeContentState createState() => _TimeContentState();

  String getStringTime(){
    String result = "운영시간\n";
    result += getStringTimeContain(true) +" ${times![0]}~${times![1]}";
    result += '\n\nBreak Time\n';
    if(times![2] == '00:00' || times![3] == '00:00'){
      result += 'X';
    }
    result += '\n\n';

    String cache = getStringTimeContain(false);
    if(cache.isNotEmpty){
      result += cache +" 휴무";
    }

    return result;
  }
  String getStringTimeContain(bool isWork){
    String result = "";
    String cache = "";
    for(int i=0; i<days.length-1; i++){
      if(checkDay![i] == isWork) {
        cache += days[i];
      }else {
        if(result.isNotEmpty && cache.isNotEmpty){
          result += ', ';
        }
        if(cache.isNotEmpty) {
          result += cache[0];
          if (cache.length == 2) {
            result += ', '+cache[1];
          } else if (cache.length > 2) {
            result += '~' + cache[cache.length - 1];
          }
        }
        cache = "";
      }
    }
    if(result.isNotEmpty && cache.isNotEmpty){
      result += ', ';
    }
    if(cache.isNotEmpty) {
      result += cache[0];
      if (cache.length == 2) {
        result += ', '+cache[1];
      } else if (cache.length > 2) {
        result += '~' + cache[cache.length - 1];
      }
      cache = "";
    }
    if(result.isNotEmpty && checkDay![days.length -1] == isWork){
      cache = ', ';
    }
    result += cache + (checkDay![days.length -1] == isWork ? '공휴일' : '');
    return result;
  }
}

class _TimeContentState extends State<TimeContent> {

  @override
  void initState() {
    widget.checkDay ??= [true,true,true,true,true,true,true,true];
    widget.times ??= ['00:00','00:00','00:00','00:00'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize:MainAxisSize.min ,crossAxisAlignment: CrossAxisAlignment.start,children: [
      const Text('영업일',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      Row(children: widget.days.asMap().entries.map(
              (e){
            return Column(
              children: [
                Text(e.value),
                Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: widget.checkDay![e.key], onChanged: (value){setState(() {widget.checkDay![e.key] = value!;});})
              ],
            );
          }).toList()
      ),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('영업 시간',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        const SizedBox(width: 15),
        setTimeWidget(0),const Text('~'),setTimeWidget(1),
        const SizedBox(width: 15),
        const Icon(Icons.close,color: Colors.transparent)
      ]),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('휴식 시간',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        const SizedBox(width: 15),
        setTimeWidget(2),const Text('~'),setTimeWidget(3),
        const SizedBox(width: 15),
        InkWell(child: const Icon(Icons.close),onTap: resetBreakTime,)
      ]),
    ]);
  }
  InkWell setTimeWidget(int index){
    return InkWell(
        onTap: () {
          Future<TimeOfDay?> future = showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.input
          );
          future.then((timeOfDay) {
            if(timeOfDay != null){
              setState((){
                NumberFormat f = NumberFormat("00");
                widget.times![index] = '${f.format(timeOfDay.hour)}:${f.format(timeOfDay.minute)}';
              });
            }
          });
        },
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            child: Container(color: const Color(0xFFF8F8F8),padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                child: Text(widget.times![index],style: const TextStyle(fontSize: 18)))
        )
    );
  }
  void resetBreakTime(){
    setState(() {
      widget.times![2] = '00:00';
      widget.times![3] = '00:00';
    });
  }
}


class MenuUpdate extends StatefulWidget {
  House house;

  MenuUpdate(this.house);

  @override
  _MenuUpdateState createState() => _MenuUpdateState();
}

class _MenuUpdateState extends State<MenuUpdate> {
  bool priceImageOpen = false;

  List<Widget> bodyWidgets = [];
  List<List<TextEditingController>> ctrs = [];

  @override
  Widget build(BuildContext context) {
    if(bodyWidgets.isEmpty){
    bodyWidgets = [
      const Text("메뉴 등록",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold)),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(height: 30),
      InkWell(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            color: const Color(0xFFF8F8F8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('메뉴 추가  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(Icons.add_box_outlined,size: 30)
                ])
        ),onTap: (){
        setState(() {
          bodyWidgets.insert(bodyWidgets.length-2, menuAddWidget(bodyWidgets.length-2));
        });
      },
      ),
      const SizedBox(height: 80),
    ];}
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar.getInstance().getAppBar(context, Appbar_mode.detail, "식당 등록"),
        bottomSheet: InkWell(
          child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: const Color(0xFFffe62e),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('등록하기  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(Icons.check,size: 30)
                ])
          ),
          onTap: submitHouse,
        ),
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(17, 14, 17, 0),
            itemCount: bodyWidgets.length,
            itemBuilder: (context,index){
              if(index == 1){
                return Row(children: [
                  const Expanded(child: SizedBox()),
                  InkWell(child: Row(children: [
                    const Text('메뉴판 사진 등록'),Icon(priceImageOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)
                  ]),onTap: (){
                    setState(() {
                      priceImageOpen = !priceImageOpen;
                    });
                  }),
                ]);
              }else if(index == 2){
                return Visibility(child: priceImage(),visible: priceImageOpen);
              }
              return bodyWidgets[index];
            })
    );
  }
  Widget priceImage(){
    return Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
      const Expanded(child: SizedBox()),
      InkWell(child:
      Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(15),
          margin:  const EdgeInsets.all(6),
          child: const Center(child: Icon(Icons.camera_alt,size: 45 ))
      ),onTap: (){
        Fluttertoast.showToast(msg: "메뉴판 이미지 등록");
      }
      )
    ],);
  }
  Widget menuAddWidget(int index){
    List<TextEditingController> ctr = [TextEditingController(), TextEditingController()];
    ctrs.add(ctr);

    return Column(
      children: [
        Row(children: [
          ImageUpload(35),
          const SizedBox(width: 10),
          Expanded(child: CustomTextField.textInput(hint: '*메뉴 명',  fillColor: 0xFFF8F8F8,controller: ctr[0])),
          const SizedBox(width: 15),
          CustomTextField.normalInput(hint: '*가격',  fillColor: 0xFFF8F8F8,width: 100,inputColor: Colors.black, controller: ctr[1]),
          const Text('원',style: TextStyle(fontSize: 20))
        ]
        ),
        Row(children: [
          const Text('메뉴 사진'),
          const Expanded(child: SizedBox()),
          InkWell(
            child: const Icon(Icons.close),
            onTap: (){
              setState(() {
                bodyWidgets[index] = const SizedBox(height: 0);
              });
            },
          ),
        ],),
        const SizedBox(height: 10)
      ],
    );
  }
  void submitHouse(){
    if(ctrs.isEmpty){
      return ;
    }
//    String result = "[";
//    for(int i=0; i< ctrs.length; i++ ){
//      result += '{"name":"${ctrs[i][0].text}","price":"${ctrs[i][1].text}"}';
//      if(i < ctrs.length - 1 ){
//        result += ',';
//      }else{
//        result += ']';
//      }
//    }
//    print(result);
//    List<Map> result = [];
//    for(int i=0;i<ctrs.length; i++){
//      result.add(
//        {
//          'name': ctrs[i][0],
//          'price': ctrs[i][1],
//        }
//      );
//    }
//    for(int i=0;)
//    int index = 0;
//
//    if(widget.house.menus != null){
//      for(; index < widget.house.menus!.length; index++){
//        widget.house.menus![index]['name'] = ;
//        widget.house.menus![index]['name'] = "";
//      }
//    }

  }
}
import 'package:eating_alone/controller/query.dart';
import 'package:eating_alone/controller/signup_api.dart';
import 'package:eating_alone/model/model.dart';
import 'package:eating_alone/model/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'inputfield.dart';


class CheckID extends StatefulWidget {
  TextEditingController ctr1,ctr2;
  SMS smsInstance;
  bool isFind;
  CheckID(this.ctr1, this.ctr2,this.smsInstance, this.isFind);

  @override
  _CheckIDState createState() => _CheckIDState();
}

class _CheckIDState extends State<CheckID> {
  String? idError,numError;
  bool idLock = false,numberLock = false;
  String idPattern = r'^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(child:CustomTextField.idInput(hint:'번호를 - 없이 입력해주세요.',label: 'PHONE NUMBER',controller: widget.ctr1,
            error: idError, enable: !idLock,onSubmited: (str)=>checkNumber())),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: idLock ? null : checkNumber, child: const Text('발송')),
      ]),
      const SizedBox(height: 5),
      Visibility(child:
      Row(children: [
        Expanded(
          child: CustomTextField.normalInput(hint:'인증 번호 입력',controller: widget.ctr2,
              enable: !context.watch<SMSResponse>().isComplete,error: numError,onSubmited: widget.smsInstance.sendCheckNumber),
        ),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: context.watch<SMSResponse>().isComplete ? null : () => widget.smsInstance.sendCheckNumber(widget.ctr2.text),
            child: const Text('확인')),
      ]),
          visible: idLock),

    ]);
  }

  // 인증번호 발송
  void checkNumber() {
    setState(() {
      if(!RegExp(idPattern).hasMatch(widget.ctr1.text)){
        idError = '올바르게 입력해주세요.';
      }else{
        User user = User();
        user.setId(widget.ctr1.text);
        UserQuery(user).checkId().then((response){
          if((response.isEmpty && !widget.isFind) || (response.isNotEmpty && widget.isFind)){
            setState(() {
              idError = null;
              idLock = true;
            });
            widget.smsInstance.sendSMS(widget.ctr1.text);
            Fluttertoast.showToast(msg: "인증 번호를 발송하였습니다.");
          }else{
            Fluttertoast.showToast(msg:widget.isFind ? "존재하지 않는 아이디입니다." :response);
          }
        });
      }
    });
  }
}

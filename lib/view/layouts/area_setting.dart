import 'package:flutter/material.dart';

class AreaSetting extends StatefulWidget {
  @override
  _AreaSettingState createState() => _AreaSettingState();
}

class _AreaSettingState extends State<AreaSetting> {
  final List<String> _valueList = ['서울', '인천', '수원', '대전', '대구', '광주', '부산'];
  String _selectedArea = '서울';

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text(_selectedArea, style: Theme.of(context).textTheme.headline4),
        const Expanded(child: SizedBox()),
        DropdownButton(
          hint: const Text('지역 변경'),
          items: _valueList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedArea = value as String;
            });},
        )],

    );
  }
}


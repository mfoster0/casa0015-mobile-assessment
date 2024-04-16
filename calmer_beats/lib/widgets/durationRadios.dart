import 'package:flutter/material.dart';

class DurationRadioWidget extends StatefulWidget {
  @override
  _DurationRadioWidgetState createState() => _DurationRadioWidgetState();
}

class _DurationRadioWidgetState extends State<DurationRadioWidget> {
  String? _selectedValue = '3';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Duration (mins): '),
        Radio<String>(
          value: '3',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
        Text('3'),
        Radio<String>(
          value: '5',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
        Text('5'),
        Radio<String>(
          value: '10',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
        Text('10'),
      ],
    );
  }
}
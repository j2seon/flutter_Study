import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingsScreens2 extends StatefulWidget {
  final int maxNumber;

  const SettingsScreens2({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingsScreens2> createState() => _SettingsScreens2State();
}

class _SettingsScreens2State extends State<SettingsScreens2> {
  double maxNumber = 10000; // state에 widget을 바로가져오지 못함.-> 미리 생성되어지기때문

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(maxNumber: maxNumber),
              _Footer(
                  maxNumber: maxNumber,
                  onChanged: onSliderChange,
                  onPressed: onButtomPressed),
            ],
          ),
        ),
      ),
    );
  }

  void onButtomPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }

  void onSliderChange(double value) {
    setState(() {
      maxNumber = value;
    });
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final VoidCallback onPressed;
  final ValueChanged<double> onChanged;

  const _Footer(
      {required this.maxNumber,
      required this.onChanged,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 1000000,
          onChanged: onChanged,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(primary: RED_COLOR),
          child: Text('저장'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;
  const SettingsScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    maxNumber = widget.maxNumber.toDouble();
    super.initState();
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
                onPressed: onButtomPressed,
                onChanged: onSliderChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onButtomPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }

  void onSliderChanged(double value) {
    setState(() {
      maxNumber = value;
    });
  }

}

class _Body extends StatelessWidget {
  final maxNumber;

  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: maxNumber
            .toInt()
            .toString()
            .split('')
            .map(
              (e) => Image.asset(
                'asset/img/$e.png',
                width: 50.0,
                height: 70.0,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final maxNumber;
  final VoidCallback onPressed;
  final ValueChanged<double>? onChanged;

  const _Footer(
      {required this.maxNumber,
      required this.onPressed,
      required this.onChanged,
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
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          child: Text('저장'),
        ),
      ],
    );
  }
}

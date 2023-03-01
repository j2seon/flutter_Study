import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {

  int leftDice = 1;
  int rightDice = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text('Dice'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset('image/dice$leftDice.png')
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset('image/dice$rightDice.png')
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            ButtonTheme(
              height: 60.0,
              minWidth: 100.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                ),
                onPressed:(){
                  setState(() {
                    leftDice = Random().nextInt(6)+1;
                    rightDice = Random().nextInt(6)+1;
                  });
                  showToast("Left dice : ${leftDice} , Right dice : ${rightDice}");
                },
                child: const Icon(Icons.play_arrow,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void showToast(String message){
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM
  );
}
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TestWiget(label: 'test1'),
            const TestWiget(label: 'test2'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  
                });
              },
              child: const Text('시작')
            ),
          ],
        ),
      ),
    );
  }
}

class TestWiget extends StatelessWidget {
  final String label;

  const TestWiget({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$label');
    return Container(
      child: Text(label),
    );
  }
}

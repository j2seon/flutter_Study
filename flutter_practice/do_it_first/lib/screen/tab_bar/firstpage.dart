import 'package:do_it_first/model/AnimalItem.dart';
import 'package:flutter/material.dart';

class FirstApp extends StatelessWidget {
  final List<Animal> list;

  const FirstApp({required this.list, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AlertDialog dialog = AlertDialog(
                    content: Text('이 동물은 ${list[index].kind}입니다.'),
                    title: Text('${list[index].animalName}'),

                  );
                  showDialog(context: context, builder: (context) => dialog);
                },
                child: Card(
                  child: Row(
                    children: [
                      Image.asset(
                        list[index].imagePath!,
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.contain,
                      ),
                      Text(list[index].animalName!),
                    ],
                  ),
                ),
              );
            },
            itemCount: list.length,
          ),
        ),
      ),
    );
  }
}

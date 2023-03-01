import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:naming_app/src/saved.dart';
import 'package:naming_app/src/bloc/bloc.dart';

class RandomList extends StatefulWidget {
  const RandomList({Key? key}) : super(key: key);

  @override
  State<RandomList> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naming App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SavedList(),
                )).then((value) {setState(() {},);
                },
              );
            },
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: _bulidList(),
    );
  }

  Widget _bulidList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        var saved = snapshot.hasData ? snapshot.data : Set<WordPair>();
        return ListView.builder(
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider();
            }
            var realIndex = index ~/ 2; //몫

            if (realIndex >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
              return _buildRow(snapshot.data, _suggestions[realIndex]);

          },
        );
      }
    );
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    final bool alreadySaved = saved==null ? false : saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        //클릭
         bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}

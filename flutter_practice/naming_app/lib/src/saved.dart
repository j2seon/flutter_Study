import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:naming_app/src/bloc/bloc.dart';

class SavedList extends StatefulWidget {
  SavedList({Key? key}) : super(key: key);

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SavedList'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemBuilder: (context, index) {
            if(index.isOdd)
              return Divider();

            var realIndex = index ~/2;
            return _buildRow(snapshot.data?.toList()[realIndex]);
          },
          itemCount: snapshot.data.length,
        );
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: (){
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}

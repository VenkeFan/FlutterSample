import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Title",
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _saved = Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    print("---------> initState");
  }

  @override
  void didUpdateWidget(RandomWords oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("---------> didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("---------> dispose");
  }

  // Override
  @override
  Widget build(BuildContext context) {
    print("---------> state build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        leading: IconButton(
          icon: Icon(Icons.search),
          tooltip: "Search",
          onPressed: null,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  // Private Method
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          print("---------> setState");
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
  
  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((WordPair pair) {
        return ListTile(
            title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ));
      });

      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      
      return Scaffold(
        appBar: AppBar(
          title: Text("Saved Suggestions"),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}

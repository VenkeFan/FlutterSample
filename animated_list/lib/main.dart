import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(new AnimatedListSample());

class AnimatedListSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem, _nextItem;

  @override
  void initState() {
    print("_AnimatedListSampleState initState\n");
    super.initState();

    _list = ListModel<int>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
      initialItems: <int>[0, 1, 2]
    );
  
    _nextItem = 3;
  }

  @override
  Widget build(BuildContext context) {
    print("_AnimatedListSampleState build\n");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AnimatedList"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: "insert a new item",
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _remove,
              tooltip: "remove the selected item",
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }

  // Private
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    print("_AnimatedListSampleState _buildItem\n");
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(int item, BuildContext context, Animation<double> animation) {
    print("_AnimatedListSampleState _buildRemovedItem\n");
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
    );
  }

  void _insert() {
    print("_AnimatedListSampleState _insert\n");
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    print("_AnimatedListSampleState _remove\n");
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }
}

class ListModel<E> {
  ListModel({@required this.listKey, @required this.removedItemBuilder, Iterable<E> initialItems})
   : assert(listKey != null), assert(removedItemBuilder != null), _items = List<E>.from(initialItems) ?? <E>[];

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  // Public
  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (null != removedItem) {
      _animatedList.removeItem(index, (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.animation,
    this.onTap,
    @required this.item,
    this.selected : false
  }) : assert(animation != null), assert(item != null && item >= 0), assert(selected != null), super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    print("CardItem build: $item\n");
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 128.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text("Item $item", style: textStyle,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
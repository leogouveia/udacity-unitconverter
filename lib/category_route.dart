import 'package:flutter/material.dart';
import 'package:udacity1/category.dart';
import 'package:udacity1/unit.dart';

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  State<StatefulWidget> createState() {
    return _CategoryRouteState();
  }
}

class _CategoryRouteState extends State<CategoryRoute> {
  final _categories = <Category>[];

  static const _appBarTitle = 'Unit Converter';

  static final _backgroundColor = Colors.green[100];

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    setState(() {
      _buildCategories();
    });
  }

  ListView _buildCategoryWidgets() {
    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (BuildContext context, int index) => _categories[index],
    );
  }

  void _buildCategories() {
    for (var index = 0; index < _categoryNames.length; index++) {
      _categories.add(
        Category(
          name: _categoryNames[index],
          color: _baseColors[index],
          iconLocation: Icons.cake,
          units: _retrieveUnitList(_categoryNames[index]),
        ),
      );
    }
  }

  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(),
    );

    final appBar = AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: _backgroundColor,
      title: Text(
        _appBarTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}

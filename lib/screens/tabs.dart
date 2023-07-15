import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/main_drawer.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';

import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedstate = 0;
  final List<Meal> _favouritemeal = [];

  void _showmessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _togglemealstatus(Meal meal) {
    final isExisiting = _favouritemeal.contains(meal);
    if (isExisiting == true) {
      setState(() {
        _favouritemeal.remove(meal);
        _showmessage('The meal is removed from favourites');
      });
    } else {
      setState(() {
        _favouritemeal.add(meal);
        _showmessage('The meal is added to favourites');
      });
    }
  }

  void _selectpage(int index) {
    setState(() {
      _selectedstate = index;
    });
  }

  void _setscreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const FilterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget active = CategoriesScreen(
      togglemeal: _togglemealstatus,
    );
    var activepagetitle = 'Categories';

    if (_selectedstate == 1) {
      active = MealsScreen(
        meals: _favouritemeal,
        ontogglemeal: _togglemealstatus,
      );

      activepagetitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer: MainDrawer(
        onselectscreen: _setscreen,
      ),
      body: active,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        currentIndex: _selectedstate,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}

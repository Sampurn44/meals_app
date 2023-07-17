import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/main_drawer.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/provider/meal_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

import '../models/meal.dart';

const kfilters = {
  Filter.glutonfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedstate = 0;
  Map<Filter, bool> _selectedfilter = kfilters;

  void _selectpage(int index) {
    setState(() {
      _selectedstate = index;
    });
  }

  void _setscreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
            builder: (ctx) => FilterScreen(
                  currentFilters: _selectedfilter,
                )),
      );
      setState(() {
        _selectedfilter = result ?? kfilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final availablemeal = meals.where((meal) {
      if (_selectedfilter[Filter.glutonfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedfilter[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedfilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedfilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Widget active = CategoriesScreen(
      availablemeal: availablemeal,
    );
    var activepagetitle = 'Categories';

    if (_selectedstate == 1) {
      final favouritemeal = ref.watch(mealProvider);
      active = MealsScreen(
        meals: favouritemeal,
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

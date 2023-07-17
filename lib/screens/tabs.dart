import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/main_drawer.dart';
import 'package:meals_app/provider/favourites_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/provider/meal_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void _selectpage(int index) {
    setState(() {
      _selectedstate = index;
    });
  }

  void _setscreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeal = ref.watch(FilteredMealProvider);
    Widget active = CategoriesScreen(
      availablemeal: availablemeal,
    );
    var activepagetitle = 'Categories';

    if (_selectedstate == 1) {
      final favouritemeal = ref.watch(mealsProvider);
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

import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/category_grid.dart';
import 'package:meals_app/data/dummy_data.dart';
//import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.togglemeal, required this.availablemeal});

  final void Function(Meal meal) togglemeal;
  final List<Meal> availablemeal;

  void _selectedcategory(BuildContext context, Category category) {
    final filteredMeals = availablemeal
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          ontogglemeal: togglemeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryGridItems(
            category: category,
            onSelectCategory: () {
              _selectedcategory(context, category);
            },
          ),
      ],
    );
  }
}

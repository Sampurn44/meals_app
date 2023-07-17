import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meal_provider.dart';

enum Filter {
  glutonfree,
  lactosefree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutonfree: false,
          Filter.lactosefree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });
  void setFilters(Map<Filter, bool> chosenfilter) {
    state = chosenfilter;
  }

  void Setfilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final FilteredMealProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activefilter = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activefilter[Filter.glutonfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilter[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activefilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});

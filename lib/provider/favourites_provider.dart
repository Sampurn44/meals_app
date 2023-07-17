import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class favouriteNotifier extends StateNotifier<List<Meal>> {
  favouriteNotifier() : super([]);
  bool togglemealdata(Meal meal) {
    final mealisfav = state.contains(meal);
    if (mealisfav) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final mealsProvider =
    StateNotifierProvider<favouriteNotifier, List<Meal>>((ref) {
  return favouriteNotifier();
});

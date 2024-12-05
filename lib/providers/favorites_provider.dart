import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/meal.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]);

  bool addRemoveFavorite(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((lMeal) => lMeal.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) {
  return FavoriteMealNotifier();
});

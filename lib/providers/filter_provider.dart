import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactosFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactosFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool active) {
    state = {
      ...state,
      filter: active,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final filteredMealProvider = Provider((ref){
  final meals = ref.watch(mealsProvider);
  final selectedFilter = ref.watch(filterProvider);
  return meals.where((meal) {
      if (selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilter[Filter.lactosFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
});

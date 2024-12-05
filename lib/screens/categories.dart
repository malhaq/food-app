import 'package:flutter/material.dart';

import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/category_grid_items.dart';
import 'package:food_app/screens/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

 
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMealsList = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: filteredMealsList,
          title: category.title,
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
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItems(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}

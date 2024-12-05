import 'package:flutter/material.dart';
// import 'package:food_app/data/dummy_data.dart';
// import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/filters.dart';
import 'package:food_app/screens/meals.dart';
import 'package:food_app/widgets/main_drawer.dart';
import 'package:food_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/favorites_provider.dart';

const kInitFilter = {
  Filter.glutenFree: false,
  Filter.lactosFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreen();
  }
}

class _TabScreen extends ConsumerState<TabScreen> {
  int _selectedTabIndex = 0;
  Map<Filter, bool> _selectedFilter = kInitFilter;

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilter: _selectedFilter),
        ),
      );
      setState(() {
        _selectedFilter = result ?? kInitFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactosFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activeTab = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activeTabTitle = 'Categories';

    if (_selectedTabIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      activeTab = MealsScreen(
        meals: favoriteMeals,
      );
      activeTabTitle = 'Favorite meals';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTabTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activeTab,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _selectedTabIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorits'),
        ],
      ),
    );
  }
}

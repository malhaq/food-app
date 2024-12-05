import 'package:flutter/material.dart';
import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/filters.dart';
import 'package:food_app/screens/meals.dart';
import 'package:food_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/favorites_provider.dart';
import 'package:food_app/providers/filter_provider.dart';

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

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealProvider);
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

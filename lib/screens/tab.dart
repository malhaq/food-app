import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/filters.dart';
import 'package:food_app/screens/meals.dart';
import 'package:food_app/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreen();
  }
}

class _TabScreen extends State<TabScreen> {
  int _selectedTabIndex = 0;
  final List<Meal> _favorites = [];

  void _showInfoMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void _addRemoveFavorite(Meal meal) {
    setState(() {
      if (_favorites.contains(meal)) {
        _favorites.remove(meal);
        _showInfoMessage('Removed from favorites');
      } else {
        _favorites.add(meal);
        _showInfoMessage('Added to favorites');
      }
    });
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FilterScreen(),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeTab = CategoriesScreen(
      onToggleFav: _addRemoveFavorite,
    );
    var activeTabTitle = 'Categories';

    if (_selectedTabIndex == 1) {
      activeTab = MealsScreen(
        meals: _favorites,
        onToggleFav: _addRemoveFavorite,
      );
      activeTabTitle = 'Favorite meals';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTabTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
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

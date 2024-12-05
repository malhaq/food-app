import 'package:flutter/material.dart';
import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/meals.dart';

class TabScreen extends StatefulWidget{
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreen();
  }

}

class _TabScreen extends State<TabScreen>{
  int _selectedTabIndex = 0;

  void _selectTab(int index){
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeTab = const  CategoriesScreen();
    var activeTabTitle = 'Categories';

    if(_selectedTabIndex ==1){
      activeTab = MealsScreen(meals: []);
      activeTabTitle = 'Favorite meals';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTabTitle),
      ),
      body: activeTab,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _selectedTabIndex,
        items:const [
          BottomNavigationBarItem(icon:Icon(Icons.food_bank) ,label:'Categories' ),
          BottomNavigationBarItem(icon:Icon(Icons.favorite),label:'Favorits' ),
        ],
      ),
    );
  }

}
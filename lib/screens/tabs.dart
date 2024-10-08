import 'package:flutter/material.dart';
import 'package:food_app/screens/category.dart';
import 'package:food_app/screens/foods.dart';
import '../models/food.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Food> _favoriteFoods = [];

  void _toggleFoodFavoriteStatus(Food food){
    final isExisting = _favoriteFoods.contains(food);
    if (isExisting){
      setState(() {
        _favoriteFoods.remove(food);
      });

    }else{
      _favoriteFoods.add(food);
    }
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(onToggleFavorite: _toggleFoodFavoriteStatus,);
    var activePageTitle = "Categories";
    if(_selectedPageIndex == 1) {
      activePage = FoodsScreen(foods: _favoriteFoods, onToggleFavorite: _toggleFoodFavoriteStatus,);
      activePageTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: Colors.red,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          unselectedItemColor: Colors.grey[400],
          unselectedLabelStyle: TextStyle(color: Colors.grey[400]),

          items: const [BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
      ]),
      body: activePage,
    );

  }
}

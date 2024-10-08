import 'package:flutter/material.dart';
import 'package:food_app/screens/category.dart';
import 'package:food_app/screens/filter.dart';
import 'package:food_app/screens/foods.dart';
import 'package:food_app/widgets/main_drawer.dart';
import '../models/food.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Food> _favoriteFoods = [];

  void _showInfoMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
            ))));
  }

  void _toggleFoodFavoriteStatus(Food food) {
    final isExisting = _favoriteFoods.contains(food);
    if (isExisting) {
      setState(() {
        _favoriteFoods.remove(food);
      });
      _showInfoMessage("Food is no longer a favorite...");
    } else {
      _favoriteFoods.add(food);
      _showInfoMessage("Marked as a favorite...");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) {
    if (identifier == "filters") {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggleFavorite: _toggleFoodFavoriteStatus,
    );
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = FoodsScreen(
        foods: _favoriteFoods,
        onToggleFavorite: _toggleFoodFavoriteStatus,
      );
      activePageTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: (identifier) {
        _selectScreen(identifier);
      },),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: Colors.red,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          unselectedItemColor: Colors.grey[400],
          unselectedLabelStyle: TextStyle(color: Colors.grey[400]),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
          ]),
      body: activePage,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/screens/category.dart';
import 'package:food_app/screens/filter.dart';
import 'package:food_app/screens/foods.dart';
import 'package:food_app/widgets/main_drawer.dart';
import '../models/food.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Food> _favoriteFoods = [];
  Map<Filter, bool> _selectedFilter = kInitialFilters;

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

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
     final result = await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (context) => FilterScreen(currentFilter: _selectedFilter),));
     print(result);

     setState(() {
       _selectedFilter = result ?? kInitialFilters;
     });
    }
  }

  @override
  Widget build(BuildContext context) {

    final availableFoods = dummyFoods.where((food){
      if (_selectedFilter[Filter.glutenFree]! && !food.isGlutenFree){
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !food.isLactoseFree){
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !food.isVegetarian){
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !food.isVegan){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoryScreen(
      onToggleFavorite: _toggleFoodFavoriteStatus,
      availableFood: availableFoods,
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

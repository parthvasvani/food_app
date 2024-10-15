import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/providers/favorite_foods_notifier.dart';
import 'package:food_app/providers/foods_provider.dart';
import 'package:food_app/screens/category.dart';
import 'package:food_app/screens/filter.dart';
import 'package:food_app/screens/foods.dart';
import 'package:food_app/widgets/main_drawer.dart';
import '../models/food.dart';
import '../providers/filter_notifier.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) => const FilterScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    final foods = ref.watch(foodsProvider);
    final activeFilters = ref.watch(filterProvider);
    final availableFood = foods.where((food) {
      if (activeFilters[Filter.glutenFree]! && !food.isGlutenFree){
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !food.isLactoseFree){
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !food.isVegetarian){
        return false;
      }
      if (activeFilters[Filter.vegan]! && !food.isVegan){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoryScreen(
      availableFood: availableFood,
    );
    var activePageTitle = "Categories";
    final favoriteFoods = ref.watch(favoriteFoodProvider);
    if (_selectedPageIndex == 1) {
      activePage = FoodsScreen(
        foods: favoriteFoods,
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

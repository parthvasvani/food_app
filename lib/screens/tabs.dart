import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/favorite_foods_notifier.dart';
import 'package:food_app/screens/category.dart';
import 'package:food_app/screens/filter.dart';
import 'package:food_app/screens/foods.dart';
import 'package:food_app/widgets/main_drawer.dart';
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
        builder: (context) => const FilterScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableFoods = ref.watch(filterFoodProvider);
    Widget activePage = CategoryScreen(
      availableFood: availableFoods,
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
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          _selectScreen(identifier);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            gradient: LinearGradient(
                colors: [
              Theme.of(context).colorScheme.onTertiaryFixed.withOpacity(0.2),
              Colors.white38,
            ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
            ),
          ),
          child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              onTap: _selectPage,
              currentIndex: _selectedPageIndex,
              selectedItemColor: Theme.of(context).colorScheme.tertiary,
              selectedFontSize: 18,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              items: [
                BottomNavigationBarItem(
                    backgroundColor: Colors.red,
                    icon: _buildIcon(Icons.set_meal, 0),
                    label: "Categories"),
                BottomNavigationBarItem(
                    icon: _buildIcon(Icons.favorite, 1),
                    label: "Favorites"),
              ]),
        ),
      ),
      body: activePage,
    );
  }


  Widget _buildIcon(IconData iconData, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
        _selectedPageIndex == index ? Colors.lightGreen : Colors.transparent,
      ),
      height: 25,
      width: 50,
      child: Icon(
        iconData,
        color: _selectedPageIndex == index ? Colors.white : Colors.grey,
      ),
    );
  }
}



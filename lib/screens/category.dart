import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/widgets/category_grid_item.dart';
import '../models/food.dart';
import 'foods.dart';

class CategoryScreen extends StatelessWidget {
  final void Function(Food food) onToggleFavorite;

  const CategoryScreen({super.key, required this.onToggleFavorite});

  void _selectCategory(BuildContext context, Category category) {
    final filteredFoods = dummyFoods
        .where(
          (food) => food.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (content) => FoodsScreen(
              title: category.title,
              foods: filteredFoods,
              onToggleFavorite: onToggleFavorite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget myGridView = GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),
        shrinkWrap: true,
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                selectCategory: () {
                  _selectCategory(context, category);
                })
        ]);

    if (width > 600) {
      myGridView = GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1 / .5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              selectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: myGridView
    );
  }
}

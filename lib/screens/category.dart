import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/widgets/category_grid_item.dart';
import 'foods.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filteredFoods = dummyFoods
        .where(
          (food) => food.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (content) =>
            FoodsScreen(title: category.title, foods: filteredFoods)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Pick your Category"),
      ),
      body: GridView(
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                  category: category,
                  selectCategory: () {
                    _selectCategory(context, category);
                  })
          ]),
    );
  }
}

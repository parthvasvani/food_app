import 'package:flutter/material.dart';
import 'package:food_app/widgets/food_item.dart';
import '../models/food.dart';

class FoodsScreen extends StatelessWidget {
  final String title;
  final List<Food> foods;
  const FoodsScreen({super.key, required this.title, required this.foods});

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "nothing here!",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.surfaceTint),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting a different category",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.surfaceTint),
          )
        ],
      ),
    );

    if (foods.isNotEmpty) {
      mainContent = ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            return FoodItem(food: foods[index]);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: mainContent,
    );
  }
}

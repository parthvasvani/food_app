import 'package:flutter/material.dart';
import 'package:food_app/widgets/food_item.dart';
import '../models/food.dart';
import 'food_details.dart';

class FoodsScreen extends StatelessWidget {
  final String? title;
  final List<Food> foods;

  const FoodsScreen(
      {super.key,
      this.title,
      required this.foods,

      });

  void selectedFood(BuildContext content, Food food) {
    Navigator.of(content).push(MaterialPageRoute(
      builder: (content) => FoodDetailsScreen(
        food: food,
      ),
    ));
  }

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
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting a different category",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.surfaceTint),
          )
        ],
      ),
    );

    if (foods.isNotEmpty) {
      mainContent = ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            return FoodItem(
              food: foods[index],
              onSelectFood: (food) {
                selectedFood(context, food);
              },
            );
          });
    }

    if (title == null){
      return mainContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: mainContent,
    );
  }
}

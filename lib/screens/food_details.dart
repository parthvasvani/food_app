import 'package:flutter/material.dart';
import '../models/food.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Food food;
  final void Function(Food food) onToggleFavorite;

  const FoodDetailsScreen(
      {super.key, required this.food, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.title),
        actions: [
          IconButton(
              onPressed: () => onToggleFavorite(food),
              icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              food.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Ingredient",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredient in food.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium! .copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final step in food.steps)
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

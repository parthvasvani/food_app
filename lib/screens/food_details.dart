import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/food.dart';
import '../providers/favorite_foods_notifier.dart';

class FoodDetailsScreen extends ConsumerWidget {
  final Food food;

  const FoodDetailsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteFoods = ref.watch(favoriteFoodProvider);
    final isFavorites = favoriteFoods.contains(food);
    return Scaffold(
      appBar: AppBar(
        title: Text(food.title),
        actions: [
          IconButton(
              onPressed: () {
                var wasAdded = ref
                    .read(favoriteFoodProvider.notifier)
                    .toggleFoodFavoriteStatus(food);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? "Food added as a Favorites."
                        : "Food removed.")));
              },
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns:
                          Tween<double>(begin: 0.1, end: 1).animate(animation),
                      child: child,
                    );
                  },
                  child: Icon(
                      key: ValueKey(isFavorites),
                      isFavorites ? Icons.favorite : Icons.favorite_border)))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: food.id,
              child: Image.network(
                food.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
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
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

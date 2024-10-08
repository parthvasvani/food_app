import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/food.dart';
import 'food_item_trail.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  final void Function(Food food) onSelectFood;

  const FoodItem({super.key, required this.food, required this.onSelectFood});

  String get complexityText {
    return food.complexity.name[0].toUpperCase() +
        food.complexity.name.substring(1);
  }

  String get affordabilityText {
    return food.complexity.name[0].toUpperCase() +
        food.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget myContent = Stack(
      children: [
        InkWell(
          onTap: () {
            onSelectFood(food);
          },
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(food.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Theme.of(context).colorScheme.surfaceDim.withOpacity(0.55),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
            child: Column(
              children: [
                Text(
                  food.title,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FoodItemTrail(
                      icon: Icons.schedule,
                      label: "${food.duration} min",
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    FoodItemTrail(icon: Icons.work, label: complexityText),
                    const SizedBox(
                      width: 12,
                    ),
                    FoodItemTrail(
                        icon: Icons.attach_money, label: affordabilityText)
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );

    if (width > 600) {
      myContent = Row(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(food.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: 200,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 20),
            height: 200,
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  food.title,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                Container(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceDim
                      .withOpacity(0.99),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 44),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FoodItemTrail(
                        icon: Icons.schedule,
                        label: "${food.duration} min",
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      FoodItemTrail(icon: Icons.work, label: complexityText),
                      const SizedBox(
                        width: 12,
                      ),
                      FoodItemTrail(
                          icon: Icons.attach_money, label: affordabilityText)
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: myContent,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/food.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  const FoodItem({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(food.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).colorScheme.surfaceDim.withOpacity(0.55),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
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
                      color: Theme.of(context).colorScheme.onSecondaryContainer),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

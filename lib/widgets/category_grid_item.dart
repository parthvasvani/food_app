import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final void Function() selectCategory;

  const CategoryGridItem({super.key, required this.category, required this.selectCategory});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectCategory,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              category.color.withOpacity(0.60),
              category.color.withOpacity(0.8)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.surfaceTint),
        ),
      ),
    );
  }
}

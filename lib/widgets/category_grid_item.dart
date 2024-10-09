import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final void Function() selectCategory;

  const CategoryGridItem({super.key, required this.category, required this.selectCategory});

  @override
  Widget build(BuildContext context) {
    Widget myCategory = Container(
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
    );

    if (category.imageCategory != null) {
      myCategory = Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(fit: StackFit.expand, children: [
          FadeInImage(placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage("${category.imageCategory}"),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.40),
                child: Text(
                  category.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.tertiaryContainer),
                ),
              ),)
        ],

        ),
      );
    }

    return InkWell(
      onTap: selectCategory,
      child: myCategory,
    );
  }
}

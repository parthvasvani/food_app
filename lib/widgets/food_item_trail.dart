import 'package:flutter/material.dart';

class FoodItemTrail extends StatelessWidget {
  final IconData icon;
  final String label;

  const FoodItemTrail({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
            icon,
          size: 17,
          color: Colors.black,
        ),
        const SizedBox(width: 6,),
        Text(label, style: const TextStyle(color: Colors.black),)
      ],
    );
  }
}

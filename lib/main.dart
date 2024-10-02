import 'package:flutter/material.dart';
import 'package:food_app/screens/category.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
      seedColor: Color.fromARGB(97, 207, 207, 110)
  ),
);

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Category(),
    );
  }
}

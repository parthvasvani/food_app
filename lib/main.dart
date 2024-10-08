import 'package:flutter/material.dart';
import 'package:food_app/screens/tabs.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
      seedColor: const Color.fromRGBO(97, 97, 97, 1)
  ),
  textTheme: GoogleFonts.latoTextTheme());

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsScreen(),
    );
  }
}

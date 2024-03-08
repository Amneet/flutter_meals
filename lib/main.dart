import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';

//Creates an overall theme of the app with set color scheme and text scheme
final theme = ThemeData(
  //creates a color scheme which can be used throughout the app
  colorScheme: ColorScheme.fromSeed(
    //seedcolor means that the overall theme should be based on the color provided
    seedColor: const Color.fromARGB(255, 131, 57, 0),
    //brightness dark means that the app would have a dark theme overall. Can change to light if you want a light mode.
    brightness: Brightness.dark,
  ),
  //imported google fonts and then used its lato text font throughtout the app
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    //if we are using Providers, we need to wrap the App's starting point with ProviderScope
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}

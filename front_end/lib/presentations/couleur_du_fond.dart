import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dégradé utilisé pour le fond de l'application

    return Scaffold(
      // Dégradé de fond appliqué à toute l'application
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
        ),
      ),
    );
  }
}

class CouleurDuFond {
  static const LinearGradient gradientBackground = LinearGradient(
    colors: [
      Color(0xff2F3F6D),
      Color(0xff5693AD),
      Color(0xff6ABDCE),
      Color(0xff7EE7EE),
    ],
    stops: [0.0, 0.53, 0.75, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

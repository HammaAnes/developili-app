import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dégradé utilisé pour le fond de l'application
    const gradientBackground = LinearGradient(
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

    return Scaffold(
      // Dégradé de fond appliqué à toute l'application
      body: Container(
        decoration: BoxDecoration(
          gradient: gradientBackground, // Applique le même gradient que l'app
        ),
        child: Column(
          children: [
            // AppBar avec fond transparent, barre de recherche blanche, et icônes visibles
            PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBar(
                backgroundColor: Colors.transparent, // AppBar transparente
                elevation: 0,
                leading: IconButton(
                  icon: Image.asset(
                    'lib/icons/menu.png',
                    color: Colors
                        .white, // Icône en utilisant une image personnalisée
                    width: 30, // Ajuste la taille de l'image
                    height: 30, // Ajuste la taille de l'image
                  ),
                  onPressed: () {
                    // Action pour le bouton de menu
                  },
                ),
                title: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        Colors.white, // Fond blanc pour la barre de recherche
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Rechercher...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search,
                        color: Colors.white), // Icône en blanc
                    onPressed: () {
                      // Action pour le bouton de recherche
                    },
                  ),
                ],
              ),
            ),
            // Icônes sous la barre de recherche
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Premier bouton avec une image personnalisée
                  IconButton(
                    icon: Image.asset(
                      'lib/icons/iphone_full.png',
                      color: Colors.white, // Remplace par ton image
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      // Action pour le premier bouton
                    },
                  ),
                  const SizedBox(width: 30), // Espace entre les icônes
                  // Deuxième bouton avec une image personnalisée
                  IconButton(
                    icon: Image.asset(
                      'lib/icons/web_full.png',
                      color: Colors.white, // Remplace par ton image
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      // Action pour le deuxième bouton
                    },
                  ),
                  const SizedBox(width: 30), // Espace entre les icônes
                  // Troisième bouton avec une image personnalisée
                  IconButton(
                    icon: Image.asset(
                      'lib/icons/screen_full.png',
                      color: Colors.white, // Remplace par ton image
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      // Action pour le troisième bouton
                    },
                  ),
                ],
              ),
            ),
            // Le reste de votre contenu peut aller ici...
            const Expanded(
              child: Center(
                child: Text(
                  "Contenu de l'application",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
      // Footer avec 5 icônes fixes en bas de l'écran
      bottomNavigationBar: Container(
        // Appliquer le même gradient de fond sans bordure
        decoration: BoxDecoration(
          gradient:
              gradientBackground, // Applique le même gradient que l'application
          // Il n'y a plus de bordure ou de shadow ici, ce qui évite une ligne
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Premier bouton du footer
              IconButton(
                icon: Image.asset(
                  'lib/icons/home_full.png',
                  color: Colors.white, // Remplace par ton image
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  // Action pour le premier bouton
                },
              ),
              // Deuxième bouton du footer
              IconButton(
                icon: Image.asset(
                  'lib/icons/clock_full.png',
                  color: Colors.white, // Remplace par ton image
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  // Action pour le deuxième bouton
                },
              ),
              // Troisième bouton du footer
              IconButton(
                icon: Image.asset(
                  'lib/icons/add.png',
                  color: Colors.white, // Remplace par ton image
                  width: 50,
                  height: 50,
                ),
                onPressed: () {
                  // Action pour le troisième bouton
                },
              ),
              // Quatrième bouton du footer
              IconButton(
                icon: Image.asset(
                  'lib/icons/chat_full.png',
                  color: Colors.white, // Remplace par ton image
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  // Action pour le quatrième bouton
                },
              ),
              // Cinquième bouton du footer
              IconButton(
                icon: Image.asset(
                  'lib/icons/user_full.png',
                  color: Colors.white, // Remplace par ton image
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  // Action pour le cinquième bouton
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

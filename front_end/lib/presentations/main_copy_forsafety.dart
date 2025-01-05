import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé
import 'profile_dev.dart';

void main() {
  runApp(const MyAppMain());
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedTileIndex; // Indice du ListTile sélectionné

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dégradé de fond appliqué à toute l'application
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
        ),
        child: Column(
          children: [
            // AppBar avec fond transparent, barre de recherche blanche, et icônes visibles
            PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBar(
                backgroundColor: Colors.transparent, // AppBar transparente
                elevation: 0,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Image.asset(
                      'lib/icons/menu.png',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      // Ouvre la sidebar
                      Scaffold.of(context).openDrawer();
                    },
                  ),
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 14),
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
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
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
                  color: Colors.white,
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
                  color: Colors.white,
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
                  color: Colors.white,
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
                  color: Colors.white,
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
                  color: Colors.white,
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // Ajout de la Drawer
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff314270),
                Color(0xff5E7ED6),
              ],
              stops: [0.1, 0.73],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    // Cercle Avatar
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          print('Photo de profil ou bouton cliqué');
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: const AssetImage(
                            'lib/images/profile_placeholder.png',
                          ),
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    // Icône pour fermer ou revenir à la page
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Ferme le Drawer
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // ListTiles avec état sélectionné
              buildSelectableTile(
                index: 0,
                icon: Icons.home,
                text: 'Home',
              ),
              buildSelectableTile(
                index: 1,
                icon: Icons.settings,
                text: 'Settings',
              ),
              buildSelectableTile(
                index: 2,
                icon: Icons.info,
                text: 'About',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour créer un ListTile sélectionnable
  Widget buildSelectableTile(
      {required int index, required IconData icon, required String text}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      tileColor: selectedTileIndex == index
          ? const Color(0xFF464667) // Couleur sélectionnée
          : Colors.transparent, // Couleur normale
      onTap: () {
        setState(() {
          selectedTileIndex = index; // Mettre à jour l'état
        });
      },
    );
  }
}

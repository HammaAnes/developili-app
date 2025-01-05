import 'dart:ui'; // Pour appliquer l'effet de flou
import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé
import 'main_client.dart';
import 'chat_client.dart';
import 'profile_client.dart';

// Modèle de données
class Item {
  final String iconPath;
  final String title;
  final double price;

  Item({required this.iconPath, required this.title, required this.price});
}

void main() {
  runApp(const MyAppMain());
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wallet(),
    );
  }
}

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  // Méthode pour afficher l'image au format modale
  void _showImageDialog(BuildContext context, String imagePath, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context)
              .pop(), // Ferme le zoom en cliquant en dehors
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: imagePath,
                      child: Image.asset(
                        imagePath,
                        width: 350,
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Liste simulée d'éléments récupérés de la base de données
  List<Item> getItems() {
    return [
      Item(iconPath: 'lib/icons/Logo_Google.png', title: 'Item 1', price: 1200),
      Item(iconPath: 'lib/icons/apple-logo.png', title: 'Item 2', price: 12000),
      Item(iconPath: 'lib/icons/visa.png', title: 'Item 3', price: 100000),
      // Ajoutez ici des éléments récupérés depuis votre base de données
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond
              .gradientBackground, // Fond dégradé sur toute la page
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Votre AppBar et autres éléments
                    AppBar(
                      backgroundColor:
                          Colors.transparent, // AppBar transparente
                      elevation: 0,
                      leading: IconButton(
                        icon: Image.asset(
                          'lib/icons/menu.png',
                          color: Colors.white, // Icône personnalisée
                          width: 30,
                          height: 30,
                        ),
                        onPressed: () {
                          // Action pour le bouton de menu
                        },
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.image, color: Colors.white),
                          onPressed: () {
                            // Action pour le bouton de recherche
                          },
                        ),
                      ],
                    ),
                    // Boutons (écran initial comme dans votre code précédent)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26.0, vertical: 20.0),
                      child: const Text(
                        'Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          // Premier bouton avec image et texte
                          GestureDetector(
                            onTap: () {
                              _showImageDialog(
                                context,
                                'lib/icons/Info_section_blue.png',
                                "Balance",
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Hero(
                                  tag: 'lib/icons/Info_section_blue.png',
                                  child: Image.asset(
                                    'lib/icons/Info_section_blue.png',
                                    width: 311,
                                    height: 219,
                                  ),
                                ),
                                const Text(
                                  "Balance",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Ajouter les deux icônes cliquables au centre
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Bouton Payment
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print("Payments clicked");
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            print("Payments clicked");
                                          },
                                          splashColor: Colors.blue.withOpacity(
                                              0.3), // Effet de vague
                                          highlightColor: Colors.blue.withOpacity(
                                              0.5), // Changement de couleur sur clic
                                          child: Image.asset(
                                            'lib/icons/export.png',
                                            width: 70,
                                            height: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Payments",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 40),
                                // Bouton Recharge
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print("Recharge clicked");
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            print("Recharge clicked");
                                          },
                                          splashColor:
                                              Colors.blue.withOpacity(0.3),
                                          highlightColor:
                                              Colors.blue.withOpacity(0.5),
                                          child: Image.asset(
                                            'lib/icons/add-circle.png',
                                            width: 70,
                                            height: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Recharge",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Liste des éléments à ajouter sous les boutons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Titre de la section liste
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Recent Transactions", // Exemple de titre de section
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Liste d'éléments
                          ListView.builder(
                            shrinkWrap:
                                true, // Empêche la liste de prendre tout l'espace
                            itemCount: getItems().length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = getItems()[index];

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: ListTile(
                                  leading: Image.asset(item.iconPath,
                                      width: 30, height: 30),
                                  title: Text(
                                    item.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  trailing: Text(
                                    '${item.price.toStringAsFixed(2)}\$', // Affiche le prix formaté
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    // Action au clic sur un élément de la liste
                                    print("${item.title} clicked");
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Footer avec icônes fixes
            Container(
              decoration: BoxDecoration(
                gradient: CouleurDuFond.gradientBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'lib/icons/home_full.png',
                        color: Colors.white,
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ClientMain()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'lib/icons/clock_full.png',
                        color: Colors.white,
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        'lib/icons/add.png',
                        color: Colors.white,
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        'lib/icons/chat_full.png',
                        color: Colors.white,
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatPage()),
                        );
                      },
                    ),
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
                              builder: (context) => ProfilePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

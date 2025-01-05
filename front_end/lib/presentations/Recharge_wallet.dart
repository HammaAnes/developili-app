import 'dart:ui'; // Pour appliquer l'effet de flou
import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé
import 'main_client.dart';
import 'chat_client.dart';
import 'profile_client.dart';

void main() {
  runApp(const MyAppMain());
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Recharge_Wallet(),
    );
  }
}

class Recharge_Wallet extends StatelessWidget {
  const Recharge_Wallet({super.key});

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
              // Flou de l'arrière-plan
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              // Image zoomée
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
                    // AppBar avec fond transparent
                    PreferredSize(
                      preferredSize: const Size.fromHeight(100),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          icon: Image.asset(
                            'lib/icons/menu.png',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    // Titre sous l'AppBar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26.0, vertical: 25.0),
                      child: const Text(
                        'Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Boutons avec image + texte
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
                                // Premier bouton Payment avec effet ripple et couleur changeante lors du clic
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
                                            // Action pour le bouton Payments
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
                                // Premier bouton Payment avec effet ripple et couleur changeante lors du clic
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
                                            // Action pour le bouton Payments
                                            print("Recharge clicked");
                                          },
                                          splashColor: Colors.blue.withOpacity(
                                              0.3), // Effet de vague
                                          highlightColor: Colors.blue.withOpacity(
                                              0.5), // Changement de couleur sur clic
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
                          const SizedBox(height: 20),
                          // Deuxième bouton avec image et texte
                          GestureDetector(
                            onTap: () {
                              _showImageDialog(
                                context,
                                'lib/icons/info_section_blue_ciel.png',
                                "Enter The Code",
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Hero(
                                  tag: 'lib/icons/info_section_blue_ciel.png',
                                  child: Image.asset(
                                    'lib/icons/info_section_blue_ciel.png',
                                    width: 311,
                                    height: 219,
                                  ),
                                ),
                                const Text(
                                  "Enter The Code",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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

import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé
import 'main_client.dart';
import 'chat_client.dart';
import 'profile_client.dart';
import 'Wallet.dart';

void main() {
  runApp(const MyAppMain());
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Payments(),
    );
  }
}

class Payments extends StatelessWidget {
  const Payments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dégradé de fond appliqué à toute l'application
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            const SizedBox(height: 30),

            // Titre Payments
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Liste des boutons
            Expanded(
              child: Column(
                children: [
                  _buildSettingsButton(
                    imagePath: 'lib/icons/profile_settings.png',
                    text: "Profile",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 15), // Espacement entre les boutons
                  _buildSettingsButton(
                    imagePath: 'lib/icons/notification.png',
                    text: "Notifications",
                    onPressed: () {
                      // Action pour ce bouton
                    },
                  ),
                  const SizedBox(height: 15), // Espacement entre les boutons
                  _buildSettingsButton(
                    imagePath: 'lib/icons/wallet_settings.png',
                    text: "Wallet",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Wallet()),
                      );
                    },
                  ),
                  const SizedBox(
                      height: 15), // Espacement avant les nouveaux boutons
                  _buildSettingsButton(
                    imagePath: 'lib/icons/key-square_settings.png',
                    text: "Login settings",
                    onPressed: () {
                      // Action pour ce bouton
                    },
                  ),
                  const SizedBox(
                      height: 15), // Espacement avant les nouveaux boutons
                  _buildSettingsButton(
                    imagePath: 'lib/icons/call-calling_settings.png',
                    text: "Help & Support",
                    onPressed: () {
                      // Action pour ce bouton
                    },
                  ),
                  const SizedBox(
                      height: 100), // Espacement avant les nouveaux boutons

                  TextButton(
                    onPressed: () {
                      // Action pour le bouton de déconnexion
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Color.fromARGB(255, 25, 43, 109),
                          size: 40,
                        ),
                        const SizedBox(
                            width: 10), // Espacement entre l'icône et le texte
                        const Text(
                          'Log Out',
                          style: TextStyle(
                            color: Color.fromARGB(255, 25, 43, 109),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      // Footer avec 5 icônes fixes en bas de l'écran
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Boutons du footer
              IconButton(
                icon: Image.asset(
                  'lib/icons/home_full.png',
                  color: Colors.white,
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  // Action pour le bouton
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
                onPressed: () {
                  // Action pour le bouton
                },
              ),
              IconButton(
                icon: Image.asset(
                  'lib/icons/add.png',
                  color: Colors.white,
                  width: 50,
                  height: 50,
                ),
                onPressed: () {
                  // Action pour le bouton
                },
              ),
              IconButton(
                icon: Image.asset(
                  'lib/icons/chat_full.png',
                  color: Colors.white,
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  // Action pour le bouton
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
                  // Action pour le bouton
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour construire chaque bouton avec Image.asset
  Widget _buildSettingsButton({
    required String imagePath,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          backgroundColor: Colors.white.withOpacity(0.0), // Transparent
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Aligner les widgets
          children: [
            Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 45,
                  height: 45,
                ), // Icône personnalisée
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black,
              size: 24,
            ), // Icône supplémentaire à droite
          ],
        ),
      ),
    );
  }

  // Widget pour construire les boutons colorés avec texte ajustable
  Widget _buildColoredButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.9),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(114),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown, // Ajuste le texte sans le déformer
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15, // Taille initiale
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

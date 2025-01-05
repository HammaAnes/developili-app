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
      home: AddPayments(),
    );
  }
}

class AddPayments extends StatelessWidget {
  const AddPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Empêche le redimensionnement du contenu lorsqu'un footer est présent
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
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
                    horizontal: 16.0, vertical: 25.0),
                child: const Text(
                  'Add payments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Image au centre de la page
              Center(
                child: Image.asset(
                  'lib/icons/Carte_Visa.png', // Chemin de votre image
                  width: 311,
                  height: 219,
                ),
              ),
              const SizedBox(height: 40),
              // Texte et formulaire alignés
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  children: [
                    _buildFormRow('Name', 'Enter name'),
                    const SizedBox(height: 15),
                    _buildFormRow('Type', 'Enter type'),
                    const SizedBox(height: 15),
                    _buildFormRow('Card number', 'Enter card number',
                        isNumeric: true),
                    const SizedBox(height: 15),
                    _buildFormRow('CVV Code', 'Enter CVV', isNumeric: true),
                    const SizedBox(height: 15),
                    _buildFormRow('Expire', 'MM/YY', isNumeric: true),
                  ],
                ),
              ),
              // Espacement supplémentaire pour éviter le chevauchement avec le footer
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      // Footer avec icônes fixes
      bottomNavigationBar: Container(
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

  // Méthode utilitaire pour créer une ligne contenant un texte et un champ de formulaire
  Widget _buildFormRow(String labelText, String hintText,
      {bool isNumeric = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            labelText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Flexible(
          child: TextField(
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé

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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titre principal
                Text(
                  "Forgot",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25), // Espacement entre le titre et l'image

                // Image
                Image.asset(
                  'lib/icons/forogot_password.png', // Assurez-vous que l'image existe dans ce chemin
                  height: 350, // Ajustez la taille selon vos besoins
                ),
                SizedBox(height: 16), // Espacement entre l'image et le texte

                // Texte secondaire
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                    height:
                        8), // Espacement entre le texte principal et le texte descriptif

                // Texte descriptif
                Text(
                  "Don’t worry! It happens. Please enter your e-mail associated with your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 24), // Espacement avant le formulaire

                Align(
                  alignment: Alignment.centerLeft, // Aligner à gauche
                  child: Text(
                    'Enter your e-mail',
                    style: TextStyle(color: Colors.black, fontSize: 16.43),
                  ),
                ),
                SizedBox(height: 10),
                // Formulaire pour l'adresse e-mail
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24), // Espacement avant le bouton

                // Bouton pour obtenir l'OTP
                ElevatedButton(
                  onPressed: () {
                    // Action du bouton
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Couleur de fond du bouton
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: Text(
                    "Get OTP",
                    style: TextStyle(
                      color: Colors.white, // Couleur du texte
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

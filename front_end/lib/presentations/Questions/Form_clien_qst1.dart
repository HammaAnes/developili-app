import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int?
      boutonSelectionne; // Index du bouton sélectionné, null signifie aucun bouton sélectionné

  // Liste des noms des boutons
  final List<String> nomsBoutons = [
    'Entrepreneur',
    'Marketing Manager',
    'Technical Manager',
    'Project Manager',
    'Other (please specify)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
        ),
        child: Center(
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Centre verticalement tout le contenu
            children: [
              // Titre
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Questions",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // Boutons
              Column(
                children: List.generate(nomsBoutons.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          boutonSelectionne = index;
                        });
                      },
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFBFD7E4).withOpacity(0.5),
                          border: Border.all(
                            color: boutonSelectionne == index
                                ? Colors.blue // Bordure bleue si sélectionné
                                : Colors.white, // Bordure blanche sinon
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          nomsBoutons[
                              index], // Utilisation du nom correspondant
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

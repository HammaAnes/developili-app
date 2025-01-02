import 'package:flutter/material.dart';
import 'Form_SRS_qst3.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'Form_SRS_qst5.dart';
import '../couleur_du_fond.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_4th_question(),
    );
  }
}

class My_4th_question extends StatefulWidget {
  @override
  _My_4th_question_State createState() => _My_4th_question_State();
}

class _My_4th_question_State extends State<My_4th_question>
    with TickerProviderStateMixin {
  int? boutonSelectionne; // Index du bouton sélectionné
  int currentPage = 3; // Page actuelle
  final int totalPages = 10; // Nombre total de pages

  // Liste des noms des boutons
  final List<String> nomsBoutons = [
    'Small budget (< 1000€)',
    'Medium budget (1000€ - 5000€)',
    'Large budget (> 5000€)',
  ];

  // Fonction pour naviguer vers une autre page
  void _goTo3rdPage() {
    if (boutonSelectionne != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => My_5th_question()),
      );
    }
  }

  void _goBack1stPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_3rd_question()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
        child: Stack(
          children: [
            // Titre en haut de l'écran
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Questions",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Sous-question
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Have you worked with a developer before ?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Liste des boutons au centre
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(nomsBoutons.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            boutonSelectionne = index;
                            _goTo3rdPage(); // Naviguer vers la prochaine page
                          });
                        },
                        child: Container(
                          width: 318,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFBFD7E4).withOpacity(0.5),
                            border: Border.all(
                              color: boutonSelectionne == index
                                  ? Colors.blue
                                  : Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            nomsBoutons[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            // Bouton "Back" en bas à gauche
            Positioned(
              bottom: 55,
              left: 20,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _goBack1stPage();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Cercles de progression au centre en bas
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: index < 4
                          ? const Color.fromARGB(255, 73, 255, 79)
                          : const Color.fromARGB(255, 7, 27, 139)
                              .withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

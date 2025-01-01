import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'qst2_dev.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'qst4_dev.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_3rd_question(),
    );
  }
}

class My_3rd_question extends StatefulWidget {
  @override
  _My_3rd_question_State createState() => _My_3rd_question_State();
}

class _My_3rd_question_State extends State<My_3rd_question>
    with TickerProviderStateMixin {
  int? boutonSelectionne; // Index du bouton sélectionné
  bool showForm = false; // Controls the display of the input form
  bool isLoading = false; // Loading indicator
  int currentPage = 2; // Page actuelle
  final int totalPages = 7; // Nombre total de pages

  final List<String> nomsBoutons = [
    'Junior (0-2 years)',
    'Mid-Level (3-5 years)',
    'Senior (6+ years)',
  ];

  // Méthode pour passer à la page suivante
  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_4th_question()),
    );
  }

  // Méthode pour revenir à la page d'accueil
  void _goBack2ndPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_2nd_question()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
              // Question principale
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "What is your experience level?",
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
              // Liste des boutons
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
                            });
                            // Rediriger vers la page suivante après sélection
                            _goToNextPage();
                          },
                          child: Container(
                            width: 345,
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
                                fontSize: 19,
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
              // Bouton "Back"
              Positioned(
                bottom: 55,
                left: 20,
                child: ElevatedButton(
                  onPressed: _goBack2ndPage,
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
              // Indicateur de progression
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
                        color: index < 3
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
      ),
    );
  }
}

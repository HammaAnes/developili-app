import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'qst1_dev.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'qst3_dev.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_2nd_question(),
    );
  }
}

class My_2nd_question extends StatefulWidget {
  @override
  _My_2nd_question_State createState() => _My_2nd_question_State();
}

class _My_2nd_question_State extends State<My_2nd_question>
    with TickerProviderStateMixin {
  int? boutonSelectionne; // Index du bouton sélectionné
  bool showForm = false; // Contrôle l'affichage du formulaire
  bool isLoading = false; // Loading indicator
  int currentPage = 1; // Page actuelle
  final int totalPages = 7; // Nombre total de pages

  final List<String> nomsBoutons = [
    'Front-End Development',
    'Back-End Development',
    'Full-Stack Development',
    'Database Design',
    'Other (please specify)',
  ];

  final TextEditingController otherController = TextEditingController();

  // Méthode pour passer à la page suivante
  void _goToNextPage() {
    if (otherController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => My_3rd_question()),
      );
    }
  }

  // Méthode pour revenir à la page d'accueil
  void _goBack2ndPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_1st_question()),
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
                      "What is your specialization?",
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
                              showForm = index == nomsBoutons.length - 1;
                              if (!showForm) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => My_3rd_question()),
                                );
                              }
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
                            child: index == nomsBoutons.length - 1
                                ? RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Other ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '(please specify)',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
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
                    // Formulaire animé
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: showForm
                          ? Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Container(
                                width: 318,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                child: TextField(
                                  controller: otherController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
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
                        color: index < 2
                            ? const Color.fromARGB(255, 73, 255, 79)
                            : const Color.fromARGB(255, 7, 27, 139)
                                .withOpacity(0.5),
                      ),
                    );
                  }),
                ),
              ),
              // Bouton "Next" (visible uniquement si le formulaire est actif)
              if (showForm)
                Positioned(
                  bottom: 55,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: otherController.text.isNotEmpty
                        ? _goToNextPage
                        : null, // Désactivé si le formulaire est vide
                    style: ElevatedButton.styleFrom(
                      backgroundColor: otherController.text.isNotEmpty
                          ? Colors.black
                          : Colors.grey, // Changement de couleur
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

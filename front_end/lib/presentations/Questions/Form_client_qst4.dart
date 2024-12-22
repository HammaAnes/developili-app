import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'Form_client_qst3.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'Form_client_qst5.dart';
import '../api_service.dart';

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
  bool showForm = false; // Contrôle l'affichage du formulaire
  bool isLoading = false;
  int currentPage = 3; // Page actuelle
  final int totalPages = 8; // Nombre total de pages

  // Liste des noms des boutons
  final List<String> nomsBoutons = [
    'Mobile applications',
    'Websites',
    'Desktop applications',
    'Other (please specify)',
  ];

  final TextEditingController otherController = TextEditingController();

  void _goTo5thPage() {
    if (otherController.text.isNotEmpty || boutonSelectionne != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => My_5th_question()),
      );
    }
  }

  void _goBack3rdPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_3rd_question()),
    );
  }

  // Submit the selected answer to the backend
  Future<void> _submitAnswer(String answer) async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await APIService.submitAnswer(2, 4, answer); // Example: client_id = 1, question_id = 1
      if (result["success"]) {
        // Navigate to the next question on success
        _goTo5thPage();
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${result["error"]}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit answer: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Handles button selection and form display
  void _onOptionSelected(int index) {
    setState(() {
      boutonSelectionne = index;
      showForm =
          index == nomsBoutons.length - 1; // Show form for the "Other" option
      if (!showForm) {
        _submitAnswer(nomsBoutons[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permet de redimensionner l'interface
      body: SingleChildScrollView(
        // Ajouté pour permettre le défilement
        child: Container(
          height: MediaQuery.of(context)
              .size
              .height, // Prend toute la hauteur disponible
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
                      "What types of applications have you managed or created before ?",
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
                          onTap: ()=> _onOptionSelected(index),
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
                    // Formulaire animé directement sous le dernier bouton
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
              // Bouton "Back" en bas à gauche
              Positioned(
                bottom: 55,
                left: 20,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _goBack3rdPage();
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
              if (showForm)
                Positioned(
                  bottom: 55,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: otherController.text.isNotEmpty
                        ? _goTo5thPage
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

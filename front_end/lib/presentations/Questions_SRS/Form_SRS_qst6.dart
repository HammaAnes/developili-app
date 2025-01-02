import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'Form_SRS_qst5.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'Form_SRS_qst7.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_6th_question(),
    );
  }
}

class My_6th_question extends StatefulWidget {
  @override
  _My_6th_question_State createState() => _My_6th_question_State();
}

class _My_6th_question_State extends State<My_6th_question> {
  bool showForm = false; // Contrôle l'affichage du formulaire
  int currentPage = 5; // Page actuelle
  final int totalPages = 9; // Nombre total de pages

  // Valeurs sélectionnées pour les dropdowns
  List<String> selectedLayouts = [];
  List<String> selectedFunctionalities = [];

  // Options des dropdowns
  final List<String> layoutOptions = [
    'Grid layout',
    'Column layout',
    'Row layout',
    'List layout',
    'Cards layout',
    'Full-screen photo',
    'Liquid design',
    'Split screen'
  ];
  final List<String> functionalityOptions = [
    'Search bar',
    'Dark mode',
    'Offline access',
    'Custom animations',
    'Login',
    'Payment Gateway',
    'API integrations',
    'Home page',
    'Dashboard',
    'Push notifications',
    'Ratings and Reviews',
    'User profiles',
    'ChatGPT'
  ];

  // Méthode pour afficher un dialogue de sélection
  Future<void> _showSelectionDialog(
    List<String> options,
    List<String> selectedValues,
    String title,
  ) async {
    final List<String> tempSelections = List.from(selectedValues);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((option) {
                    return CheckboxListTile(
                      title: Text(option),
                      value: tempSelections.contains(option),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            tempSelections.add(option);
                          } else {
                            tempSelections.remove(option);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Ferme le dialogue
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Sauvegarde et rafraîchit l'affichage principal
                    setState(() {
                      selectedValues
                        ..clear()
                        ..addAll(tempSelections);
                    });
                    this.setState(() {}); // Réactualise l'écran principal
                    Navigator.pop(context); // Ferme le dialogue
                  },
                  child: Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Méthode pour passer à la page suivante
  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_7th_question()),
    );
  }

  // Méthode pour revenir à la page précédente
  void _goBack2ndPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_5th_question()),
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
                      "Application Structure",
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
              // Dropdowns pour Layout et Functionality
              Positioned(
                top: 270,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select the layout',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showSelectionDialog(
                          layoutOptions, selectedLayouts, 'Select the layout'),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedLayouts.isEmpty
                                  ? 'No layout selected'
                                  : '${selectedLayouts.length} option(s) selected',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Add specific functionalities',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showSelectionDialog(
                          functionalityOptions,
                          selectedFunctionalities,
                          'Add specific functionalities'),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedFunctionalities.isEmpty
                                  ? 'No functionalities selected'
                                  : '${selectedFunctionalities.length} option(s) selected',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Boutons Back et Next
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
              Positioned(
                bottom: 55,
                right: 20,
                child: ElevatedButton(
                  onPressed: _goToNextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
                        color: index < 6
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

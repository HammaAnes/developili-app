import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé
import 'Question_Dev/qst1_dev.dart';

void main() {
  runApp(const MyAppMain());
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers for the text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  // Variables for Date of Birth
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Dégradé de fond
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Titre "Profil"
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'Profil',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Photo de profil
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              print("Photo de profil cliquée");
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'lib/icons/user_full.png'), // Image de profil
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                      // Formulaires
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormField(
                                  label: 'Name', controller: nameController),
                              _buildFormField(
                                  label: 'First Name',
                                  controller: firstNameController),
                              _buildFormField(
                                  label: 'Username',
                                  controller: usernameController),
                              _buildFormField(
                                  label: 'Phone Number',
                                  controller: phoneController,
                                  isNumber: true),
                              // Date Picker
                              _buildDateField(),
                              // Dropdown field
                              _buildDropdownField(),
                            ],
                          ),
                        ),
                      ),
                      // Bouton en bas avec marge depuis le bas
                      Padding(
                        padding: const EdgeInsets.only(bottom: 45),
                        child: SizedBox(
                          width: 350, // Largeur fixe pour le bouton
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => My_1st_question()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.black, // Couleur du bouton
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15), // Bouton arrondi
                              ),
                              minimumSize: const Size(double.infinity,
                                  60), // Ajustement de la hauteur
                            ),
                            child: const Text(
                              "Move to questionnaire",
                              style: TextStyle(
                                color: Colors.white, // Couleur du texte
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to build text fields
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build Date Field
  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of Birth',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: AbsorbPointer(
              child: TextField(
                controller: birthDateController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey, // Icon color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build Dropdown Field
  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Country',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: DropdownButton<String>(
              hint: const Text("Select Country"),
              value: selectedCountry,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              },
              isExpanded: true,
              underline: const SizedBox(),
              items: countries.map<DropdownMenuItem<String>>((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show date picker
  _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime initialDate = selectedDate ?? today;
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Variables for Dropdown Field
  String? selectedCountry;
  final List<String> countries = [
    'USA',
    'Canada',
    'France',
    'Germany',
    'Algeria',
    'Nigeria',
    'Mexico',
    'Brasil',
    'Spain',
    'Japan',
    'China',
    'Russia',
    'Albania',
    'Morocco',
    'Portugal',
    'Niger',
    'Libia',
    'Argentina',
    'thailand',
    'Turkey',
  ];
}

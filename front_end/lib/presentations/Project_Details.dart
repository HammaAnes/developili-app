import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import the background gradient file
import 'main_client.dart';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const ProjectDetailsApp());
}

class ProjectDetailsApp extends StatelessWidget {
  const ProjectDetailsApp({Key? key, Strin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProjectDetailsPage(),
    );
  }
}

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({Key? key}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  final List<String> _imageUrls = [
    'https://via.placeholder.com/400x250?text=Image+1',
    'https://via.placeholder.com/400x250?text=Image+2',
    'https://via.placeholder.com/400x250?text=Image+3',
    'https://via.placeholder.com/400x250?text=Image+4',
  ];

  int _currentPage = 0;
  List<Map<String, dynamic>> _projects = [];
  @override
  void initState() {
    super.initState();
    initializeData();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/main_page/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _projects = data.cast<Map<String, dynamic>>();
      });
    } else {
      // Handle errors
      print('Failed to fetch projects');
    }
  }

  Future<int?> _fetchData() async {
    var storage = FlutterSecureStorage();
    String? project = await storage.read(key: 'projectID');

    // Safely parse the string to an integer
    if (project != null) {
      return int.tryParse(project); // Returns null if parsing fails
    }

    return null; // Return null if the value is not found
  }

  int? id;

  Future<void> initializeData() async {
    id = await _fetchData();
  }

  _ProjectDetailsPageState();

  void _showDetails(BuildContext context, String title, String fullText) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration:
            const Duration(milliseconds: 400), // Smooth, longer duration
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic, // Smooth easing
                ),
                child: Dialog(
                  backgroundColor: Colors.blue.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          fullText,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Smooth Fade + Scale
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic, // Smooth fade in and out
            ),
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubic, // Smooth scaling
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
        child: SafeArea(
          child: _projects.isEmpty || id == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    // Title and Back Button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Devlopili',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable Image List
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        itemCount: _imageUrls.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        controller: PageController(viewportFraction: 0.85),
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: Colors.grey.shade300,
                                child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBNKl_j1Bqly7xT4al3oH2FHXG4AoAwxk07A&s',
                                  
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Dots Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _imageUrls.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentPage == index ? 12.0 : 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.blue.shade200
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Developer Avatar and Name
                    if (id != null && id! < _projects.length) ...[
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          _projects[id!]['user_avatar'] ??
                              'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _projects[id!]['user_first_name'] ?? 'Developer',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Titles and Description Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          _infoRow(
                            "Description",
                            "Details about the project",
                            _projects[id!]['description'],
                          ),
                          _infoRow(
                            "Technologies",
                            "Technologies used in this project.",
                            _projects[id!]['technologies']?.join(', ') ??
                                "No Technologies",
                          ),
                          _infoRow(
                            "Duration",
                            "Project duration information.",
                            _projects[id!]['duration'] ?? "No Duration",
                          ),
                          _infoRow(
                            "Team",
                            "The members of the team",
                            _projects[id!]['team_members']?.join('| ') ??
                                "No Team Members",
                          ),
                          _infoRow(
                            "Users",
                            "Number of Downloads",
                            "this app have ${_projects[id!]['users']}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String shortText, String fullText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showDetails(context, title, fullText);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.blue.shade200,
            ),
            child: Text(
              shortText,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

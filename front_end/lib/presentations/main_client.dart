import 'package:flutter/material.dart';
import 'couleur_du_fond.dart';
import 'profile_client.dart'; // Profile Page
import 'project_details.dart'; // Devlopili Details Page
import 'top_devs_page.dart';
import 'projects_page.dart';
import 'message_icone_client.dart';
import 'Questions_SRS/Form_SRS_qst1.dart';
import 'projects_page.dart';
import 'Payments.dart';

void main() {
  runApp(const ClientMain());
}

class ClientMain extends StatelessWidget {
  const ClientMain({super.key});

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
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Kept as is)
            PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Image.asset(
                      'lib/icons/menu.png',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                title: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Rechercher...",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Icons Under Search Bar
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'lib/icons/iphone_full.png',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      // Action for first button
                    },
                  ),
                  const SizedBox(width: 30), // Space between icons
                  IconButton(
                    icon: Image.asset(
                      'lib/icons/web_full.png',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      // Action for second button
                    },
                  ),
                  const SizedBox(width: 30), // Space between icons
                  IconButton(
                    icon: Image.asset(
                      'lib/icons/screen_full.png',
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      // Action for third button
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Projects Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Projects",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProjectsPage()),
                      );
// Navigate to a page showing all projects
                    },
                    child: const Text(
                      "See More",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Projects List
            SizedBox(
              height: 230,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildProjectCard(
                    context,
                    "Devlopili",
                    "https://via.placeholder.com/200",
                    ProjectDetailsPage(),
                    [
                      "https://via.placeholder.com/30",
                      "https://via.placeholder.com/30"
                    ],
                  ),
                  buildProjectCard(
                    context,
                    "Bricoula",
                    "https://via.placeholder.com/200",
                    ProjectDetailsPage(),
                    [
                      "https://via.placeholder.com/30",
                      "https://via.placeholder.com/30"
                    ],
                  ),
                  buildProjectCard(
                    context,
                    "CodeCraft",
                    "https://via.placeholder.com/200",
                    ProjectDetailsPage(),
                    [
                      "https://via.placeholder.com/30",
                      "https://via.placeholder.com/30"
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Top Dev's Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Dev's",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TopDevsPage()),
                      );
// Navigate to a page showing all developers
                    },
                    child: const Text(
                      "See More",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Top Dev's List
            SizedBox(
              height: 180, // Increased size for better alignment
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildDevProfile(context, "Steve M", "Full-stack Developer",
                      "https://via.placeholder.com/100", ProfilePage()),
                  buildDevProfile(context, "Harvey J", "UI/UX Designer",
                      "https://via.placeholder.com/100", ProfilePage()),
                  buildDevProfile(context, "Asep Yanto", "Front End Developer",
                      "https://via.placeholder.com/100", ProfilePage()),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff314270),
                Color(0xff5E7ED6),
              ],
              stops: [0.1, 0.73],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    // Profile Image
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          print('Profile Image Clicked');
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),

                    // Back Icon
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Buttons
              buildMenuTile(
                index: 0,
                icon: Icons.backup_table_outlined,
                label: 'Projects',
                context: context,
                destination: ProjectsPage(),
              ),
              const SizedBox(height: 10),
              buildMenuTile(
                index: 1,
                icon: Icons.payments_outlined,
                label: 'Payments',
                context: context,
                destination: Payments(),
              ),
              const SizedBox(height: 10),
              buildMenuTile(
                index: 2,
                icon: Icons.settings,
                label: 'Settings',
                context: context,
                destination: Payments(),
              ),
              const SizedBox(height: 10),
              buildMenuTile(
                index: 3,
                icon: Icons.phone_in_talk_rounded,
                label: 'Help & Support',
                context: context,
                destination: Payments(),
              ),
            ],
          ),
        ),
      ),

      // Footer (Kept as is)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
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
                onPressed: () {},
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => My_1st_question()),
                  );
                },
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
                    MaterialPageRoute(
                      builder: (context) =>
                          const MessagesPage(), // Navigate to MessagesPage
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuTile({
    required int index,
    required IconData icon,
    required String label,
    required BuildContext context,
    required Widget destination,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: _selectedIndex == index ? Colors.black : Colors.white,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.black : Colors.white,
          fontSize: 22,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
        print('$label clicked');
        // Add navigation logic here if necessary
      },
      tileColor: _selectedIndex == index
          ? Colors.white.withOpacity(0.2)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Helper for Project Card
  Widget buildProjectCard(BuildContext context, String title, String imageUrl,
      Widget detailsPage, List<String> profileUrls) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => detailsPage),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: profileUrls.map((url) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(url),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Dev Profile
  Widget buildDevProfile(BuildContext context, String name, String title,
      String imageUrl, Widget profilePage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profilePage),
        );
      },
      child: Container(
        width: 130, // Fixed width for consistent size
        margin: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Aligns the column items
          children: [
            CircleAvatar(
              radius: 50, // Consistent size for the profile image
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 20, // Fixed height to ensure alignment for names
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1, // Limit text to one line
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if text is too long
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 20, // Fixed height to ensure alignment for titles
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 1, // Limit text to one line
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if text is too long
              ),
            ),
          ],
        ),
      ),
    );
  }
}

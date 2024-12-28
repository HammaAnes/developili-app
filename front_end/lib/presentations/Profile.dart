import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentPage = 0; // Keeps track of the currently visible project card
  bool isOccupied = true; // Tracks Occupied/Available state

  @override
  Widget build(BuildContext context) {
    // Colors and styles
    final Color leftGradientColor = const Color(0xFF26365A);
    final Color rightGradientColor = const Color(0xFF72C1D9);

    final TextStyle labelStyle = TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
    );
    final TextStyle infoStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [leftGradientColor, rightGradientColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with back button, profile image, name, and details
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button and profile title
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Profile image and details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Image and Name
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.purple.shade100,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Saïd Benrahma",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Profession, Experience, Company, and Availability
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoLabel("Profession", labelStyle),
                              Text("Front-end | Designer | Back-end",
                                  style: infoStyle),
                              const SizedBox(height: 8),
                              _infoLabel("Experience", labelStyle),
                              Text("Senior | 5 Years", style: infoStyle),
                              const SizedBox(height: 8),
                              _infoLabel("Company", labelStyle),
                              Text("Facebook", style: infoStyle),
                              const SizedBox(height: 8),
                              _infoLabel("Availability", labelStyle),
                              Row(
                                children: [
                                  Switch(
                                    value: !isOccupied,
                                    onChanged: (val) {
                                      setState(() {
                                        isOccupied = !val;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey[100],
                                  ),
                                  Text(
                                    isOccupied ? "Occupied" : "Available",
                                    style: infoStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15), // Adjusted height

              // Center section with Accomplished Projects
              // Accomplished Projects Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Accomplished Projects",
                      style: labelStyle.copyWith(
                        color: Colors.blue.shade900,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Projects Scroll
                    SizedBox(
                      height: 90, // Adjusted height for smaller boxes
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4, // Total number of projects
                              itemBuilder: (context, index) {
                                final projects = [
                                  {"title": "Devlopili", "subtitle": "Design"},
                                  {
                                    "title": "Facebook",
                                    "subtitle": "Front-end\nBack-end"
                                  },
                                  {
                                    "title": "Créneau",
                                    "subtitle": "Back-end\nDesign"
                                  },
                                  {
                                    "title": "Voyager",
                                    "subtitle": "Design\nFront-end"
                                  }
                                ];
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: index == 0 ? 16 : 8,
                                    right: index == 3 ? 16 : 8,
                                  ),
                                  width: 98, // Kept the width as it is
                                  height:
                                      60, // Reduced height for smaller boxes
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          projects[index]['title']!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                14, // Reduced font size for text
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          projects[index]['subtitle']!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize:
                                                12, // Reduced font size for subtitle
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Responsive dots
                          // Responsive dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3, // Set the number of dots to 3
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == index ? 12 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? Colors.blue
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Section
              // Adjusting the Bottom Section
              Container(
                margin: const EdgeInsets.only(
                    left: 14, right: 14), // Margins for the container
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 18, // Reduced padding to fix overflow
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF5693AD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  // Ensures the content inside adapts to the container's margins
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16), // Inner content padding
                  child: Column(
                    children: [
                      // Top Row: Average Rating and Projects Completed
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _statItem("4.3", "Average Rating"),
                          _statItem("37", "Projects Completed"),
                        ],
                      ),
                      const SizedBox(
                          height: 18), // Reduced spacing between rows

                      // Middle Row: Pay Range and Ongoing Projects
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pay Range",
                                  style: labelStyle.copyWith(
                                    fontWeight: FontWeight
                                        .bold, // Makes it bold like a title
                                    fontSize:
                                        18, // Slightly larger font size for prominence
                                    color:
                                        Colors.black, // Ensure clear visibility
                                  )),
                              const SizedBox(height: 4),
                              Text("150€ - 2000€", style: infoStyle),
                              const SizedBox(height: 4),
                              Text(
                                "(negotiable)",
                                style: infoStyle.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          _statItem("02", "Ongoing Projects"),
                        ],
                      ),
                      const SizedBox(
                          height: 18), // Reduced spacing between rows

                      // Bottom Row: Position and Technologies
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Position",
                                    style: labelStyle.copyWith(
                                      fontWeight: FontWeight
                                          .bold, // Makes it bold like a title
                                      fontSize:
                                          18, // Slightly larger font size for prominence
                                      color: Colors
                                          .black, // Ensure clear visibility
                                    )),
                                const SizedBox(height: 4),
                                Text("Software Engineer", style: infoStyle),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Technologies",
                                    style: labelStyle.copyWith(
                                      fontWeight: FontWeight
                                          .bold, // Makes it bold like a title
                                      fontSize:
                                          18, // Slightly larger font size for prominence
                                      color: Colors
                                          .black, // Ensure clear visibility
                                    )),
                                const SizedBox(height: 4),
                                Text(
                                  "Python / Django\nC / C++ / C#\nReact / Node",
                                  style: infoStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods
  Widget _infoLabel(String text, TextStyle style) {
    return Text(text, style: style.copyWith(color: Colors.white));
  }

  Widget _statItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  title: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                  backgroundColor: Colors.transparent, // Make the app bar background transparent
                  iconTheme: IconThemeData(
                    color: Colors.white, // Back button color
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        // Add your grid items here
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          ),
                          margin: const EdgeInsets.all(8.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          ),
                          margin: const EdgeInsets.all(8.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          ),
                          margin: const EdgeInsets.all(8.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          ),
                          margin: const EdgeInsets.all(8.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          ),
                          margin: const EdgeInsets.all(8.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          ),
                          margin: const EdgeInsets.all(8.0),
                        ),
                      ],
                    ),
                  ),
                ),
                BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white, // Icon color
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.business,
                        color: Colors.white, // Icon color
                      ),
                      label: 'Business',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.school,
                        color: Colors.white, // Icon color
                      ),
                      label: 'School',
                    ),
                  ],
                  backgroundColor: Colors.transparent, // Make the bottom navigation bar background transparent
                  selectedItemColor: Colors.white, // Selected item text color
                  unselectedItemColor: Colors.white, // Unselected item text color
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// New Route Page
class RoutePage extends StatelessWidget {
  final String routeName;

  RoutePage({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName),
        backgroundColor: Color(0xFF00BF63),
      ),
      body: Center(
        child: Text(
          'Welcome to the $routeName Route!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // Method to navigate to the RoutePage
  void _navigateToRoute(String routeName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoutePage(routeName: routeName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color(0xFF00BF63),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Add settings functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, 20),
              child: Text(
                "Routes",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _navigateToRoute("Kalimati");
              },
              child: Text(
                "Kalimati",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00BF63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(160, 50),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _navigateToRoute("Baneshowr");
              },
              child: Text(
                "Baneshowr",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00BF63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(160, 50),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _navigateToRoute("Kadaghari");
              },
              child: Text(
                "Kadaghari",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00BF63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(160, 50),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF00BF63),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          print("Selected tab: $index");
        },
      ),
    );
  }
}

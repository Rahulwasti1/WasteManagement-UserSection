import 'package:flutter/material.dart';

import 'admin_home.dart';
import 'admin_profile.dart';
import 'admin_route.dart'; // Assuming you have this screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Mitra',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AdminNavigation(),
    );
  }
}

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  _AdminNavigationState createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  final List<String> _titles = [
    "Admin Dashboard",
    "Manage Drivers",
    "Schedule Collection",
    "Add Location",
    "Profile"
  ];

  final List<Widget> _screens = [
    const admin_home(),
    const admin_route(),
    const admin_profile(), // Make sure this screen is created

  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _titles[_selectedIndex],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFF00BF63), // Green background for AppBar
      ),
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white), // Unselected label color
          ),
          indicatorColor: Colors.transparent, // Optional: Remove the indicator
        ),
        child: NavigationBar(
          height: 80,
          backgroundColor: const Color(0xFF00BF63),
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.directions_car, color: Colors.white),
              label: 'Driver',
            ),
            NavigationDestination(
              icon: const Icon(Icons.calendar_today, color: Colors.white),
              label: 'Schedule',
            ),
          ],
        ),
      ),
    );
  }
}
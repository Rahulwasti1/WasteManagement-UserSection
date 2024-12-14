import 'package:ecomitra_frontend/User/user_home.dart';
import 'package:ecomitra_frontend/User/user_news.dart';
import 'package:ecomitra_frontend/User/user_profile.dart';
import 'package:ecomitra_frontend/User/user_report.dart';
import 'package:ecomitra_frontend/User/user_scanner.dart';
import 'package:flutter/material.dart';

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
      home: const UserNavigation(), // Use UserNavigation as home
    );
  }
}

class UserNavigation extends StatefulWidget {
  const UserNavigation({super.key});

  @override
  _UserNavigationState createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  final List<String> _titles = [
    "Dashboard",
    "News Highlights", // Fixed missing comma
    "Route",
    "Scanner",
    "Report",
    "Profile",
  ];

  final List<Widget> _screens = [
    const UserHome(),
    const UserNews(),
    const UserReport(), // Added const
    const UserScanner(),
    const UserProfile(),
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
      appBar: _selectedIndex == 0
          ? null // No Appbar for the Dashboard.
          : AppBar(
              title: Center(
                child: Text(
                  _titles[_selectedIndex],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor:
                  const Color(0xFF00BF63), // Green background for AppBar
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
              icon: const Icon(Icons.article,
                  color: Colors.white), // Use article for News
              label: 'News',
            ),
            NavigationDestination(
              icon: const Icon(Icons.route, color: Colors.white),
              label: 'Route',
            ),
            NavigationDestination(
              icon: const Icon(Icons.scanner, color: Colors.white),
              label: 'Scanner',
            ),
            NavigationDestination(
              icon: const Icon(Icons.report, color: Colors.white),
              label: 'Report',
            ),
            NavigationDestination(
              icon: const Icon(Icons.person, color: Colors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

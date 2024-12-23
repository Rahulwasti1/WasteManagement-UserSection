import 'package:ecomitra_frontend/Login_Signup/Login.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isDarkMode = false; // To toggle dark mode
  String selectedLocation = "Select Location"; // Default location
  String selectedLanguage = "English"; // Default language

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Information
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage(
                          'assets/icons/rahul.png'), // Add your profile image here
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Rahul Wasti',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'rahulwasti@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // General Settings Section
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Mode'),
                subtitle: const Text('Dark & Light'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Change Location'),
                subtitle: Text(selectedLocation),
                onTap: () {
                  _selectLocation(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                subtitle: Text(selectedLanguage),
                onTap: () {
                  _selectLanguage(context);
                },
              ),
              const Divider(),
              // Information Section
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About App'),
                onTap: () {
                  // Handle about app
                },
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Terms & Conditions'),
                onTap: () {
                  // Handle terms and conditions
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Privacy Policy'),
                onTap: () {
                  // Handle privacy policy
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // Navigate to the login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to display a dialog for location selection
  Future<void> _selectLocation(BuildContext context) async {
    String? location = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Location'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Location 1");
              },
              child: const Text('Koteshowr'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Location 2");
              },
              child: const Text('Baneshowr'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Location 3");
              },
              child: const Text('Kadaghari'),
            ),
          ],
        );
      },
    );

    if (location != null) {
      setState(() {
        selectedLocation = location;
      });
    }
  }

  // Method to display a dialog for language selection
  Future<void> _selectLanguage(BuildContext context) async {
    String? language = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Language'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "English");
              },
              child: Row(
                children: const [
                  Icon(Icons.language, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('English'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Nepali");
              },
              child: Row(
                children: const [
                  Icon(Icons.language, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Nepali'),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }
}

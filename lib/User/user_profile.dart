// import 'package:flutter/material.dart';

// class UserProfile extends StatelessWidget {
//   const UserProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         backgroundColor: const Color(0xFF00BF63),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // User Info Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(),
//             ),
//             const Divider(),

//             // General Settings
//             ListTile(
//               title: const Text('General Settings'),
//               dense: true,
//             ),
//             SwitchListTile(
//               title: const Text('Mode'),
//               subtitle: const Text('Dark & Light'),
//               value: false,
//               onChanged: (value) {},
//               secondary: const Icon(Icons.settings),
//             ),
//             ListTile(
//               leading: const Icon(Icons.location_on),
//               title: const Text('Change Location'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.language),
//               title: const Text('Language'),
//               onTap: () {},
//             ),
//             const Divider(),

//             // Information Section
//             ListTile(
//               title: const Text('Information'),
//               dense: true,
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About App'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.article),
//               title: const Text('Terms & Conditions'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.privacy_tip),
//               title: const Text('Privacy Policy'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.green,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Profile Information
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/profile_picture.jpg'), // Add your profile image here
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
              value: false,
              onChanged: (bool value) {
                // Handle mode change
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Change Location'),
            onTap: () {
              // Handle change location
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            onTap: () {
              // Handle language change
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
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}

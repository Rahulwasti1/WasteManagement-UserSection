import 'package:ecomitra_frontend/Admin/admin_navigation.dart';
import 'package:ecomitra_frontend/User/user_navigation.dart';
import 'package:flutter/material.dart'; // Import your Admin homepage/ Import Signup page

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login
  void handleLogin() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Redirect to user_homepage if fields are empty
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserNavigation()),
      );
    } else if (email == "admin" && password == "admin") {
      // Redirect to adminhome if credentials are admin/admin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminNavigation()),
      );
    } else {
      // Redirect to user_homepage for all other cases
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Back Button
              // ElevatedButton(
              //   onPressed: () {
              //     print('Arrow Button Pressed');
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.transparent,
              //     shadowColor: Colors.transparent,
              //     padding: EdgeInsets.zero,
              //     minimumSize: Size.zero,
              //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(0),
              //       side: BorderSide.none,
              //     ),
              //   ),
              //   child: Image.asset(
              //     "assets/icons/back.png",
              //     width: 16,
              //     height: 16,
              //   ),
              // ),

              const SizedBox(height: 40),

              // Avatar
              Center(
                child: Image.asset(
                  'assets/icons/waste.png',
                  height: 150,
                  width: 150,
                ),
              ),

              const SizedBox(height: 20),

              // Login Title and Subtitle
              const Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 5),
              const Text(
                "Login to continue using the app",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              // Email Input
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),

              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    hintText: "Enter your email",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 19),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password Input
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.only(left: 8, right: 10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true, // Hide password input
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    hintText: "Enter Password",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 19),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Forgot Password
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 240),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -20),
                          child: TextButton(
                            onPressed: () {
                              print("Forgot Password Clicked");
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, -13),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BF63),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          fixedSize: const Size(360, 63),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 9),

              // Or Login with
              const Center(
                child: Text(
                  "⎯⎯⎯⎯⎯⎯⎯⎯   Or Login with   ⎯⎯⎯⎯⎯⎯⎯⎯",
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ),

              const SizedBox(height: 20),

              // Social Media Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Facebook Button
                  ElevatedButton(
                    onPressed: () {
                      print("Facebook Button Clicked");
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      fixedSize: Size(60, 60),
                    ),
                    child: Image.asset(
                      'assets/icons/facebook.png',
                      height: 25,
                      width: 25,
                    ),
                  ),

                  // Google Button
                  ElevatedButton(
                    onPressed: () {
                      print("Google Button Clicked");
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      fixedSize: Size(60, 60),
                    ),
                    child: Image.asset(
                      'assets/icons/google.png',
                      height: 25,
                      width: 25,
                    ),
                  ),

                  // Apple Button
                  ElevatedButton(
                    onPressed: () {
                      print("Apple Button Clicked");
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      fixedSize: Size(60, 60),
                    ),
                    child: Image.asset(
                      'assets/icons/apple-logo.png',
                      height: 25,
                      width: 25,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        print("Register Clicked");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminNavigation()),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(color: Colors.black45),
                            ),
                            TextSpan(
                              text: " Register",
                              style: TextStyle(color: Color(0xFF00BF63)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

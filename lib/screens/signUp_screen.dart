import 'package:event_managment_2/screens/login_Screen2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_managment_2/Crediantial_Folder/Login_Validator.dart'; // Validator for input fields
import 'package:event_managment_2/Crediantial_Folder/firebase_Auth.dart'; // Firebase helper class
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesomeIcons

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    // Set status bar color based on theme
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white, // Set the background color of the whole screen
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white, // Set AppBar background color based on theme
          leading: IconButton(
            icon: CircleAvatar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black, // Circle color based on theme
              child: Icon(Icons.arrow_back,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white), // Change icon color based on theme
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black, // Adjust title color based on theme
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Fill Your Details Or Continue With Social Media",
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              SizedBox(height: 24),
              Form(
                key: _registerFormKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _nameTextController,
                      hintText: "Full Name",
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailTextController,
                      hintText: "Email Address",
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordTextController,
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                    ),
                    SizedBox(height: 32),
                    _isProcessing
                        ? CircularProgressIndicator()
                        : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isProcessing = true;
                          });

                          try {
                            if (_registerFormKey.currentState!
                                .validate()) {
                              User? user = await FirebaseAuthHelper
                                  .registerUsingEmailPassword(
                                name: _nameTextController.text,
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                              ).timeout(Duration(seconds: 10), onTimeout: () {
                                throw Exception(
                                    'Registration timed out. Please try again.');
                              });

                              if (user != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen2(),
                                  ),
                                  ModalRoute.withName('/'),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content: Text('Failed to register user')),
                                );
                              }
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          } finally {
                            setState(() {
                              _isProcessing = false;
                            });
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Or Continue with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(FontAwesomeIcons.google, 'Google'),
                  SizedBox(width: 16),
                  _buildSocialButton(FontAwesomeIcons.facebook, 'Facebook'),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  "By Continuing You Confirm That You Agree With Our\nTerms And Conditions",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ), // Icon color based on theme
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String platform) {
    return ElevatedButton(
      onPressed: () {
        // Handle social media login here
      },
      child: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white, // Adjust icon color based on theme
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black, // Button background color based on theme
        padding: EdgeInsets.all(16),
      ),
    );
  }
}

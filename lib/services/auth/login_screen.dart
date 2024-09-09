import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../provider/controller/loginController.dart';
import '../../services/auth/signup_screen.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../helper/utils.dart';
import '../../widgets/SnackBarUtils.dart';
import '../../widgets/rounded_botton.dart';
import 'Forgot_password_page.dart';
import 'login_withphone_number.dart';
import '../../widgets/LoadingOverlay.dart'; // Import LoadingOverlay

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool obscureText = true; // Boolean to manage password visibility

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText; // Toggle the password visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => LoginController(),
          child: Consumer<LoginController>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.blue.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 70),
                            Image.asset(
                              'assets/loginpng.png',
                              width: 220,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    decoration: buildInputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Icons.alternate_email,
                                      iconColor: Colors.black, // Assuming iconcolor is Colors.black
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        Utils.flushBarErrorMessage(
                                          "Enter email",
                                          Colors.red,
                                          context,
                                        );
                                        return "Enter email";
                                      }
                                      String email = value.trim().toLowerCase(); // Convert email to lowercase
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: passwordController,
                                    obscureText: obscureText, // Use the boolean to manage visibility
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey[600]),
                                      prefixIcon: Icon(Icons.password_rounded, color: Colors.black),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscureText ? Icons.visibility_off : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                        onPressed: _togglePasswordVisibility, // Toggle password visibility
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color:  iconcolor, width: 2.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        Utils.flushBarErrorMessage(
                                          "Enter password",
                                          Colors.red,
                                          context,
                                        );
                                        return "Enter password";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            roundedbotton(
                              title: "Login",
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  String email = emailController.text.trim().toLowerCase(); // Convert email to lowercase
                                  String password = passwordController.text;

                                  provider.loginWithApi(
                                    context,
                                    email,
                                    password,
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: Text("Sign Up"),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => loginwithphonenumber()),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login With Phone Number",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  LoadingOverlay(isLoading: provider.loading), // Show loading overlay
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    required Color iconColor,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(prefixIcon, color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color:  iconcolor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }
}

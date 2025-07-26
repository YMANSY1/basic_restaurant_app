import 'package:basic_restaurant_app/features/auth/services/auth_service.dart';
import 'package:basic_restaurant_app/features/auth/widgets/auth_button.dart';
import 'package:basic_restaurant_app/features/auth/widgets/auth_field.dart';
import 'package:basic_restaurant_app/features/auth/widgets/grey_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                // **Title Widget**
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, bottom: 26.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to Saffron and Spice",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(
                              0xffffd700), // A deep green for "CircularChem"
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Authentic Middle Eastern Dishes at Your Fingertips!",
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color:
                              Colors.grey[600], // A softer grey for the tagline
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      Obx(() {
                        return Text(
                          authController.isLogin.value ? 'Login' : 'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        );
                      })
                    ],
                  ),
                ),
                // **End of Title Widget**
                AuthField(
                  controller: _emailController,
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return AuthField(
                    controller: _passwordController,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    obscureText: authController.isObscured.value,
                    postfixIcon: IconButton(
                      icon: Icon(authController.isObscured.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => authController.toggleObscured(),
                    ),
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GreyTextButton(
                      onPressed: () {},
                      text: 'Forgot Password?',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Obx(() {
                    return Center(
                      child: AuthButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              if (!authController.isLogin.value) {
                                await AuthService(FirebaseAuth.instance)
                                    .createAccount(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              } else {
                                // Login logic
                                await AuthService(FirebaseAuth.instance)
                                    .loginWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              print('error code is: ${e.code}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            } catch (e) {
                              print('error code is: ${e.toString()}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          }
                        },
                        text:
                            authController.isLogin.value ? 'Login' : 'Sign Up',
                        width: screenWidth * 0.8,
                      ),
                    );
                  }),
                ),
                Obx(() {
                  return GreyTextButton(
                    onPressed: () {
                      authController.toggleMode();
                      _emailController.clear();
                      _passwordController.clear();
                      authController.isObscured.value = true;
                    },
                    text: authController.isLogin.value
                        ? 'No account yet? Register now!'
                        : 'Already have an account? Login now!',
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? emptyValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }
}

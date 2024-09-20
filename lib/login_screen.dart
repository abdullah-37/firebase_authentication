import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_system/home_screen.dart';
import 'package:firebase_authentication_system/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 248, 246),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(children: [
              Positioned(
                child: Container(
                  height: 500,
                  width: size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff48c6f9),
                        Color(0xff58e0aa),
                      ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
              ),
              //circle 1
              Positioned(
                left: -130,
                right: 0,
                top: -70,
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xff1578f8),
                        Color(0xff44c5ff),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                right: 0,
                left: 0,
                child: InputBox(size: size, email: email, password: password),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  InputBox({
    super.key,
    required this.size,
    required this.email,
    required this.password,
  });

  final Size size;

  final TextEditingController email;
  final TextEditingController password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
          child: Container(
            // height: 350,
            width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  //Email Text Field

                  // Password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: const Icon(Icons.mail),
                        hintText: 'Enter your email',
                        // helperText: 'Enter your name'
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Enter your password',
                        // helperText: 'Enter your name'
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: GestureDetector(
                      onTap: () async {
                        void showLoadingDialog() {
                          showDialog(
                            context: context,
                            barrierDismissible:
                                false, // Prevent closing the dialog by tapping outside
                            builder: (context) {
                              return const Center(
                                child:
                                    CircularProgressIndicator(), // Show loading spinner
                              );
                            },
                          );
                        }

                        showLoadingDialog();
                        UserCredential logincredential =
                            await _auth.signInWithEmailAndPassword(
                                email: email.text, password: password.text);

                        if (logincredential.user != null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 40,
                          // width: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xff58e0aa),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Dont have account? Signup',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

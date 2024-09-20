import 'dart:ui';

import 'package:firebase_authentication_system/authenticaton.dart';
import 'package:firebase_authentication_system/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffd3effb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(children: [
              Positioned(
                child: Container(
                  height: size.height * 0.6,
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
              InputBox(
                size: size,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  const InputBox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmpassword = TextEditingController();

  String? nameerrormessage;
  String? emailerrormessage;
  String? passworderrormessage;
  String? confirmpassworderrormessage;

  @override
  void initState() {
    super.initState();

    // Add listener to name TextEditingController
    name.addListener(() {
      if (name.text.isNotEmpty && nameerrormessage != null) {
        setState(() {
          nameerrormessage = null; // Clear the error message when user types
        });
      }
    });
    // email
    email.addListener(() {
      if (email.text.isNotEmpty && emailerrormessage != null) {
        setState(() {
          emailerrormessage = null; // Clear the error message when user types
        });
      }
    });
    password.addListener(() {
      if (password.text.isNotEmpty && passworderrormessage != null) {
        setState(() {
          passworderrormessage =
              null; // Clear the error message when user types
        });
      }
    });
    confirmpassword.addListener(() {
      if (confirmpassword.text.isNotEmpty &&
          confirmpassworderrormessage != null) {
        setState(() {
          confirmpassworderrormessage =
              null; // Clear the error message when user types
        });
      }
    });
  }

  // void _showLoadingDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible:
  //         false, // Prevent closing the dialog by tapping outside
  //     builder: (context) {
  //       return const Center(
  //         child: CircularProgressIndicator(), // Show loading spinner
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
          child: Container(
            // height: 450,
            width: widget.size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30),

                  //name Text Field
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyInputField(
                        controller: name,
                        hinttext: 'Enter your name',
                        icon: const Icon(Icons.account_circle),
                        errormessage: nameerrormessage,
                      )),
                  SizedBox(height: widget.size.height * 0.03),

                  // Email field
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyInputField(
                        controller: email,
                        hinttext: 'Enter your email',
                        icon: const Icon(Icons.mail),
                        errormessage: emailerrormessage,
                      )),
                  SizedBox(height: widget.size.height * 0.03),

                  // password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyInputField(
                      controller: password,
                      hinttext: 'Enter your Password',
                      icon: const Icon(Icons.lock),
                      errormessage: passworderrormessage,
                    ),
                  ),
                  SizedBox(height: widget.size.height * 0.03),
                  // Confirm password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyInputField(
                      controller: confirmpassword,
                      hinttext: 'Confirm your Password',
                      icon: const Icon(Icons.lock),
                      errormessage: confirmpassworderrormessage,
                    ),
                  ),

                  // Signup button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (name.text.isEmpty) {
                            nameerrormessage = 'Field cannot be empty';
                          }

                          if (!email.text.contains('@')) {
                            emailerrormessage = 'Please enter a valid email';
                          }
                          if (email.text.isEmpty) {
                            emailerrormessage = 'Field cannot be empty';
                          }

                          if (password.text.length < 8) {
                            passworderrormessage =
                                'Password must contains 8 letters';
                          }
                          if (password.text.isEmpty) {
                            passworderrormessage = 'Field cannot be empty';
                          }
                          if (confirmpassword.text.isEmpty) {
                            confirmpassworderrormessage =
                                'Field cannot be empty';
                          }
                          if (password.text != confirmpassword.text) {
                            confirmpassworderrormessage =
                                'Password does not match';
                          }
                          if (nameerrormessage == null &&
                              emailerrormessage == null &&
                              passworderrormessage == null &&
                              confirmpassworderrormessage == null) {
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

                            // print('ok');
                            myfunction() async {
                              String res = await AuthService().signUp(
                                  name: name.text,
                                  email: email.text,
                                  password: password.text);
                              if (res == 'Success') {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              }
                            }

                            myfunction();
                          }
                        });
                      },
                      // onTap: () async {
                      //
                      // },
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
                            'Signup',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ),
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

class MyInputField extends StatelessWidget {
  const MyInputField({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.icon,
    this.errormessage,
  });
  final String hinttext;
  final Icon icon;
  final TextEditingController controller;
  final String? errormessage;

  @override
  Widget build(BuildContext context) {
    // String? msg = 'e333wrfewfg';
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: icon,
        hintText: hinttext,
        errorText: errormessage,

        // helperText: 'Enter your name'
      ),
    );
  }
}

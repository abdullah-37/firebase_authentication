import 'package:firebase_authentication_system/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCljdeJgho4JzT4BzgRiaXNzUmCDBJ5_3A",
        authDomain: "flutter-authentication-6b9b6.firebaseapp.com",
        projectId: "flutter-authentication-6b9b6",
        storageBucket: "flutter-authentication-6b9b6.appspot.com",
        messagingSenderId: "79259104234",
        appId: "1:79259104234:web:64244063ad7e909089b893",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

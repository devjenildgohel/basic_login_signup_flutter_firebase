import 'package:basic_login_signup_firebase/auth.dart';
import 'package:basic_login_signup_firebase/screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = auth().currentUser;

  Future<void> signOut() async {
    await auth().signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(user?.email ?? "user email"),
          TextButton(
            onPressed: signOut,
            child: const Text("Signout"),
          )
        ],
      ),
    );
  }
}

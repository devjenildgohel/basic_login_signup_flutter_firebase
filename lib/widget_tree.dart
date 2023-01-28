import 'package:basic_login_signup_firebase/auth.dart';
import 'package:basic_login_signup_firebase/screens/HomePage.dart';
import 'package:basic_login_signup_firebase/screens/LoginPage.dart';
import 'package:basic_login_signup_firebase/screens/LoginSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class widget_tree extends StatefulWidget {
  const widget_tree({super.key});

  @override
  State<widget_tree> createState() => _widget_treeState();
}

class _widget_treeState extends State<widget_tree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginSelectionPage();
        }
      },
    );
  }
}

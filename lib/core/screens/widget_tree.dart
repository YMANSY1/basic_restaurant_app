import 'package:basic_restaurant_app/features/menu/screens/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../features/auth/auth_screen.dart';
import '../../features/auth/services/auth_service.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService(FirebaseAuth.instance).authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MenuScreen();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}

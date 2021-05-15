import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return MaterialApp(
              title: 'Gerente Loja',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LoginScreen(),
              debugShowCheckedModeBanner: false,
            );
        }
      },
    );
  }
}

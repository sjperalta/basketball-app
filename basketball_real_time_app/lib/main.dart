import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MarcadorBasketApp());
}

class MarcadorBasketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marcador de Basketball',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Puedes personalizar el tema aquí
        brightness: Brightness.dark, // Para el modo oscuro
      ),
      home: MarcadorHomeScreen(),
    );
  }
}
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const RomeVisitApp());
}

/// App raiz: guia turistica narrativa de Roma por personajes historicos.
class RomeVisitApp extends StatelessWidget {
  const RomeVisitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia de Roma',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

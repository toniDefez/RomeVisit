import 'package:flutter/material.dart';

import '../data/rome_data.dart';
import '../widgets/act_card.dart';
import 'character_intro_screen.dart';

/// Pantalla 1: seleccion de acto/dia.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guia de Roma')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          for (final acto in actos)
            ActCard(
              acto: acto,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CharacterIntroScreen(acto: acto),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

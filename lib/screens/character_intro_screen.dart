import 'package:flutter/material.dart';

import '../models/acto.dart';
import '../services/route_session.dart';
import 'route_map_screen.dart';

/// Pantalla 2: introduccion al personaje del dia.
class CharacterIntroScreen extends StatelessWidget {
  const CharacterIntroScreen({super.key, required this.acto});

  final Acto acto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(acto.personaje)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(acto.diaSemana, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(acto.personaje, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text(acto.biografia, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            Text(acto.porQueEsSuDia, style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final sesion = RouteSession(acto)..iniciar();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RouteMapScreen(sesion: sesion),
                    ),
                  );
                },
                child: const Text('Comenzar ruta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

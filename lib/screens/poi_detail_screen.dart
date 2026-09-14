import 'package:flutter/material.dart';

import '../models/poi.dart';

/// Pantalla 4: detalle de un POI, con su relato.
class PoiDetailScreen extends StatelessWidget {
  const PoiDetailScreen({super.key, required this.poi});

  final Poi poi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(poi.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(poi.hora, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 16),
            Text(poi.nota, style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Continuar ruta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

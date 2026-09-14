import 'package:flutter/material.dart';

import '../models/acto.dart';

/// Tarjeta seleccionable de un acto/dia en la pantalla Home.
class ActCard extends StatelessWidget {
  const ActCard({super.key, required this.acto, required this.onTap});

  final Acto acto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          acto.personaje,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text('${acto.diaSemana} · ${acto.pois.length} paradas'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

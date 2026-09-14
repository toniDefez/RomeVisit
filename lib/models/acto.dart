import 'poi.dart';

/// Un acto/dia de la guia: un personaje historico y su ruta de POIs.
class Acto {
  final String id;
  final String diaSemana;
  final String personaje;
  final String biografia;
  final String porQueEsSuDia;
  final List<Poi> pois;

  const Acto({
    required this.id,
    required this.diaSemana,
    required this.personaje,
    required this.biografia,
    required this.porQueEsSuDia,
    required this.pois,
  });
}

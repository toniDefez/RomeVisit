/// Un punto de interes (POI) de una ruta: un lugar concreto que se visita
/// durante el dia, con su relato ligado al personaje del acto.
class Poi {
  final String id;
  final String nombre;
  final double lat;
  final double lon;
  final String hora;
  final String nota;

  const Poi({
    required this.id,
    required this.nombre,
    required this.lat,
    required this.lon,
    required this.hora,
    required this.nota,
  });
}

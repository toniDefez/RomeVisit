import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../data/rome_data.dart';
import '../models/poi.dart';
import '../services/route_session.dart';
import 'poi_detail_screen.dart';

/// Pantalla 3: mapa con la ruta del dia, posicion del usuario y marcadores
/// de POI. Escucha [RouteSession] para pintar la posicion y avisar llegadas.
class RouteMapScreen extends StatefulWidget {
  const RouteMapScreen({super.key, required this.sesion});

  final RouteSession sesion;

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    widget.sesion.dispose();
    super.dispose();
  }

  List<LatLng> get _puntosRuta => [
        LatLng(hotelLat, hotelLon),
        for (final poi in widget.sesion.acto.pois) LatLng(poi.lat, poi.lon),
        LatLng(hotelLat, hotelLon),
      ];

  @override
  Widget build(BuildContext context) {
    final sesion = widget.sesion;

    return Scaffold(
      appBar: AppBar(
        title: Text(sesion.acto.personaje),
        actions: [
          ListenableBuilder(
            listenable: sesion,
            builder: (context, _) => IconButton(
              tooltip: sesion.hapticaSilenciada
                  ? 'Reactivar avisos'
                  : 'Silenciar avisos',
              icon: Icon(
                sesion.hapticaSilenciada
                    ? Icons.notifications_off
                    : Icons.notifications_active,
              ),
              onPressed: sesion.alternarSilencio,
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: sesion,
        builder: (context, _) {
          if (!sesion.permisoConcedido) {
            return _PermisoUbicacion(sesion: sesion);
          }
          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(hotelLat, hotelLon),
                  initialZoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.rome_visit',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _puntosRuta,
                        strokeWidth: 4,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(hotelLat, hotelLon),
                        child: const Icon(Icons.hotel, color: Colors.brown),
                      ),
                      for (final poi in sesion.acto.pois)
                        Marker(
                          point: LatLng(poi.lat, poi.lon),
                          child: GestureDetector(
                            onTap: () => _abrirPoi(context, poi),
                            child: Icon(
                              Icons.location_on,
                              color: sesion.haVisitado(poi)
                                  ? Colors.green
                                  : Colors.red,
                              size: 36,
                            ),
                          ),
                        ),
                      if (sesion.posicionActual != null)
                        Marker(
                          point: LatLng(
                            sesion.posicionActual!.latitude,
                            sesion.posicionActual!.longitude,
                          ),
                          child: const Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (sesion.ultimoPoiNotificado != null)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Card(
                    color: Colors.green.shade600,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Has llegado a ${sesion.ultimoPoiNotificado!.nombre}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _abrirPoi(BuildContext context, Poi poi) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PoiDetailScreen(poi: poi)),
    );
  }
}

class _PermisoUbicacion extends StatelessWidget {
  const _PermisoUbicacion({required this.sesion});

  final RouteSession sesion;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_off, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Activa la ubicacion para ver tu posicion en el mapa y '
              'recibir los avisos al llegar a cada punto.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: sesion.iniciar,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

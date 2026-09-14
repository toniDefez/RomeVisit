import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vibration/vibration.dart';

import '../models/acto.dart';
import '../models/poi.dart';

/// Radio de deteccion de llegada a un POI, en metros.
const double radioLlegadaMetros = 30;

/// Controla la sesion de una ruta en curso: escucha el GPS, detecta la
/// llegada a cada POI (una vez por sesion) y dispara el aviso haptico.
class RouteSession extends ChangeNotifier {
  RouteSession(this.acto);

  final Acto acto;

  StreamSubscription<Position>? _subscripcionPosicion;

  Position? posicionActual;
  bool permisoConcedido = false;
  bool hapticaSilenciada = false;
  Poi? ultimoPoiNotificado;

  final Set<String> _poisNotificados = {};

  bool haVisitado(Poi poi) => _poisNotificados.contains(poi.id);

  /// Pide permiso de ubicacion y, si se concede, empieza a escuchar el GPS.
  Future<void> iniciar() async {
    final servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) {
      permisoConcedido = false;
      notifyListeners();
      return;
    }

    var permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    permisoConcedido = permiso == LocationPermission.whileInUse ||
        permiso == LocationPermission.always;
    notifyListeners();

    if (!permisoConcedido) return;

    _subscripcionPosicion?.cancel();
    _subscripcionPosicion = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 8,
      ),
    ).listen(_onNuevaPosicion);
  }

  void _onNuevaPosicion(Position posicion) {
    posicionActual = posicion;

    for (final poi in acto.pois) {
      if (_poisNotificados.contains(poi.id)) continue;

      final distancia = Geolocator.distanceBetween(
        posicion.latitude,
        posicion.longitude,
        poi.lat,
        poi.lon,
      );

      if (distancia <= radioLlegadaMetros) {
        _poisNotificados.add(poi.id);
        ultimoPoiNotificado = poi;
        _avisarLlegada();
        break;
      }
    }

    notifyListeners();
  }

  void _avisarLlegada() {
    if (hapticaSilenciada) return;
    Vibration.hasVibrator().then((soportado) {
      if (soportado) {
        Vibration.vibrate(duration: 800);
      }
    });
  }

  /// Alterna el silencio de la haptica. El aviso visual y el registro de
  /// "visitado" no se ven afectados por este boton.
  void alternarSilencio() {
    hapticaSilenciada = !hapticaSilenciada;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscripcionPosicion?.cancel();
    super.dispose();
  }
}

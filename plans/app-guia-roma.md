# Plan: App Guía de Roma (MVP)

**Creado:** 2026-09-14 | **Estado:** Draft | **Esfuerzo:** M | **Branch:** main

## Resumen

App Flutter Android-only, guía narrativa de Roma en 4 actos (Augusto, Julio II, Bernini, Adriano). 4 pantallas (Home → Intro personaje → Mapa → Detalle POI), mapa con flutter_map+OSM, posición GPS en vivo, aviso háptico al entrar a 30m de un POI (una vez por sesión). Proyecto personal — MVP funcional, sin pulir casos límite no pedidos por el spec.

## Architecture Context

**Decisión de Boss: proyecto personal, MVP puro — "que funcione", sin TDD (no hay Flutter/Dart instalado en este entorno, no se puede ejecutar ni verificar tests), sin capas extra tipo hexagonal estricto. Estructura plana, código directo.**

- `models/`: `Poi`, `Acto` — clases de datos simples.
- `data/rome_data.dart`: los 4 actos con sus POIs hardcodeados (del PDF), separados de la UI (único requisito no negociable del spec original).
- `services/route_session.dart`: `ChangeNotifier` único que hace TODO el trabajo de sesión — mantiene stream de `geolocator`, calcula distancia con `Geolocator.distanceBetween`, marca `Set<String>` de POIs visitados, llama a `Vibration.vibrate` si no está silenciado. Sin puertos/adaptadores separados — llama a los paquetes directamente.
- `screens/`: `home_screen.dart`, `character_intro_screen.dart`, `route_map_screen.dart`, `poi_detail_screen.dart`. Navegación con `Navigator.push` simple, sin named routes.
- El `RouteSessionController` se crea al pulsar "Comenzar ruta" en P2 y se pasa por constructor a P3; P3 lo reutiliza al empujar P4. Sin `provider`, sin persistencia — se pierde al volver a Home (aceptado, es MVP).

## Research Findings

- `flutter_map: ^8.3.2` + `latlong2: ^0.10.1` (`LatLng`). `TileLayer` con `urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'` y `userAgentPackageName` **obligatorio** por política de OSM. `MarkerLayer`/`Marker`, `PolylineLayer`/`Polyline`, `MapController.fitCamera(...)` para encajar la ruta al entrar.
- `geolocator: ^14.0.3` — requiere Flutter ≥3.29 (compatible con el SDK Dart ^3.13.3 ya fijado en pubspec.yaml). `minSdkVersion` hereda `flutter.minSdkVersion` (21+ viable, ya es el scaffold actual). Flujo: `isLocationServiceEnabled()` → `checkPermission()`/`requestPermission()` → `getPositionStream(locationSettings: LocationSettings(accuracy: high, distanceFilter: 8))`. `Geolocator.distanceBetween(...)` para el radio de 30m.
- `HapticFeedback` nativo NO soporta duración custom (~800ms); usar paquete `vibration: ^3.2.1` (`Vibration.vibrate(duration: 800)`), requiere `<uses-permission android:name="android.permission.VIBRATE"/>` declarado a mano en el manifest (no se añade solo).
- Patrón de detección: `Set<String> _notificados`; se marca ANTES de disparar el aviso (evita doble disparo); `distanceFilter: 8` en el stream para no "saltarse" el radio de 30m entre lecturas.
- `ChangeNotifier` + `ListenableBuilder` nativo (Flutter ≥3.7) es suficiente para 2 pantallas — no añadir `provider` (YAGNI).

## Security Considerations

- Ninguna superficie de auth/datos sensibles — app sin backend, sin login, sin datos de usuario persistidos.
- Único permiso sensible: ubicación en primer plano — solicitado en runtime, sin tracking en background.

## Performance Considerations

- `distanceFilter: 8` limita el ritmo de eventos del stream de posición; cálculo de distancia contra 5-9 POIs por evento es trivial (Haversine puro).
- Cancelar `StreamSubscription<Position>` en `dispose()` de `RouteMapScreen` — evita fugas y `setState` tras dispose.

## Decisiones (MVP, sin bloquear en preguntas)

- Estado "visitado"/"silenciado" vive en `RouteSessionController`, en memoria, vida = sesión de navegación del acto. Sin persistencia.
- Centrado del mapa: `fitCamera` sobre hotel + todos los POIs del acto al entrar en P3. Sin botón "centrar en mí" (fuera de MVP).
- Permiso denegado / GPS apagado: mensaje simple en el mapa ("Activa la ubicación para ver tu posición y los avisos") + botón "Reintentar" que vuelve a comprobar el permiso. Sin flujo de ajustes del sistema (fuera de MVP).
- Botón "silenciar": solo evita la llamada a `Vibration.vibrate`; el aviso visual y el registro de "visitado" se mantienen igual.
- Sin pantalla de fin de ruta ni resumen (fuera de MVP, explícito).
- Ruta dibujada como polilínea recta hotel→POI1→...→POIn→hotel (sin motor de rutas real, acorde al alcance v1 del spec).

## Steps

### Step 1: Modelo de dominio y datos
- **Test:** `test/domain/poi_test.dart`, `test/domain/rome_data_test.dart` — cada acto tiene POIs con coordenadas válidas y orden correcto; 4 actos, conteo de POIs esperado (5,7,9,2).
- **Implement:** `lib/domain/poi.dart`, `lib/domain/acto.dart`, `lib/data/rome_data.dart` (datos de los 4 actos + hotel).
- **Validation:** `flutter test test/domain/`

### Step 2: ArrivalDetector (lógica de llegada)
- **Test:** `test/domain/arrival_detector_test.dart` — dispara una vez por POI dentro de 30m; no repite si se re-evalúa la misma posición; no dispara fuera de radio.
- **Implement:** `lib/domain/arrival_detector.dart` — usa `Geolocator.distanceBetween` (método estático puro, sin platform channel, seguro en tests sin mocks).
- **Depends on:** Step 1
- **Validation:** `flutter test test/domain/arrival_detector_test.dart`

### Step 3: RouteSessionController + puertos
- **Test:** `test/application/route_session_controller_test.dart` — con un `LocationSource`/`HapticNotifier` fake, verifica que al recibir una posición dentro de 30m se marca visitado y se llama al notificador; que silenciar evita la llamada al notificador pero mantiene el visitado.
- **Implement:** `lib/application/ports/location_source.dart`, `lib/application/ports/haptic_notifier.dart`, `lib/application/route_session_controller.dart` (ChangeNotifier).
- **Depends on:** Step 2
- **Validation:** `flutter test test/application/`

### Step 4: Adaptadores reales (geolocator, vibration)
- **Implement:** `lib/infrastructure/geolocator_location_source.dart`, `lib/infrastructure/vibration_haptic_notifier.dart`; añadir permiso `VIBRATE` y `ACCESS_FINE_LOCATION`/`ACCESS_COARSE_LOCATION` a `android/app/src/main/AndroidManifest.xml`.
- **Depends on:** Step 3
- **Validation:** revisión manual (no testeable sin dispositivo/emulador — Boss confirmó que no se probará en local)

### Step 5: Pantallas P1 Home y P2 Intro personaje
- **Test:** `test/presentation/home_screen_test.dart` — 4 tarjetas visibles, tap navega a intro con el acto correcto.
- **Implement:** `lib/presentation/screens/home_screen.dart`, `lib/presentation/screens/character_intro_screen.dart`, `lib/presentation/widgets/act_card.dart`.
- **Depends on:** Step 1
- **Validation:** `flutter test test/presentation/home_screen_test.dart`

### Step 6: Pantalla P3 Mapa
- **Implement:** `lib/presentation/screens/route_map_screen.dart` — `FlutterMap` con `TileLayer` OSM, `MarkerLayer` (hotel + POIs), `PolylineLayer`, `ListenableBuilder` sobre `RouteSessionController`, banner "Has llegado", botón silenciar/reactivar, gate de permiso simple.
- **Depends on:** Step 3, Step 4, Step 5
- **Visual — requiere verificación humana:** disposición de marcadores, legibilidad del banner de llegada.
- **Validation:** compilación (`flutter analyze`), sin test automatizado del mapa en sí (widget de terceros, bajo ROI para MVP).

### Step 7: Pantalla P4 Detalle POI
- **Test:** `test/presentation/poi_detail_screen_test.dart` — muestra título, hora y relato del POI pasado; botón "Continuar ruta" hace pop.
- **Implement:** `lib/presentation/screens/poi_detail_screen.dart`.
- **Depends on:** Step 6
- **Validation:** `flutter test test/presentation/poi_detail_screen_test.dart`

### Step 8: main.dart y pubspec
- **Implement:** `lib/main.dart` (arranca en Home, tema simple), `pubspec.yaml` (añadir `flutter_map: ^8.3.2`, `latlong2: ^0.10.1`, `geolocator: ^14.0.3`, `vibration: ^3.2.1`), borrar `test/widget_test.dart` del contador de ejemplo (ya no aplica).
- **Depends on:** Steps 5,6,7
- **Validation:** `flutter analyze` (no se ejecuta `flutter build apk` en este entorno — sin Flutter SDK instalado; queda para Boss)

### Step 9: README
- **Implement:** `README.md` con pasos exactos: instalar Flutter+Android SDK, `flutter pub get`, `flutter build apk`, ruta del APK generado (`build/app/outputs/flutter-apk/app-release.apk`), instalación en móvil activando orígenes desconocidos.
- **Depends on:** Step 8

## Acceptance Criteria

- [ ] `flutter analyze` sin errores (verificación estática, sin build real en este entorno)
- [ ] Los 4 actos y todos sus POIs están cargados con coordenadas del spec
- [ ] Tests de dominio y aplicación en verde
- [ ] README con pasos exactos de build/instalación
- [ ] Código comentado en español

## Checklist (non-TDD cleanup)

- [ ] Lint clean (`flutter analyze`)
- [ ] `test/widget_test.dart` (contador de ejemplo) eliminado
- [ ] Sin dependencias no usadas en pubspec.yaml

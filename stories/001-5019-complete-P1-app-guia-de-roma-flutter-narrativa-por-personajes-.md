---
id: 001-5019
title: App Guia de Roma - Flutter narrativa por personajes historicos
status: complete
priority: P1
type: feature
created: "2026-09-14T18:15:46.699Z"
updated: "2026-09-14T18:27:26.601Z"
dependencies: []
started_at: "2026-09-14T18:24:28.227Z"
completed_at: "2026-09-14T18:27:26.600Z"
---

# App Guia de Roma - Flutter narrativa por personajes historicos

## Problem Statement

Segun docs/prompt-app-roma.pdf necesitamos un proyecto Flutter completo y compilable para Android: guia turistica narrativa de Roma organizada en 4 actos/dias (Augusto, Julio II, Bernini, Adriano), con mapa (flutter_map + OSM), geolocalizacion (geolocator), aviso haptico de llegada a POI (radio 30m, una vez por sesion), pantallas Home/Intro personaje/Mapa/Detalle POI, datos de los 4 actos separados de la UI, README con pasos de build/instalacion del APK, todo en espanol de Espana.

## Acceptance Criteria

- [REJECTED] Proyecto Flutter compila con flutter build apk (No hay Flutter SDK instalado en este entorno (confirmado por Boss); requiere verificacion manual ejecutando flutter pub get && flutter build apk)
- [x] Pantalla Home con las 4 tarjetas de dia/acto
- [x] Pantalla intro de personaje con boton Comenzar ruta
- [x] Pantalla de mapa con flutter_map + OSM, posicion GPS, marcadores POI en orden, boton pausar/reanudar haptica
- [x] Pantalla detalle de POI con relato y boton Continuar ruta
- [x] Logica haptica de llegada a 30m, una vez por POI por sesion, con boton global silenciar/reactivar
- [x] Modelo de datos con los POIs de los 4 actos (nombre, lat, lon, hora, nota/relato) separado de la UI
- [x] Permiso ACCESS_FINE_LOCATION con solicitud en tiempo de ejecucion, minSdk 21+
- [x] README con pasos exactos de instalacion Flutter/Android SDK, build APK, localizar e instalar el APK
- [x] Codigo comentado en espanol

## Files

- docs/prompt-app-roma.pdf

## QA

Sin verificacion automatizada: no hay Flutter SDK instalado en este entorno (confirmado por Boss). Revision estatica manual de imports, nombres de API y coordenadas contra la spec y la investigacion de paquetes (flutter_map 8.3.2, geolocator 14.0.3, vibration 3.2.1, latlong2 0.10.1). Pendiente de que Boss ejecute flutter pub get && flutter build apk para confirmar compilacion real.

## Work Log

### 2026-09-14T18:26:54.502Z - Implementado MVP: modelos Poi/Acto, datos de los 4 actos, RouteSession (GPS + haptica via geolocator/vibration), pantallas Home/Intro/Mapa/Detalle con flutter_map+OSM, permisos Android, README con pasos de build. Sin tests automatizados ni build local (Flutter SDK no disponible en este entorno; decision explicita de Boss: MVP funcional, sin ceremonia de calidad).


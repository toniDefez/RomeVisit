---
id: "001-5019"
title: "App Guia de Roma - Flutter narrativa por personajes historicos"
status: pending
priority: P1
type: feature
created: 2026-09-14T18:15:46.699Z
updated: 2026-09-14T18:15:46.699Z
dependencies: []
---

# App Guia de Roma - Flutter narrativa por personajes historicos

## Problem Statement

Segun docs/prompt-app-roma.pdf necesitamos un proyecto Flutter completo y compilable para Android: guia turistica narrativa de Roma organizada en 4 actos/dias (Augusto, Julio II, Bernini, Adriano), con mapa (flutter_map + OSM), geolocalizacion (geolocator), aviso haptico de llegada a POI (radio 30m, una vez por sesion), pantallas Home/Intro personaje/Mapa/Detalle POI, datos de los 4 actos separados de la UI, README con pasos de build/instalacion del APK, todo en espanol de Espana.

## Acceptance Criteria

- [ ] Proyecto Flutter compila con flutter build apk
- [ ] Pantalla Home con las 4 tarjetas de dia/acto
- [ ] Pantalla intro de personaje con boton Comenzar ruta
- [ ] Pantalla de mapa con flutter_map + OSM, posicion GPS, marcadores POI en orden, boton pausar/reanudar haptica
- [ ] Pantalla detalle de POI con relato y boton Continuar ruta
- [ ] Logica haptica de llegada a 30m, una vez por POI por sesion, con boton global silenciar/reactivar
- [ ] Modelo de datos con los POIs de los 4 actos (nombre, lat, lon, hora, nota/relato) separado de la UI
- [ ] Permiso ACCESS_FINE_LOCATION con solicitud en tiempo de ejecucion, minSdk 21+
- [ ] README con pasos exactos de instalacion Flutter/Android SDK, build APK, localizar e instalar el APK
- [ ] Codigo comentado en espanol

## Files

- docs/prompt-app-roma.pdf

## Work Log


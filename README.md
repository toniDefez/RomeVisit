# Guia de Roma

App Flutter (solo Android) con una guia turistica narrativa de Roma en cuatro
actos: Augusto, Julio II, Bernini y Adriano. Cada acto tiene su ruta de
puntos de interes (POI) sobre un mapa OpenStreetMap, con aviso por vibracion
al llegar a cada uno (radio de 30 m, una vez por sesion).

## 1. Instalar Flutter y el SDK de Android

1. Instala el SDK de Android: la forma mas sencilla es instalando
   [Android Studio](https://developer.android.com/studio) y, desde
   `SDK Manager`, la ultima `Android SDK Platform` y `Android SDK
   Build-Tools`.
2. Instala Flutter siguiendo la guia oficial para tu sistema operativo:
   https://docs.flutter.dev/get-started/install
3. Comprueba que todo esta correcto:
   ```
   flutter doctor
   ```
   Resuelve cualquier aviso relacionado con Android (licencias del SDK,
   `cmdline-tools`, etc.) que te indique `flutter doctor`. Para aceptar las
   licencias del SDK de Android:
   ```
   flutter doctor --android-licenses
   ```

## 2. Descargar las dependencias del proyecto

Desde la carpeta raiz del proyecto (donde esta `pubspec.yaml`):

```
flutter pub get
```

## 3. Compilar el APK

```
flutter build apk
```

Esto genera una version release del APK. Si algun paso falla por versiones
de dependencias, ejecuta `flutter pub upgrade` y vuelve a intentarlo.

## 4. Localizar el APK generado

El APK queda en:

```
build/app/outputs/flutter-apk/app-release.apk
```

## 5. Instalar el APK en un movil Android

1. Copia el archivo `app-release.apk` al movil (cable USB, o subelo a
   Google Drive/WhatsApp/email y descargalo desde el movil).
2. En el movil, abre el archivo APK desde el gestor de archivos.
3. Si es la primera vez que instalas una app fuera de Google Play, Android
   te pedira activar el permiso "Instalar apps desconocidas" (u "Origenes
   desconocidos", segun la version de Android) para la app que uses para
   abrir el archivo (gestor de archivos, Gmail, etc.). Actívalo cuando te lo
   pida y confirma la instalacion.
4. Al abrir la app por primera vez, te pedira permiso de ubicacion para
   mostrar tu posicion en el mapa y avisarte al llegar a cada punto de
   interes. Concedelo ("Mientras se usa la app" es suficiente, no hace
   falta "Siempre").

## Notas

- La app necesita conexion a datos moviles o wifi para cargar el mapa
  (las teselas de OpenStreetMap se descargan online, no van empaquetadas).
- El GPS solo funciona con la pantalla de la app abierta (no hay
  seguimiento en segundo plano en esta version).
- Los datos de los cuatro actos (POIs, horarios, relatos) estan en
  `lib/data/rome_data.dart`, separados del resto del codigo para poder
  editarlos facilmente.

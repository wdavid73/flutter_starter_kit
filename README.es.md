# 🏗️ Proyecto Base en Flutter

Este es un proyecto base en Flutter diseñado como plantilla para futuros desarrollos. Contiene configuraciones y paquetes esenciales para iniciar rápidamente nuevos proyectos.

---

## 📌 Requisitos Previos

Asegúrate de tener instalados los siguientes elementos:

- **Flutter** (Si usas FVM, ejecuta `fvm use <versión>` para configurar la versión adecuada)
- **Dart**
- **Android Studio o VS Code** (Opcional pero recomendado)
- **Dispositivo físico o emulador configurado**

---

## 🚀 Comandos Útiles

| Comando             | Descripción                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| `flutter pub get`   | Descarga las dependencias del proyecto                                      |
| `flutter run`       | Ejecuta la aplicación en el dispositivo/emulador conectado                  |
| `flutter build apk` | Genera un archivo APK para Android                                          |
| `flutter build ios` | Genera la versión para iOS (requiere macOS)                                 |
| `flutter clean`     | Elimina archivos generados y limpia la caché                                |
| `fvm flutter run`   | (Si usas FVM) Ejecuta la app con la versión de Flutter definida en `.fvmrc` |
| `dart fix --apply`  | Aplica correcciones sugeridas automáticamente                               |
| `flutter analyze`   | Analiza el código en busca de errores y advertencias                        |
| `flutter test`      | Ejecuta los tests unitarios del proyecto                                    |

---

## 📦 Paquetes Utilizados

| Paquete | Descripción |
|---------|-------------|
<!--
| `flutter_bloc` | Gestión de estado basada en BLoC |
| `get_it` | Inyección de dependencias simple |
| `equatable` | Facilita la comparación de objetos en Dart |
| `dio` | Cliente HTTP potente y flexible |
| `shared_preferences` | Almacenamiento de datos clave-valor en el dispositivo |
| `flutter_localizations` | Soporte para múltiples idiomas |
| `hive` | Base de datos local rápida y eficiente |
-->
*(Puedes agregar más paquetes según lo requiera tu proyecto base.)*

---
## 🔧 Antes de ejecutar tu proyecto
Después de crear tu proyecto de Flutter en base a esta plantilla por favor realize los siguientes pasos

### 🌐 1. Variables de entorno

1. Crear el archivo .env basado en el archivo .env.template
2. Cambia el valor de tu variable API_URL

### ✏️ 2. Cambiar nombre del paquete

Como estas creando un proyecto en base a una plantilla es necesario que cambies el nombre de la app para evitar conflictos cuando desees subir tu app a las tiendas

- Verifica que el paquete **change_app_package_name** este en el archivo **pubspec.yaml** en la sección de **dev_dependencies**
- Ejecuta el siguiente comando para obtener todos los paquetes que el proyecto necesita inicialmente
```sh
flutter pub get
```
- Ahora ejecuta el siguiente comando para cambiar el nombre del app
```sh
dart run change_app_package_name:main com.<tu_dominio>.<nombre_del_app>
```
- **(Opcional)** si esta utilizando FVM **(Flutter Version Manager)** el comando es de la siguiente forma
```sh
fvm dart run change_app_package_name:main com.<tu_dominio>.<nombre_del_app>
```

### 📱 3. Cambiar launcher icon del app (Opcional)

Este paso es opcional, para cambiar el icono del app debes realizar lo siguiente

- Verifica que el paquete **flutter_launcher_icons** este en el **pubspec.yaml** en la sección de **dev_dependencies**
- En el pubspec.yaml ve a la sección **flutter_launcher_icons** y en la ruta especificada en **image_path** especifica el icono del tu app
- Ejecuta el siguiente comando para obtener todos los paquetes que el proyecto necesita inicialmente
```sh
flutter pub get
```
- Ahora ejecuta el siguiente comando para cambiar el icono del app
```sh
dart run flutter_launcher_icons
```
- **(Cuidado!)** si cambiaste la ruta del icono de tu app debes tambien cambiar la ruta en el pubspec.yaml
```
flutter:
  assets:
    - assets/icon/ <-- **Modifica la ruta de tu icono aquí**
```
- **(Opcional)** si esta utilizando FVM **(Flutter Version Manager)** el comando es de la siguiente forma
```sh
fvm dart run flutter_launcher_icons
```

### 🌅 4. Cambiar el splash screen del app (Opcional)

Si deseas cambiar el splash screen del app debes hacer los siguientes pasos

- Verifica en el archivo **pubspec.yaml** que el paquete **flutter_native_splash** este en la sección **dependencies**
- **(Opcional)** Si deseas cambiar el color del splash screen debes hacer lo siguiente
```
flutter_native_splash:
  color: "#252829" <-- **Modifica el color del splash screen aquí**
```
- Ejecuta el siguiente comando para obtener todos los paquetes que el proyecto necesita inicialmente
```sh
flutter pub get
```
- Ahora ejecuta el siguiente comando para cambiar el splash screen del app
```sh
dart run flutter_native_splash:create
```
- **(Opcional)** si esta utilizando FVM **(Flutter Version Manager)** el comando es de la siguiente forma
```sh
fvm dart run flutter_native_splash:create
```

---

## ▶️ Cómo Ejecutar el Proyecto

### Con Android Studio
1. Abre el proyecto en **Android Studio**.
2. Conecta un emulador o un dispositivo físico.
3. Presiona el botón **Run** o usa el atajo `Shift + F10`.

### Con Línea de Comandos
- Si usas FVM:
  ```sh
  fvm flutter pub get
  fvm flutter run
  ```
- Sin FVM:
  ```sh
  flutter pub get
  flutter run
  ```

## 📦 Crear Build (APK o AAB) para Android

Para crear un archivo APK o AAB para Android, sigue estos pasos:

Para crear un archivo APK o AAB para Android, sigue estos pasos:

1. **Generar APK**:
   Ejecuta el siguiente comando para generar un archivo APK:
   ```sh
   flutter build apk
   ```
    Este comando creará el archivo APK en el directorio ```build/app/outputs/flutter-apk/```.

2. **Generar AAB** (Android App Bundle):
   Si deseas generar un AAB (recomendado para la publicación en Google Play Store), utiliza el siguiente comando:
   ```sh
   flutter build appbundle
   ```
   Este comando creará el archivo AAB en el directorio ```build/app/outputs/bundle/release/```

3. **Opciones adicionales**:
   Si necesitas firmar el APK o AAB para producción, debes configurar tu ```keystore``` en el archivo ```build.gradle```. Asegúrate de tener un archivo de clave (```keystore```) y agregar la configuración de firma:
   ```groovy
   android {
      signingConfigs {
         release {
              storeFile file("path/to/your.keystore")
              storePassword "your_keystore_password"
              keyAlias "your_key_alias"
              keyPassword "your_key_password"
          }
      }
      buildTypes {
          release {
              signingConfig signingConfigs.release
         }
      }
     }
   ```

## 🍏 Crear Build (IPA) para iOS

Para crear un archivo IPA para iOS, sigue estos pasos:

1. **Requisitos previos**:
   - Asegúrate de tener Xcode instalado en macOS.
   - Debes tener una cuenta de desarrollador de Apple y estar registrado en el Apple Developer Program.
2. **Generar Build para iOS**:
   Ejecuta el siguiente comando para generar un build para iOS:
    ```sh
   flutter build ios --release
   ```
   Esto compilará la aplicación en modo de liberación para iOS.

3. **Crear IPA**:
   Para crear un archivo IPA (que puedes instalar en un dispositivo o enviar a la App Store), abre el proyecto en Xcode:
   - Abre el archivo ```ios/Runner.xcworkspace```.
   - En Xcode, selecciona el dispositivo de destino (puede ser un dispositivo físico o un simulador).
   - Ve a ```Product > Archive``` para crear el archivo.
   - Una vez completado el archivado, se abrirá la ventana de Organizer. Desde allí, podrás exportar el archivo IPA.

4. **Firmar y configurar el perfil**:
   Para publicar la app en la App Store, asegúrate de tener un certificado de firma y un perfil de aprovisionamiento configurados en Xcode.


### 📄 Licencia
Este proyecto está bajo la licencia MIT. Siéntete libre de modificarlo y adaptarlo a tus necesidades.

### 💡 ¡Feliz coding con Flutter! 🚀
Este `README.md` es claro, modular y adaptable para cualquier proyecto que uses como base. Puedes modificarlo según las necesidades específicas de tu plantilla. 🚀
# Spec: Refactor a arquitectura de paquetes (core / platform / feature)

Estado: **BORRADOR, pendiente de aprobación**. Este documento define la estructura general. Cada módulo tendrá luego su propio `SPEC-<id>.md`.

## Objective

Llevar `flutter_starter_kit` a la arquitectura de monorepo usada en commodo-mobile-app: el código se reparte en paquetes dentro de `packages/` (`core_*`, `platform_*`, `feature_*`) y el app principal (`lib/`) solo compone.

- **Usuario:** quien clone el starter para arrancar un proyecto nuevo.
- **Alcance:** solo estructura. Se mantiene el stack actual (flutter_bloc, get_it, formz, go_router, dio). No se migra a Riverpod ni fpdart.
- **Éxito:** el app se comporta igual que hoy, pero cada capacidad vive en su paquete con dependencias en un solo sentido.

### Regla de dependencia

```
app (lib/)  →  feature_*  →  platform_*  →  core_*
```

- Una feature nunca importa otra feature. Lo compartido sube a `platform_*`.
- Un `core_*` puede depender de otro `core_*` mientras no haya ciclos.
- No hay event bus.
- La presentación de una feature no importa su `data/`; solo `domain/`.

## Capability Map

| Módulo | Responsabilidad | Origen en `lib/` | Depende de |
|---|---|---|---|
| `core-storage` | Servicios key-value y secure storage | `ui/shared/service/*storage*` | — |
| `core-network` | `ApiClient`, interceptors, excepciones HTTP | `api/` | core-storage |
| `core-ui` | Definición de tema, responsive, spacing, widgets compartidos, inputs formz | `config/theme`, `ui/widgets`, `ui/shared/inputs`, `ui/shared/styles` | — |
| `platform-theme` | `ThemeModeCubit` (hydrated) | `ui/cubits/theme_mode_cubit` | core-ui |
| `platform-media` | Servicio de cámara y galería | `camera_gallery_service*` | — |
| `platform-session` | `AuthBloc`, `User`, repositorio, use case, datasource de auth | `domain/`, `data/`, `ui/blocs/auth` | core-network, core-storage |
| `feature-auth` | Pantallas login/registro y cubits de formulario | `ui/screens/auth`, `ui/views/auth`, `login_form_cubit`, `register_form_cubit` | platform-session, core-ui |
| `feature-onboarding` | Introducción y su cubit | `onboarding_screen`, `introduction_cubit` | core-storage, core-ui |
| `feature-home` | Home, layouts adaptativos, drawer | `ui/screens/home` | platform-session, core-ui |
| `feature-settings` | Pantalla de ajustes | `ui/screens/settings` | platform-theme, core-ui |
| `feature-showcase` | Pantallas demo de widgets, inputs y estilos | `widgets_screen`, `ui/views/*_view` | core-ui, platform-media |
| `app` | DI (`get_it`), router, l10n propio, flavors, `main` | `app/`, `config/router`, `config/l10n`, `flavors/` | todos |

**Orden de construcción:** `core-storage` → `core-network`, `core-ui` → `platform-theme`, `platform-media`, `platform-session` → las 5 features (paralelizables) → `app`.

Los ids van con guion; los paquetes Dart usan guion bajo (`core_storage`, `feature_auth`).

### Decisiones tomadas con valor por defecto (confirmar)

1. La sesión (`AuthBloc` y la lógica de auth) vive en `platform_session`, porque home y el router la leen. `feature_auth` queda con UI y formularios.
2. El router se queda en el app, porque depende de `AuthBloc` e `IntroductionCubit`.
3. `feature_showcase` es una feature aparte.

## Tech Stack

- Dart `^3.6.0`, Flutter (versión según `pubspec.lock` actual).
- Estado: `flutter_bloc`, `hydrated_bloc`. DI: `get_it`. Navegación: `go_router`. HTTP: `dio`. Formularios: `formz`.
- Monorepo: workspace de pub (Dart ≥ 3.6) y `melos` para scripts.

## Commands

```
Bootstrap:     dart pub get                      (en la raíz, resuelve el workspace)
Analizar todo: melos run analyze                 (flutter analyze en cada paquete)
Tests todos:   melos run test                    (flutter test en cada paquete)
Tests un pkg:  cd packages/feature_auth && flutter test
Generar l10n:  melos run gen-l10n                (flutter gen-l10n en paquetes con l10n.yaml)
Correr app:    flutter run --flavor dev -t lib/flavors/main_dev.dart
```

Los scripts de melos se definen en el `pubspec.yaml` raíz durante el módulo `app`.

## Project Structure

```
lib/                          App: composición únicamente
  app/                        app.dart, dependency_injection.dart
  config/router/              GoRouter y redirect
  config/l10n/                .arb propios del app
  flavors/, main.dart
packages/
  core_storage/  core_network/  core_ui/
  platform_theme/  platform_media/  platform_session/
  feature_auth/  feature_onboarding/  feature_home/
  feature_settings/  feature_showcase/
test/                         Solo tests de integración del app
integration_test/             Flujos de extremo a extremo
```

Estructura interna de cada paquete:

```
packages/feature_auth/
  pubspec.yaml
  l10n.yaml                    (si tiene textos)
  lib/
    feature_auth.dart          Barrel: única API pública
    src/
      presentation/            screens, widgets, blocs/cubits
      l10n/arb/, l10n/generated/
  test/
```

Solo se importa lo exportado en el barrel. Nada fuera del paquete importa `src/`.

## Code Style

Se mantiene el estilo actual del repo (`flutter_lints`, `analysis_options.yaml`). Cada paquete hereda el mismo `analysis_options.yaml`. Ejemplo de barrel:

```dart
// packages/platform_session/lib/platform_session.dart
export 'src/domain/entities/user.dart';
export 'src/domain/repositories/auth_repository.dart';
export 'src/presentation/auth_bloc.dart';
```

## Internacionalización (decisión: un `.arb` por paquete)

- Cada paquete con textos tiene su `l10n.yaml`, sus `.arb` y una clase generada con nombre único (`AuthLocalizations`, `SettingsLocalizations`...), con `synthetic-package: false`.
- Cada paquete define sus propios idiomas. El `MaterialApp` declara la **unión** de todos.
- El helper de cada paquete usa idioma de respaldo en lugar de `!`:

```dart
extension AuthL10nX on BuildContext {
  AuthLocalizations get authL10n =>
      AuthLocalizations.of(this) ?? lookupAuthLocalizations(const Locale('en'));
}
```

- Los paquetes `core_*` no llevan textos de negocio; sus widgets reciben el texto por parámetro (p. ej. `custom_button`).
- Un test del app falla si la unión de `supportedLocales` no cubre los idiomas de algún paquete.
- Textos repetidos se duplican; solo se suben a un paquete común si pasan de unas pocas claves.

## Testing Strategy

- Framework: `flutter_test`, `bloc_test`, `mocktail` (los actuales).
- Cada test se mueve al paquete dueño del código:
  - `test/auth` → `platform_session`
  - `test/inputs` → `core_ui`
  - `test/register`, `test/sign_in` → `feature_auth`
- `integration_test/` y los tests de composición se quedan en el app.
- Regla: los tests existentes pasan sin cambios de lógica; solo cambian imports.
- Cada paquete debe poder correr `flutter test` por separado.

## Boundaries

- **Siempre:** correr `melos run analyze` y `melos run test` antes de cada commit; un commit por módulo movido; mover con `git mv` para conservar el historial.
- **Preguntar antes:** agregar dependencias nuevas; cambiar versiones en `pubspec.yaml`; crear un paquete fuera del mapa; tocar la CI.
- **Nunca:** que una feature importe otra; cambiar el comportamiento de la lógica durante el movimiento; migrar de stack en este refactor; tocar las demás ramas de origin; borrar tests que fallen sin aprobación.

## Plan de ramas

- El trabajo va en una rama nueva (`refactor/packages-architecture`) creada desde `master`.
- Las ramas `firebase-implementation`, `google-sign-in-implementation`, `push-notifications-implementation`, `auto-update-version-app-implementation` y `example-implementation-api-datasource` no se tocan.
- Cómo rebasarlas después sobre la nueva estructura queda como decisión posterior.

## Success Criteria

- [ ] `packages/` contiene los 10 paquetes del mapa; `lib/` solo tiene composición.
- [ ] `grep` no encuentra ningún import `feature_x` dentro de `feature_y`, ni imports hacia arriba en la regla de dependencia.
- [ ] `melos run analyze` sin errores ni warnings nuevos.
- [ ] Todos los tests actuales pasan, ubicados en su paquete dueño.
- [ ] El app compila y corre en los 3 flavors, con el mismo flujo: onboarding → login → home → settings.
- [ ] Cada paquete corre `flutter test` por separado.
- [ ] El test de unión de idiomas pasa.
- [ ] README (`README.md` y `README.es.md`) documenta la estructura y la regla de dependencia.

## Open Questions

1. Los tres valores por defecto de "Decisiones tomadas" (sesión, router, showcase).
2. ¿`custom_button` y otros widgets compartidos usan strings de `AppLocalizations`? Hay que revisarlo en el spec de `core-ui`.
3. ¿Se quiere un tema (`core_ui`) con tokens por separado, o basta con mover lo actual?
4. ¿Qué hacer con `BRANCHES.md` cuando se rebasen las ramas?

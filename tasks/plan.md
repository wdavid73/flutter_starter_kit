# Implementation Plan: Refactor a arquitectura de paquetes

Spec: [`SPEC.md`](../SPEC.md). Checklist de seguimiento: [`tasks/todo.md`](todo.md). Rama de trabajo: `refactor/packages-architecture` (desde `master`).

## Overview

Un solo plan para todo el refactor: pasar `flutter_starter_kit` de un app monolítico en `lib/` a un monorepo con 10 paquetes (`core_*`, `platform_*`, `feature_*`) más un app que solo compone. Se mantiene el stack (flutter_bloc, get_it, formz, go_router, dio). La lógica no cambia: solo se mueve, se encapsula tras un barrel por paquete y se aísla su l10n.

## Estrategia de ejecución

- **Mover, no reescribir.** Cada tarea usa `git mv` para conservar historial y corrige imports.
- **Una tarea = un paquete (o parte de uno) = un commit.** Al terminar cada tarea el app compila, analiza limpio y los tests pasan. Nunca hay un estado intermedio roto.
- **De abajo hacia arriba:** `core` → `platform` → `feature` → `app`. Un paquete solo se crea cuando ya existen sus dependencias.
- **El app consume cada paquete desde el momento en que se crea.** `lib/` va quedando más delgado tarea a tarea, hasta quedarse solo con composición.
- **Los tests se mueven con su código.** Solo cambian imports.

## Grafo de dependencias

```
core_storage ─┬─> core_network ─┐
              │                 ├─> platform_session ─┬─> feature_auth
core_ui ──────┼─> platform_theme ──> feature_settings │─> feature_home
              │                                       │
              ├─> feature_onboarding                  │
platform_media ──────────────────> feature_showcase <─ core_ui
                                         │
                                         v
                                 app (lib/): DI, router, l10n, flavors
```

## Decisiones de arquitectura

1. **Sesión en `platform_session`.** `AuthBloc`, el dominio y la data de auth viven ahí porque el router y el drawer de home leen su estado. `feature_auth` queda con UI y cubits de formulario.
2. **`Environment` y el router se quedan en el app.** `core_network` recibe `baseUrl` por parámetro del constructor en vez de leer `Environment`.
3. **Assets en el paquete que los usa**, referenciados como `packages/<pkg>/assets/...`:
   - fuentes y loaders → `core_ui`
   - SVG de introducción → `feature_onboarding`
   - fondo de login e ícono de Google → `feature_auth`
4. **l10n: un `.arb` por paquete con textos**, clase generada con nombre único, helper con idioma de respaldo en inglés (ver SPEC).
5. **`core_ui` conserva sus propios mensajes genéricos** (validaciones como `is_required`, `is_email`, y `loading`). No son texto de negocio y los usan todos los formularios. Se generan como `CoreUiLocalizations`.
6. **Los errores de red y auth** (`connection_time_out`, `invalid-credential`...) se traducen donde se muestran. El mapeo clave → texto (hoy `getByKey`) se divide: lo genérico a `core_ui`, lo de auth a `feature_auth`/`platform_session`.
7. **La regla de dependencia se hace cumplir por `pubspec.yaml`:** un paquete no puede importar lo que no declara. Un script de verificación (T1) comprueba que los `pubspec` respetan el grafo.

## Task List

### Fase 0: Preparación

#### T0 — Rama, toolchain y línea base
**Descripción:** Crear la rama, dejar `flutter` utilizable en la terminal y registrar el estado de `master` antes de tocar nada.
**Aceptación:**
- [ ] Rama `refactor/packages-architecture` creada desde `master`.
- [ ] `flutter --version` funciona; versión ≥ 3.27 (necesaria para workspaces de pub).
- [ ] Línea base registrada: resultado de `flutter analyze` y `flutter test`.
**Verificación:** `flutter analyze` y `flutter test` en la rama, antes de cambiar código.
**Dependencias:** ninguna. **Alcance:** XS.
**Nota:** `flutter` no está en el PATH de la terminal en esta sesión; hay que resolverlo (PATH o FVM) antes de poder verificar cualquier tarea.

#### T1 — Esqueleto del monorepo
**Descripción:** Convertir la raíz en workspace de pub, agregar melos, el `analysis_options.yaml` compartido y el script que verifica el grafo de dependencias.
**Aceptación:**
- [ ] `pubspec.yaml` raíz declara `workspace:` (aún vacío) y `melos` con scripts `analyze`, `test`, `gen-l10n`, `check-deps`.
- [ ] `tool/check_deps.dart` falla si un paquete declara una dependencia que el grafo no permite.
- [ ] `flutter pub get` en la raíz sigue funcionando; el app corre igual.
**Verificación:** `dart pub get`, `melos run check-deps`, `flutter analyze`.
**Archivos:** `pubspec.yaml`, `analysis_options.yaml`, `tool/check_deps.dart`.
**Dependencias:** T0. **Alcance:** M.

### Fase 1: Paquetes core

#### T2 — `core_storage`
**Descripción:** Extraer `KeyValueStorageService` y `SecureStorageService` con sus implementaciones.
**Aceptación:**
- [ ] `packages/core_storage` exporta ambos servicios desde un barrel.
- [ ] `lib/ui/shared/service/` ya no contiene los servicios de storage.
- [ ] El app compila e importa desde `package:core_storage`.
**Verificación:** `flutter analyze`, `flutter test`, `melos run check-deps`.
**Archivos:** `ui/shared/service/*storage*` (4), `dependency_injection.dart`, importadores.
**Dependencias:** T1. **Alcance:** M.

#### T3 — `core_network`
**Descripción:** Extraer `api/` (cliente, interceptors, excepciones, response, serializers). `ApiClient` recibe `baseUrl` por parámetro.
**Aceptación:**
- [ ] `core_network` depende solo de `core_storage` (por el token interceptor).
- [ ] No importa `Environment`; el app le pasa `Environment.apiUrl`.
- [ ] `lib/api/` eliminado.
**Verificación:** `flutter analyze`, `flutter test`, `melos run check-deps`; login manual contra la API (o mock) sigue igual.
**Archivos:** `lib/api/*` (9), `dependency_injection.dart`.
**Dependencias:** T2. **Alcance:** M (mover 9 archivos, editar 2-3).

#### T4 — `core_ui` (1/3): tema, tipografía y assets base
**Descripción:** Mover `config/theme` completo (light/dark, extensiones, responsive), `app_spacing`, las fuentes Montserrat y el loader.
**Aceptación:**
- [ ] `core_ui` declara fuentes y `assets/loaders` en su `pubspec`; el app ya no los declara.
- [ ] Las fuentes siguen cargando (referencia `packages/core_ui/...` donde corresponda).
- [ ] `lib/config/theme/` eliminado.
**Verificación:** `flutter analyze`, `flutter test`; revisión visual del tema claro/oscuro.
**Dependencias:** T1. **Alcance:** M.
**Riesgo:** rutas de fuentes y `google_fonts`.

#### T5 — `core_ui` (2/3): inputs formz y mensajes genéricos
**Descripción:** Mover `ui/shared/inputs` y crear `CoreUiLocalizations` con las validaciones genéricas (`is_required`, `is_email`, `is_password_length`...). Mover `test/inputs`.
**Aceptación:**
- [ ] Los 13 inputs viven en `core_ui` y se exportan.
- [ ] `core_ui` tiene `l10n.yaml`, `.arb` en/es y helper con respaldo.
- [ ] `test/inputs` pasa desde `core_ui`.
**Verificación:** `cd packages/core_ui && flutter test`; `melos run gen-l10n`.
**Dependencias:** T4. **Alcance:** M.

#### T6 — `core_ui` (3/3): widgets compartidos
**Descripción:** Mover `ui/widgets` (custom_*, adaptive_scaffold, shimmer, svg_picture_custom...). `custom_button` deja de usar el `l10n` del app y usa `CoreUiLocalizations.loading`.
**Aceptación:**
- [ ] Ningún widget de `core_ui` importa el app ni `AppLocalizations`.
- [ ] `lib/ui/widgets/` eliminado.
- [ ] `getByKey` de validación usa `CoreUiLocalizations`.
**Verificación:** `flutter analyze`, `flutter test`, `melos run check-deps`.
**Dependencias:** T5. **Alcance:** M (mover ~14, editar 3-4).

#### Checkpoint A — core completo
- [ ] `melos run analyze`, `melos run test`, `melos run check-deps` verdes.
- [ ] El app corre y se ve igual (tema, fuentes, formularios).
- [ ] Revisión con el usuario antes de pasar a `platform`.

### Fase 2: Paquetes platform

#### T7 — `platform_theme`
**Descripción:** Mover `ThemeModeCubit` (hydrated) con su estado.
**Aceptación:** paquete depende de `core_ui`; el app y settings lo usan desde el barrel.
**Verificación:** `flutter analyze`, `flutter test`; cambiar tema en ejecución persiste tras reinicio.
**Dependencias:** T4. **Alcance:** S.

#### T8 — `platform_media`
**Descripción:** Mover `CameraGalleryService` y su implementación.
**Aceptación:** paquete sin dependencias internas; el app lo registra en DI si hace falta.
**Verificación:** `flutter analyze`, `flutter test`.
**Dependencias:** T1. **Alcance:** S.

#### T9 — `platform_session` (1/2): dominio y data de auth
**Descripción:** Mover `domain/` (entities, repositories, usecases, datasources) y `data/` (models, mappers, datasource, repo impl) a `platform_session`.
**Aceptación:**
- [ ] Depende solo de `core_network` y `core_storage`.
- [ ] `lib/domain/` y `lib/data/` eliminados.
- [ ] Registro en DI actualizado.
**Verificación:** `flutter analyze`, `flutter test`.
**Dependencias:** T3. **Alcance:** M (mover ~14, editar 2).

#### T10 — `platform_session` (2/2): `AuthBloc`
**Descripción:** Mover `AuthBloc`, su evento/estado/handler y `test/auth` con sus mocks. Pasar la traducción de errores de auth a su lugar definitivo.
**Aceptación:**
- [ ] `AuthBloc` exportado por el barrel de `platform_session`.
- [ ] `test/auth` pasa desde `platform_session`.
- [ ] El router, el drawer y los cubits usan `package:platform_session`.
**Verificación:** `cd packages/platform_session && flutter test`; `flutter analyze`.
**Dependencias:** T9. **Alcance:** M.

#### Checkpoint B — platform completo
- [ ] `melos run analyze`, `test`, `check-deps` verdes.
- [ ] Login, logout y cambio de tema funcionan.
- [ ] Revisión con el usuario.

### Fase 3: Paquetes feature (independientes entre sí)

#### T11 — `feature_onboarding`
**Descripción:** Mover `onboarding_screen`, `IntroductionCubit` y los SVG de introducción. Crear su `.arb`.
**Aceptación:** depende de `core_storage` y `core_ui`; assets referenciados como `packages/feature_onboarding/...`; sin textos en el `.arb` del app.
**Verificación:** `flutter analyze`, `flutter test`; el onboarding se ve y se completa.
**Dependencias:** T6. **Alcance:** M.

#### T12 — `feature_settings`
**Descripción:** Mover `settings_screen` y crear su `.arb`.
**Aceptación:** depende de `platform_theme` y `core_ui`.
**Verificación:** `flutter analyze`; cambiar tema desde settings funciona.
**Dependencias:** T7, T6. **Alcance:** S.

#### T13 — `feature_home`
**Descripción:** Mover `home_screen`, layouts medium/expanded, `drawer_home` y su `.arb`.
**Aceptación:** depende de `platform_session` y `core_ui`; no importa `feature_auth`.
**Verificación:** `flutter analyze`; home y drawer se ven en móvil y tablet.
**Dependencias:** T10, T6. **Alcance:** M.

#### T14 — `feature_auth` (1/2): cubits y tests
**Descripción:** Mover `SignInFormCubit`, `RegisterFormCubit` y los tests `test/sign_in` y `test/register` con sus mocks.
**Aceptación:** tests pasan desde `feature_auth`; depende de `platform_session` y `core_ui`.
**Verificación:** `cd packages/feature_auth && flutter test`.
**Dependencias:** T10, T5. **Alcance:** M.

#### T15 — `feature_auth` (2/2): pantallas, vistas, assets y l10n
**Descripción:** Mover `screens/auth`, `views/auth`, el fondo de login, el ícono de Google y crear su `.arb`.
**Aceptación:** assets referenciados por `packages/feature_auth/...`; flujo de login/registro igual que antes.
**Verificación:** `flutter analyze`; login y registro manuales.
**Dependencias:** T14. **Alcance:** M.

#### T16 — `feature_showcase`
**Descripción:** Mover las vistas demo (`widgets_screen`, `buttons_view`, `inputs_view`, `drawer_view`, `bottom_sheet_view`, `selectable_widget_view`, `text_styles_view`).
**Aceptación:** depende de `core_ui` y `platform_media`; ningún otro paquete lo importa.
**Verificación:** `flutter analyze`; las pantallas demo abren.
**Dependencias:** T6, T8. **Alcance:** M.

#### Checkpoint C — features completas
- [ ] `melos run analyze`, `test`, `check-deps` verdes.
- [ ] `lib/ui/` vacío o eliminado.
- [ ] Revisión con el usuario.

### Fase 4: App y cierre

#### T17 — App delgado
**Descripción:** Dejar `lib/` solo con `app/`, `config/router`, `config/l10n`, `config/startup`, `config/constants`, `flavors/`, `main.dart`. Ordenar DI por capas y actualizar el router.
**Aceptación:**
- [ ] `lib/` solo contiene composición.
- [ ] El router y la DI importan solo barrels de paquetes.
- [ ] `localizationsDelegates` incluye el delegate de cada paquete con textos.
**Verificación:** `flutter analyze`; app corre en los 3 flavors.
**Dependencias:** T11–T16. **Alcance:** M.

#### T18 — Idiomas: unión y verificación
**Descripción:** Calcular `supportedLocales` como unión de los paquetes y agregar el test que falla si falta alguno.
**Aceptación:** test del app comprueba que todo idioma de un paquete está en `supportedLocales`; script `gen-l10n` corre en todos los paquetes.
**Verificación:** `melos run gen-l10n`, `flutter test`.
**Dependencias:** T17. **Alcance:** S.

#### T19 — Documentación
**Descripción:** Actualizar `README.md`, `README.es.md` y la sección de `BRANCHES.md` que lo requiera con la estructura, la regla de dependencia y cómo crear un paquete nuevo.
**Aceptación:** ambos README describen la arquitectura y los comandos de melos.
**Verificación:** revisión manual de los enlaces y comandos.
**Dependencias:** T17. **Alcance:** S.

#### T20 — Verificación final
**Descripción:** Pasada completa sobre todos los criterios de éxito del SPEC.
**Aceptación:** todos los puntos de "Success Criteria" del SPEC marcados.
**Verificación:**
- `melos run analyze && melos run test && melos run check-deps`
- `flutter test integration_test`
- Build de los 3 flavors (dev, staging, prod)
- Flujo manual: onboarding → login → home → settings → logout
**Dependencias:** T18, T19. **Alcance:** S.

#### Checkpoint final
- [ ] Todos los criterios del SPEC cumplidos.
- [ ] Listo para revisión y PR.

## Paralelización

- **Secuencial obligatorio:** T0 → T1 → T2 → T3; T4 → T5 → T6; T9 → T10.
- **Paralelizables:** T2 con T4 (core_storage y core_ui no dependen entre sí); T7 con T8; T11, T12, T13 y T16 (tras Checkpoint B). Dos sesiones no deberían tocar `dependency_injection.dart` a la vez: coordinar o hacer esas ediciones al final de cada tarea.

## Riesgos y mitigaciones

| Riesgo | Impacto | Mitigación |
|---|---|---|
| `flutter` no está en el PATH de esta terminal | Alto | Resolverlo en T0; sin eso no se puede verificar ninguna tarea |
| Workspaces de pub exigen Flutter ≥ 3.27 (el `pubspec.lock` pide solo ≥ 3.24) | Medio | Verificar versión en T0; si es menor, usar `path:` dependencies con melos sin workspace |
| Rutas de assets y fuentes rotas al moverlas a paquetes | Alto | Moverlos en la tarea de su paquete y probar visualmente; `packages/<pkg>/...` |
| Ciclo entre `core_network` y `core_storage` por el token interceptor | Medio | Dirección única `network → storage`; `check-deps` lo vigila |
| `getByKey` mezcla textos de validación, red y auth | Medio | Dividir en T5/T6/T10 según dónde se muestra cada mensaje |
| Generación de l10n en N paquetes (delegates faltantes en `MaterialApp`) | Medio | T17 y el test de T18 |
| Los mocks de tests importan rutas internas del app | Bajo | Se corrigen al mover cada test |
| Las ramas de origin quedarán desfasadas respecto a la nueva estructura | Medio | Fuera de alcance; decisión posterior |

## Open Questions

1. ¿Confirmas los 3 valores por defecto del SPEC (sesión en `platform_session`, router en el app, `feature_showcase` aparte)?
2. ¿Qué versión de Flutter usa este proyecto (FVM, instalación global)? Define si se usa workspace de pub o solo `path:` + melos.
3. ¿La rama de trabajo se publica en origin desde el inicio, o se mantiene local hasta el Checkpoint A?

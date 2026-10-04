# Todo: Refactor a arquitectura de paquetes

Detalle de cada tarea (aceptación, verificación, archivos, riesgos): [`plan.md`](plan.md).

## Fase 0: Preparación
- [ ] T0 — Rama `refactor/packages-architecture`, toolchain de Flutter y línea base
- [ ] T1 — Esqueleto del monorepo (workspace, melos, check-deps)

## Fase 1: Paquetes core
- [ ] T2 — `core_storage`
- [ ] T3 — `core_network`
- [ ] T4 — `core_ui` (1/3): tema, tipografía y assets base
- [ ] T5 — `core_ui` (2/3): inputs formz y mensajes genéricos
- [ ] T6 — `core_ui` (3/3): widgets compartidos
- [ ] **Checkpoint A** — core completo

## Fase 2: Paquetes platform
- [ ] T7 — `platform_theme`
- [ ] T8 — `platform_media`
- [ ] T9 — `platform_session` (1/2): dominio y data de auth
- [ ] T10 — `platform_session` (2/2): `AuthBloc` y tests
- [ ] **Checkpoint B** — platform completo

## Fase 3: Paquetes feature
- [ ] T11 — `feature_onboarding`
- [ ] T12 — `feature_settings`
- [ ] T13 — `feature_home`
- [ ] T14 — `feature_auth` (1/2): cubits y tests
- [ ] T15 — `feature_auth` (2/2): pantallas, vistas, assets y l10n
- [ ] T16 — `feature_showcase`
- [ ] **Checkpoint C** — features completas

## Fase 4: App y cierre
- [ ] T17 — App delgado (DI, router, delegates)
- [ ] T18 — Idiomas: unión de `supportedLocales` y test
- [ ] T19 — Documentación (READMEs, BRANCHES.md)
- [ ] T20 — Verificación final
- [ ] **Checkpoint final**

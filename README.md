# Pokédex - Flutter Technical Test

Una aplicación móvil y web de Pokédex construida con **Flutter**, **BLoC**, **Clean Architecture** y estrategia de caché con **Hive** para persistencia.

## Quick Start

### Requisitos Previos

- Flutter SDK `>=3.4.1 <4.0.0`
- Android SDK (para Android) / Xcode (para iOS)
- Chrome (para Web)

### Instalación de Dependencias

```bash
cd draftea_pokedex
flutter pub get
```

### IMPORTANTE: Configuración de Variables de Entorno

**La aplicación REQUIERE variables de entorno para funcionar correctamente en Android y Web.** Sin ellas, las peticiones a la API fallarán.

Estas variables deben pasarse en tiempo de ejecución con `--dart-define`:

---

## Ejecutar en Android

### Emulador

```bash
# Listar emuladores disponibles
flutter emulators

# Lanzar emulador específico
flutter emulators launch <emulator_id>

# Ejecutar la app con variables de entorno
flutter run \
  --dart-define=ENV=development \
  --dart-define=API_BASE_URL=https://pokeapi.co/api/v2 \
  --dart-define=IMAGE_BASE_URL=https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork \
  --dart-define=CONNECTION_TIMEOUT=15 \
  --dart-define=RECEIVE_TIMEOUT=15
```

### Dispositivo Físico

```bash
# Conectar dispositivo por USB y habilitar debug USB
flutter devices

# Ejecutar con variables de entorno
flutter run \
  -d <device_id> \
  --dart-define=ENV=development \
  --dart-define=API_BASE_URL=https://pokeapi.co/api/v2 \
  --dart-define=IMAGE_BASE_URL=https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork \
  --dart-define=CONNECTION_TIMEOUT=15 \
  --dart-define=RECEIVE_TIMEOUT=15
```

---

## Ejecutar en Web

### Web 

```bash
# IMPORTANTE: Pasar variables de entorno, sino la API no funcionará
flutter run -d chrome \
  --dart-define=ENV=development \
  --dart-define=API_BASE_URL=https://pokeapi.co/api/v2 \
  --dart-define=IMAGE_BASE_URL=https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork \
  --dart-define=CONNECTION_TIMEOUT=15 \
  --dart-define=RECEIVE_TIMEOUT=15
```

---

## Variables de Entorno

La app **REQUIERE** variables de entorno en tiempo de ejecución. Sin ellas, las peticiones a la API fallarán:

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `ENV` | Ambiente de ejecución | `development` |
| `API_BASE_URL` | URL base de la API Pokémon | `https://pokeapi.co/api/v2` |
| `IMAGE_BASE_URL` | URL base de imágenes oficiales | `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork` |
| `CONNECTION_TIMEOUT` | Timeout de conexión (segundos) | `15` |
| `RECEIVE_TIMEOUT` | Timeout de respuesta (segundos) | `15` |

**Importante**: Si ejecutas sin `--dart-define`, la app intentará usar la API pero fallará. Verás solo los datos guardados en caché local (si existen).

---

## Características Principales

✓ Listado paginado de Pokémon (20 items por página)
✓ Detalle de Pokémon (altura, peso, tipos, estadísticas de batalla)
✓ Caché local con Hive (funciona sin internet si ya cargó datos)
✓ Responsivo: adaptado para celular, tablet y desktop
✓ Arquitectura limpia: separación de responsabilidades
✓ Gestión de estado: BLoC + Cubit
✓ Navegación segura: GoRouter  

---

## Arquitectura

### Capas (Clean Architecture)

```
lib/
├── core/                    # Capa compartida (config, network, storage, UI)
│   ├── config/
│   │   └── app_config.dart        # Configuración global
│   ├── network/
│   │   └── dio_client.dart        # HTTP client con Dio
│   ├── storage/
│   │   └── hive_client.dart       # Persistencia local
│   ├── observer/
│   │   └── bloc_observer.dart     # Observación de estados (BLoC)
│   ├── exceptions/
│   │   └── exceptions.dart        # Custom exceptions
│   └── ui/
│       ├── ui_constants.dart      # Colores, tipografía, spacing
│       ├── breakpoints.dart       # Responsive breakpoints
│       └── media_query_ext.dart   # Extensiones de MediaQuery
│
├── feature/
│   └── pokemon/
│       ├── domain/                 # Entidades y contratos
│       │   ├── pokemon.dart        # Entidad Pokemon
│       │   └── pokemon_repository.dart  # Abstract repository
│       │
│       ├── data/                   # Implementación de repositorio y datasources
│       │   ├── pokemon_api.dart    # Remote datasource (PokeAPI)
│       │   ├── pokemon_local.dart  # Local datasource (Hive)
│       │   ├── pokemon_repository_impl.dart  # Implementación del repo
│       │   └── dto/                # Data Transfer Objects
│       │       ├── pokemon_list_item_dto.dart
│       │       └── pokemon_detail_dto.dart
│       │
│       └── presentation/           # UI Layer
│           ├── cubit/              # State management
│           │   ├── pokemon_list_cubit.dart
│           │   ├── pokemon_list_states.dart
│           │   ├── pokemon_detail_cubit.dart
│           │   └── pokemon_detail_state.dart
│           ├── pages/              # Pantallas
│           │   ├── pokemon_list_page.dart
│           │   └── pokemon_detail_page.dart
│           └── widgets/            # Componentes reutilizables
│               ├── pokemon_card.dart
│               ├── pokemon_header_section.dart
│               ├── pokemon_image_section.dart
│               ├── stats_section.dart
│               └── stat_bar.dart
│
└── app/
    ├── app_dependencies.dart       # Service locator / DI setup
    ├── draftea_pokedex.dart        # Punto de entrada (MaterialApp)
    └── router.dart                 # Configuración de rutas
```

### Patrón: Clean Architecture + BLoC

```
UI (Pages/Widgets)
     ↓
BLoC/Cubit (State Management)
     ↓
Repository (Data Access Abstraction)
     ↓
Datasources (API Remote + Hive Local)
```

**Separación de responsabilidades:**
- **Domain**: Lógica de negocio pura, sin dependencias externas
- **Data**: Cómo obtener datos (API, cache, DB)
- **Presentation**: Cómo mostrar datos (UI, state management)

Esto permite:
- Testing sin UI
- Cambiar datasources sin afectar dominio
- Reutilizar lógica en múltiples plataformas

---

## Respuestas Técnicas

### 1. Arquitectura y Escalabilidad

**¿Qué usé y por qué?**

**Clean Architecture + BLoC**:
- **Separación clara** entre capas (Domain, Data, Presentation)
- **Independencia** de frameworks: puedo cambiar Dio por Http sin tocar domain
- **Testeable**: Repository y Cubit se testean sin UI
- **Escalable**: Agregar nuevas features sigue el mismo patrón

**Por qué es adecuado para escalar a producto real (incluyendo Web)**:
- La misma **capa domain** funciona en mobile, web, desktop
- **DTOs** manejan serialización/deserialización, aislando cambios API
- **Cubit** abstrae lógica de estado, independiente de UI framework
- **Repository pattern** permite agregar cachés multinivel sin cambiar UI

**Ejemplo**: Si mañana necesito agregar búsqueda global:
1. Agregar method en `PokemonRepository` (domain)
2. Implementar en `PokemonRepositoryImpl` con lógica de cache/API
3. Crear nuevo `PokemonSearchCubit` (Presentation)
4. Reutilizar mismos DTOs y modelos

Sin tocar: UI anterior, validaciones, offline logic.

---

### 2. Trade-offs por Timebox (1 día)

| Decisión | Por qué | Impacto |
|----------|---------|--------|
| **Sin testing unitario** | Priorizar MVP funcional | Riesgo: refactors sin cobertura; Mitiga: código limpio, patterns claros |
| **UI simplificada** | Responsive básico, no animaciones | Web/mobile funcionan; Sin pulir detalles visuales |
| **Sin búsqueda/filtros** | Scope control | MVP satisface requerimiento (listar + detalle) |
| **Sin i18n (internacionalización)** | Texto hardcodeado en inglés | Fácil agregar después y el core no lo bloquea |
| **Sin tema oscuro** | Enfoque en estructura > UI | Light theme es suficiente para el scope |
| **Error handling básico** | Try/catch genérico | Fallos silenciosos fallback a cache, el usuario ve mensaje simple |

**Mi idea**: Priorizando la developer experience y la arquitectura, un dev puede seguir este proyecto sin problemas.

---

### 3. Gestión de Estado y Side-Effects

**Flujo: UI → Estado → Datos**

```dart
// 1. UI dispara evento (usuario scrollea hasta que se carga más)
context.read<PokemonListCubit>().loadMore();

// 2. Cubit maneja side-effects (request API)
Future<void> _fetchNextPage() async {
  _isLoading = true;
  try {
    final result = await repository.getPokemonList(...); // Side-effect
    _items.addAll(result);
    emit(PokemonListLoaded(items: _items));  // Nuevo estado
  } catch (_) {
    emit(const PokemonListError('Failed...'));  // Estado error
  }
}

// 3. BlocBuilder reacciona a cambios de estado
BlocBuilder<PokemonListCubit, PokemonListState>(
  builder: (_, state) {
    if (state is PokemonListLoaded) return ListView(...);
    if (state is PokemonListError) return ErrorWidget(...);
  }
)
```

**¿Cómo evito acoplamiento entre capas?**

| Acoplamiento Evitado | Solución |
|----------------------|----------|
| **UI acoplada a API** | Repository abstrae datasource (API o cache) |
| **UI acoplada a Hive** | PokemonLocal es una dependencia inyectada |
| **Cubit acoplado a DTOs** | Repository convierte DTO → Domain Entity |
| **Domain acoplado a Dio** | Datasources usan clientes abstractos |

Ejemplo (`pokemon_repository_impl.dart`):
```dart
// UI no ve esto, Cubit tampoco. Solo ve Pokemon (domain entity)
final dto = await api.fetchDetail(id);  // Remote datasource
final pokemon = Pokemon(
  id: dto.id,
  name: dto.name,
  // ... mapping
);
await local.saveDetail(pokemon);  // Guarda la data Local cache para offline
```

Si cambio PokeAPI por otra fuente:
- `pokemon_api.dart` cambia
- `PokemonListCubit` no cambia
- `pokemon_list_page.dart` no cambia

---

### 4. Offline y Caché

**Estrategia: Online-first con fallback offline**

La app prioriza datos frescos de la API. Si algo falla, usa caché como respaldo:

```
Flujo normal (con internet):
  1. Request a API → 2. Guardo en Hive → 3. Muestro datos → Usuario ve datos actualizados

Flujo sin internet:
  1. Request falla → 2. Cargo de Hive → 3. Muestro caché → Usuario ve datos guardados
```

**¿Qué guardo y cómo?**

```dart
// pokemon_local.dart
Future<void> saveList(List<Pokemon> list) async {
  await box.put('list', list.map((e) => {
    'id': e.id,
    'name': e.name,
    'imageUrl': e.imageUrl,
    'height': e.height,
    'weight': e.weight,
    'stats': e.stats,
    'types': e.types,
  }).toList());
}

// Guardado automático después de fetch exitoso
```

**¿Cómo manejo versionado/invalidación?**

Actual (estrategia simple):
- Listado: se guarda cada vez que carga exitosamente
- Detalle: se guarda cada vez que se ve
- Tiempo de vida: indefinido (se renueva al cargar nuevo)

Recomendación futura:
```dart
struct CacheMetadata {
  final DateTime timestamp;
  final String dataVersion;
}

// Invalidar si > 24 horas
if (DateTime.now().difference(metadata.timestamp) > Duration(hours: 24)) {
  await box.delete('list');  // Forzar actualización
}
```

**¿Cómo resuelvo conflictos caché vs datos remotos?**

En `getPokemonList()`:
1. **Con internet**: API siempre gana → se guarda en Hive
2. **Sin internet**: Hive es la fuente de verdad
3. **Conflictos**: No existen porque el flujo es secuencial (primero intento API, luego caché)

```dart
@override
Future<List<Pokemon>> getPokemonList({required int limit, required int offset}) async {
  try {
    final list = await api.fetchList(...);  // Try remote
    await local.saveList(list);  // Update cache
    return list;  // Return fresh
  } catch (_) {
    return local.loadList();  // Fall back to cache
  }
}
```

---

### 5. Flutter Web: Decisiones y Limitaciones

**¿Qué hice para que sea buena la experiencia?**

| Decisión | Implementación |
|----------|---|
| **Responsive Layout** | `context.isTabletUp` (breakpoint 600dp) + `ConstrainedBox` |
| **Navegación Web-first** | GoRouter (URL-based routing, browser back/forward funciona) |
| **Performance** | Image caching nativo de Flutter, lazy loading (pagination) |
| **Interacción Desktop** | Hover states en Cards, navigation breadcrumb-ready |

**Código responsive** (`pokemon_list_page.dart`):
```dart
final isWide = context.isTabletUp;
// En tablet/desktop: centrado en max 600dp
// En mobile: full width
return isWide
  ? Center(child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: ListView(...)
    ))
  : ListView(...);
```

**Limitaciones anticipadas y mitigación**:

| Limitación | Impacto | Solución para v2 |
|-----------|--------|---------|
| **Tamaño inicial web** | ~50MB bundle (Flutter) | `--split-per-abi` (Android), tree-shaking agresivo |
| **Scroll infinito mobile** | Scroll jankiness en listas largas | Virtual scrolling (flutter_virtual_scroll) |
| **Imágenes remotas** | Network waterfall | Cargar imágenes cachadas antes de render |

**Testing que haría para Web**:
- Responsive en breakpoints (600dp, 1200dp, 1920dp)
- GoRouter: `/` → `/pokemon/1` → back button funciona
- Pagination scroll trigger en desktop
- Zoom/scale en browser mantiene layout

---

### 6. Calidad: 3 Decisiones de Código Limpio

#### Decisión 1: Repository Pattern (Inyección de Control)

```dart
// ACOPLADO: Cubit conoce detalles de Dio + Hive
class BadCubit extends Cubit {
  final Dio dio;
  final Box hive;
  
  Future<void> load() async {
    try {
      final response = await dio.get('/pokemon');
      await hive.put('data', response.data);
    } catch (e) {
      // ...
    }
  }
}

// LIMPIO: Cubit solo ve abstracción
abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList({required int limit, required int offset});
}

class PokemonListCubit extends Cubit {
  final PokemonRepository repository;  // Abstracción, no implementación
  
  Future<void> loadMore() async {
    try {
      final result = await repository.getPokemonList(...);
      emit(PokemonListLoaded(items: result));
    } catch (_) {
      emit(PokemonListError(...));
    }
  }
}
```

**Por qué es limpio**:
- Cubit no sabe si datos vienen de API o caché
- Cambio datasource sin tocar Cubit
- Fácil testear Cubit con mock repository

#### Decisión 2: DTOs para Serialización

```dart
// FRÁGIL: Domain Pokemon acoplada a JSON
class Pokemon {
  final int id;
  final String name;
  
  Pokemon.fromJson(Map json) : 
    id = json['id'],
    name = json['name'];
    // Si API cambia estructura → rompe domain
}

// LIMPIO: DTO aísla cambios API
class PokemonDetailDto {
  final int id;
  final String name;
  
  factory PokemonDetailDto.fromMap(Map<String, dynamic> json) {
    // Parseo complejo aquí
    final types = (json['types'] as List)
      .map((t) => t['type']['name'] as String)
      .toList();
    return PokemonDetailDto(id: json['id'], name: json['name'], ...);
  }
}

// Domain entity limpia
class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  // Sin JSON, sin API details
}

// Conversión explícita en repository
final pokemon = Pokemon(
  id: dto.id,
  name: dto.name,
  types: dto.types,  // Ya parseado
);
```

**Por qué es limpio**:
- Domain no muta si API cambia estructura
- Parseo complejo centralizado (un lugar para cambiar)
- Validación de datos en DTO (fails fast en data layer)

#### Decisión 3: Sealed Classes para Type-Safe States

```dart
// PROPENSO A BUGS: String states
class PokemonListState {
  final String status;  // 'loading', 'loaded', 'error'?
  final List<Pokemon>? data;
  
  // 🤔 ¿Qué data es válida si status == 'error'?
}

// SEGURO: Sealed classes (Dart 3.0+)
sealed class PokemonListState {
  const PokemonListState();
}

class PokemonListLoading extends PokemonListState {
  const PokemonListLoading();
}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> items;
  const PokemonListLoaded({required this.items});
}

class PokemonListError extends PokemonListState {
  final String message;
  const PokemonListError(this.message);
}

// En UI: switch exhaustivo
switch (state) {
  case PokemonListLoading() => CircularProgressIndicator(),
  case PokemonListLoaded(:final items) => ListView(...),  // items siempre existe
  case PokemonListError(:final message) => ErrorWidget(...),
}
```

**Por qué es limpio**:
- Compilador fuerza manejar todos los casos
- No hay estados inválidos
- Pattern matching limpio

---

### 7. Testing: Qué Testeé y Plan Futuro

**Actual**: No hay testing (trade-off intencional)

**¿Por qué sin tests?**
- Timebox 1 día → MVP funcional vs coverage
- Estructura limpia hace fácil agregar tests después
- Testing manual en Android + Web

**Testing que haría primero (por prioridad):**

| Prioridad | Test | Beneficio |
|-----------|------|----------|
| P0 | `PokemonRepository.getPokemonList()` mock API + Hive | Garantiza que funciona sin internet |
| P0 | `PokemonListCubit` con mock repository | Cambios de estado correctos |
| P1 | `PokemonDetailCubit` similar | Página de detalle crítica |
| P1 | `pokemon_api.dart` - parseo de JSON | Cambios API no rompan DTO |
| P2 | `pokemon_local.dart` - operaciones con Hive | Verifica que el caché funciona |

**Setup de testing:**

```bash
# Agregar dev dependencies
flutter pub add --dev mocktail flutter_test

# Test file: test/feature/pokemon/data/pokemon_repository_impl_test.dart
```

**Ejemplo de test:**

```dart
void main() {
  group('PokemonRepository', () {
    late MockPokemonApi mockApi;
    late MockPokemonLocal mockLocal;
    late PokemonRepositoryImpl repository;

    setUp(() {
      mockApi = MockPokemonApi();
      mockLocal = MockPokemonLocal();
      repository = PokemonRepositoryImpl(api: mockApi, local: mockLocal);
    });

    test('getPokemonList returns items from API on success', () async {
      // Arrange
      when(() => mockApi.fetchList(limit: 20, offset: 0))
        .thenAnswer((_) async => [PokemonListItemDto(...)]);
      
      // Act
      final result = await repository.getPokemonList(limit: 20, offset: 0);
      
      // Assert
      expect(result.length, 1);
      verify(() => mockLocal.saveList(any())).called(1);
    });

    test('getPokemonList returns cached data on API failure', () async {
      // Arrange
      when(() => mockApi.fetchList(...))
        .thenThrow(DioException(...));
      when(() => mockLocal.loadList())
        .thenReturn([Pokemon(...)]);
      
      // Act
      final result = await repository.getPokemonList(...);
      
      // Assert
      expect(result.length, 1);
      verifyNever(() => mockLocal.saveList(any()));
    });
  });
}
```

---

### 8. Git: Estructura de Commits

**Convención: Conventional Commits**

```bash
feat: add pokemon list cubit with pagination support
  ↑    ↑
type:message

fix: handle offline cache fallback in detail page
feat: add pokemon list cubit with pagination support
chore: add app-level dependency initialization
style: apply pokemon design system and modular widgets
docs: add comprehensive README
```

**Estructura de commits (granularidad)**:

```
┌─ Initial commit
├─ feat: add pokemon list cubit with pagination support
├─ chore: add app-level dependency initialization
├─ style: apply pokemon design system and modular widgets
└─ docs: add comprehensive README
```

**¿Por qué?**

- `git log` es historia clara del proyecto
- Fácil revertir feature completa si necesario
- Tools (changelog, release notes) pueden parsear commits

**Git flow en equipo** (recomendación):
```bash
git checkout -b feat/pokemon-search   # Rama de feature
# ... commits ...
git push origin feat/pokemon-search   # Enviar
# GitHub: crear PR, revisión, merge a main
```

---

### 9. Pendientes: Top 5 Priorizado

#### P0 - Obligatorio para Producción

**1. Testing Unitario Integral**
- **¿Qué?**: Tests de Repository, Cubit, parsing de API (80% cobertura mínimo)
- **Impacto**: Sin tests, cambios rompen features sin saber
- **Implementación**:
  ```bash
  flutter pub add --dev mocktail
  # test/feature/pokemon/ → repository, cubit, datasource tests
  ```

**2. Manejo de Errores Robusto + Reintentos**
- **¿Qué?**: Excepciones personalizadas, reintentos automáticos en fallos
- **Impacto**: Mensajes claros para usuario, app resiliente
- **Implementación**:
  ```dart
  // core/exceptions/exceptions.dart - completar
  // Agregar reintento en interceptor de Dio
  dio.interceptors.add(RetryInterceptor(maxRetries: 3));
  ```

#### P1 - Funcionalidad MVP Mejorada

**3. Búsqueda y Filtros**
- **¿Qué?**: SearchBar en list, filtrar por tipo (Fire, Water, etc.)
- **Impacto**: UX real, feature demandada
- **Implementación**:
  ```dart
  // Agregar PokemonSearchCubit
  // Datasource: API soporta query (?q=pikachu)
  // UI: agregar TextField en AppBar, filtros
  ```

**4. Dark Theme**
- **¿Qué?**: Toggle light/dark, usar ThemeData
- **Impacto**: Accesibilidad, preferencia user
- **Implementación**:
  ```dart
  // ThemeCubit con estados (light, dark)
  // Guardar preferencia en Hive
  // Pasar a MaterialApp(theme: ..., darkTheme: ...)
  ```

#### P2 - Optimización

**5. Caché Inteligente con Versionado**
- **¿Qué?**: Guardar timestamp, invalidar cada 24h
- **Impacto**: Balance entre datos frescos y offline
- **Implementación**:
  ```dart
  struct CacheMetadata {
    String dataVersion;
    DateTime timestamp;
  }
  
  // Antes de devolver cache, validar edad
  if (DateTime.now().difference(metadata.timestamp) > Duration(hours: 24)) {
    return null;  // Force fresh fetch
  }
  ```

---

---

## Recursos Internos

- **Config**: `lib/core/config/app_config.dart`
- **Network**: `lib/core/network/dio_client.dart`
- **Storage**: `lib/core/storage/hive_client.dart`
- **Architecture**: `lib/feature/pokemon/` (Domain, Data, Presentation)
- **Routing**: `lib/app/router.dart`

---
---

## Autor

Agustin Viera.

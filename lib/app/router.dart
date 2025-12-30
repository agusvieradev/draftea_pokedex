import 'package:draftea_pokedex/feature/pokemon/presentation/pages/pokemon_detail_page.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/pages/pokemon_list_page.dart';
import 'package:go_router/go_router.dart';

final pokedexRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const PokemonListPage(),
    ),
    GoRoute(
      path: '/pokemon/:id',
      builder: (_, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PokemonDetailPage(pokemonId: id);
      },
    ),
  ],
);

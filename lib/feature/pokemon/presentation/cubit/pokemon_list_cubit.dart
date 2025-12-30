import 'package:draftea_pokedex/feature/pokemon/domain/pokemon.dart';
import 'package:draftea_pokedex/feature/pokemon/domain/pokemon_repository.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonRepository repository;

  static const int _pageSize = 20;

  int _offset = 0;
  bool _isLoading = false;
  final List<Pokemon> _items = [];

  PokemonListCubit(this.repository) : super(const PokemonListLoading());

  Future<void> loadInitial() async {
    _offset = 0;
    _items.clear();
    emit(const PokemonListLoading());
    await _fetchNextPage();
  }

  Future<void> loadMore() async {
    if (!_isLoading) await _fetchNextPage();
  }

  Future<void> _fetchNextPage() async {
    _isLoading = true;

    try {
      final result = await repository.getPokemonList(
        limit: _pageSize,
        offset: _offset,
      );
      _items.addAll(result);
      _offset += _pageSize;
      emit(
        PokemonListLoaded(
          items: List.unmodifiable(_items),
          hasMore: result.length == _pageSize,
        ),
      );
    } catch (_) {
      emit(const PokemonListError('Failed to load Pokémon'));
    } finally {
      _isLoading = false;
    }
  }
}

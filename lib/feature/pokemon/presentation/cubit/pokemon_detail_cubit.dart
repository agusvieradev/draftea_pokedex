import 'package:draftea_pokedex/feature/pokemon/domain/pokemon_repository.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final PokemonRepository repository;

  PokemonDetailCubit(this.repository) : super(const PokemonDetailLoading());

  Future<void> load(int id) async {
    emit(const PokemonDetailLoading());

    try {
      final pokemon = await repository.getPokemonDetail(id);
      emit(PokemonDetailLoaded(pokemon));
    } catch (_) {
      emit(const PokemonDetailError('Failed to load Pokémon'));
    }
  }
}

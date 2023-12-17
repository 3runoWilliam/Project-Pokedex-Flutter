import 'package:floor/floor.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM pokemon')
  Future<List<Pokemon>> findAllPokemons();

  @Query('SELECT * FROM pokemon WHERE id = :id')
  Future<Pokemon?> findPokemonById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertPokemon(Pokemon pokemon);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePokemon(Pokemon pokemon);

  @override
  Future<int> deletePokemon(Pokemon pokemon);
}

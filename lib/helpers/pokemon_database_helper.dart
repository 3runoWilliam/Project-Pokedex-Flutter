import 'package:project_pokedex_flutter/database/pokemon_database.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

class PokemonDatabaseHelper {
  static final PokemonDatabaseHelper _instance =
      PokemonDatabaseHelper._internal();
  factory PokemonDatabaseHelper() => _instance;

  PokemonDatabaseHelper._internal();

  PokemonDatabase? _pokemonDatabase;

  Future<PokemonDatabase> get pokemonDatabase async {
    _pokemonDatabase ??= await initDatabase();
    return _pokemonDatabase!;
  }

  Future<PokemonDatabase> initDatabase() async {
    String? databasesPath = await sqflite.getDatabasesPath();
    String path = join(databasesPath, "pokemon_database.db");

    return $FloorPokemonDatabase.databaseBuilder(path).build();
  }

  Future<Pokemon> savePokemon(Pokemon pokemon) async {
    final db = await pokemonDatabase;
    pokemon.id = await db.pokemonDao.insertPokemon(pokemon);
    return pokemon;
  }

  Future<List<Pokemon>> getAllPokemons() async {
    final db = await pokemonDatabase;
    return db.pokemonDao.findAllPokemons();
  }
}

library my_library;

import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';
import 'package:project_pokedex_flutter/dao/pokemon_dao.dart';

part 'pokemon_database.g.dart';

@Database(version: 1, entities: [Pokemon])
abstract class PokemonDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}

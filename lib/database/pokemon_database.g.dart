// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPokemonDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PokemonDatabaseBuilder databaseBuilder(String name) =>
      _$PokemonDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PokemonDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$PokemonDatabaseBuilder(null);
}

class _$PokemonDatabaseBuilder {
  _$PokemonDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PokemonDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PokemonDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PokemonDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PokemonDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PokemonDatabase extends PokemonDatabase {
  _$PokemonDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonDao? _pokemonDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pokemon` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nome` TEXT NOT NULL, `tipos` TEXT NOT NULL, `urlImagem` TEXT NOT NULL, `baseExperiencia` INTEGER NOT NULL, `habilidades` TEXT NOT NULL, `altura` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pokemonInsertionAdapter = InsertionAdapter(
            database,
            'pokemon',
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'tipos': item.tipos,
                  'urlImagem': item.urlImagem,
                  'baseExperiencia': item.baseExperiencia,
                  'habilidades': item.habilidades,
                  'altura': item.altura
                }),
        _pokemonUpdateAdapter = UpdateAdapter(
            database,
            'pokemon',
            ['id'],
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'tipos': item.tipos,
                  'urlImagem': item.urlImagem,
                  'baseExperiencia': item.baseExperiencia,
                  'habilidades': item.habilidades,
                  'altura': item.altura
                }),
        _pokemonDeletionAdapter = DeletionAdapter(
            database,
            'pokemon',
            ['id'],
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'tipos': item.tipos,
                  'urlImagem': item.urlImagem,
                  'baseExperiencia': item.baseExperiencia,
                  'habilidades': item.habilidades,
                  'altura': item.altura
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Pokemon> _pokemonInsertionAdapter;

  final UpdateAdapter<Pokemon> _pokemonUpdateAdapter;

  final DeletionAdapter<Pokemon> _pokemonDeletionAdapter;

  @override
  Future<List<Pokemon>> findAllPokemons() async {
    return _queryAdapter.queryList('SELECT * FROM pokemon',
        mapper: (Map<String, Object?> row) => Pokemon(
            id: row['id'] as int, // Correção aqui
            nome: row['nome'] as String,
            tipos: row['tipos'] as String,
            urlImagem: row['urlImagem'] as String,
            baseExperiencia: row['baseExperiencia'] as int,
            habilidades: row['habilidades'] as String,
            altura: row['altura'] as double));
  }

  @override
  Future<Pokemon?> findPokemonById(int id) async {
    return _queryAdapter.query('SELECT * FROM pokemon WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Pokemon(
            id: row['id'] as int,
            nome: row['nome'] as String,
            tipos: row['tipos'] as String,
            urlImagem: row['urlImagem'] as String,
            baseExperiencia: row['baseExperiencia'] as int,
            habilidades: row['habilidades'] as String,
            altura: row['altura'] as double),
        arguments: [id]);
  }

  @override
  Future<int> insertPokemon(Pokemon pokemon) {
    return _pokemonInsertionAdapter.insertAndReturnId(
        pokemon, OnConflictStrategy.replace);
  }

  @override
  Future<void> updatePokemon(Pokemon pokemon) async {
    await _pokemonUpdateAdapter.update(pokemon, OnConflictStrategy.replace);
  }

  @override
  Future<int> deletePokemon(Pokemon pokemon) async {
    return await _pokemonDeletionAdapter.deleteAndReturnChangedRows(pokemon);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorTodoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TodoDatabaseBuilder databaseBuilder(String name) =>
      _$TodoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TodoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TodoDatabaseBuilder(null);
}

class _$TodoDatabaseBuilder {
  _$TodoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$TodoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TodoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TodoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TodoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TodoDatabase extends TodoDatabase {
  _$TodoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Todo` (`id` INTEGER, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `done` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoInsertionAdapter = InsertionAdapter(
            database,
            'Todo',
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'done': item.done ? 1 : 0
                }),
        _todoUpdateAdapter = UpdateAdapter(
            database,
            'Todo',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'done': item.done ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final UpdateAdapter<Todo> _todoUpdateAdapter;

  @override
  Future<List<Todo>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Todo',
        mapper: (Map<String, Object?> row) => Todo(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            done: (row['done'] as int) != 0));
  }

  @override
  Future<List<Todo>> getAllByName(String search) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Todo WHERE instr(title, ?1) > 0',
        mapper: (Map<String, Object?> row) => Todo(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            done: (row['done'] as int) != 0),
        arguments: [search]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Todo WHERE id=?1', arguments: [id]);
  }

  @override
  Future<int> create(Todo todo) {
    return _todoInsertionAdapter.insertAndReturnId(
        todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> update(Todo todo) async {
    await _todoUpdateAdapter.update(todo, OnConflictStrategy.abort);
  }
}

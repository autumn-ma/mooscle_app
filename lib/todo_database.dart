import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

class TodoDatabase {
  TodoDatabase._();

  static final TodoDatabase instance = TodoDatabase._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE todos(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  is_done INTEGER NOT NULL,
  due_date TEXT NOT NULL
)''');
      },
    );
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query('todos');
    return [for (final m in maps) Todo.fromMap(m)];
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    final id = await db.insert('todos', todo.toMap());
    return id;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Constant.dart';
import '../Model/UserModel.dart';

class DatabaseHandler {
  static final DatabaseHandler? instance = DatabaseHandler._init();

  DatabaseHandler._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDB();
    return _database!;
  }

  Future<Database> _openDB() async {
    String path = join(await getDatabasesPath(), 'DatabaseNotes.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute('''
    CREATE TABLE $noteTable (
    $columnId $idType,
    $columnNoteTitle $textType,
    $columnDate $textType
    )
    ''');
  }

  /// CRUD
  // Create
  Future<void> createNote(UserModel userModel) async {
    final Database db = await instance!.database;
    db.insert(
      noteTable,
      userModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update
  Future<void> updateUser(UserModel userModel) async {
    final Database db = await instance!.database;
    db.update(
      noteTable,
      userModel.toMapUpdate(),
      where: '$columnId = ?',
      whereArgs: [userModel.id],
    );
  }

  // delete
  Future<void> deleteNote(int id) async {
    final Database db = await instance!.database;
    db.delete(
      noteTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Read all elements
  Future<List<UserModel>> getAllNotes() async {
    final Database db = await instance!.database;
    List<Map<String, dynamic>> maps = await db.query(noteTable);

    return maps.isNotEmpty
        ? maps.map((user) => UserModel.fromMap(user)).toList()
        : [];
  }

  // Read one elements
  Future<UserModel> getOneUsers(int id) async {
    final Database db = await instance!.database;
    List<Map<String, dynamic>> maps = await db.query(
      noteTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return maps.isNotEmpty
        ? UserModel.fromMap(maps.first)
        : throw Exception('No user found $id');
  }
}

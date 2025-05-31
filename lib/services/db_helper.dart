
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDb();
    return _database!;
  }

  //CREATE/ INITIALIZE DATABASE
  Future<Database> createDb() async {
    final dataBaseDirectory = await getDatabasesPath();
    final path = join(dataBaseDirectory, 'note_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
         CREATE table note(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         priority INTEGER,
         title TEXT,
         description TEXT,
         time TEXT
         ) 
         ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE note ADD COLUMN time TEXT');
        }
      },
    );
  }

  //INSERTION OPERATION
  Future<int> insertion(NoteModel noteModel) async {
    final db = await database;
    return await db.insert('note', noteModel.toMap());
  }

  //FETCH OPERATION
  Future<List<NoteModel>> fetchData() async {
    final db = await database;
    final jsonData = await db.query('note', orderBy: 'priority ASC');
    return jsonData.map((mapObj) => NoteModel.fromMapObj(mapObj)).toList();
  }

  //DELETION
  Future<int> deletion(int id) async {
    final db = await database;
    return await db.delete('note', where: 'id = ?', whereArgs: [id]);
  }
  //Updation
  Future<int> updation(NoteModel noteModel)async{
    final db = await database;
    return await db.update('note', noteModel.toMap(), where: 'id = ?', whereArgs: [noteModel.id]);
  }
}

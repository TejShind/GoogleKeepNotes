import 'package:google_notes/services/firestore_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/notemodel.dart';

class NotesDatabse {
  static final NotesDatabse instance = NotesDatabse._init();
  static Database? _database;
  NotesDatabse._init(); //private constructor

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('NewNote.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = ' BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE Notes(
      ${NotesNames.id} $idType,
      ${NotesNames.pin} $boolType,
      ${NotesNames.isArchive} $boolType,
      ${NotesNames.createdTime} $textType,
      ${NotesNames.title} $textType,
      ${NotesNames.content} $textType
    )
    ''');
  }

  Future<Note?> InsertData(Note note) async {
    await FireDB().createNewNoteFirestore(note);

    final db = await instance.database;
    final id = await db!.insert(NotesNames.TableName, note.toJson());
    return note.copy(id: id);
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${NotesNames.createdTime} ASC';
    final query_result =
        await db!.query(NotesNames.TableName, orderBy: orderBy);
    return query_result.map((json) => Note.fromJson(json)).toList();
  }

  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!.query(NotesNames.TableName,
        columns: NotesNames.values,
        where: '${NotesNames.id} = ?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Note.fromJson(map.first);
    } else {
      return null;
    }
  }

  Future updateNote(Note note) async {
    await FireDB().updateNoteFirestore(note);

    final db = await instance.database;

    await db!.update(NotesNames.TableName, note.toJson(),
        where: '${NotesNames.id} = ?', whereArgs: [note.id]);
  }

  Future pinNote(Note? note) async {
    final db = await instance.database;
    await db!.update(NotesNames.TableName, {NotesNames.pin: !note!.pin ? 1 : 0},
        where: '${NotesNames.id} = ?', whereArgs: [note.id]);
  }

  Future archNote(Note? note) async {
    final db = await instance.database;
    await db!.update(
        NotesNames.TableName, {NotesNames.isArchive: !note!.isArchive ? 1 : 0},
        where: '${NotesNames.id} = ?', whereArgs: [note.id]);
  }

  Future<List<int>> getNoteString(String query) async {
    final db = await instance.database;
    final result = await db!.query(NotesNames.TableName);
    List<int> resultIds = [];
    result.forEach((element) {
      if (element["title"].toString().toLowerCase().contains(query) ||
          element["content"].toString().toLowerCase().contains(query)) {
        resultIds.add(element["id"] as int);
      }
    });

    return resultIds;
  }

  Future deleteNote(Note? note) async {
    await FireDB().updateNoteFirestore(note!);

    final db = await instance.database;
    await db!.delete(NotesNames.TableName,
        where: '${NotesNames.id}= ?', whereArgs: [note.id]);
  }

  Future closeDB() async {
    final db = await instance.database;
    db!.close();
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vikas/model/vikas.dart';

class VikassDatabase {
  static final VikassDatabase instance = VikassDatabase._init();

  static Database? _database;

  VikassDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('vikass.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableVikass ( 
  ${VikasFields.id} $idType, 
  ${VikasFields.time} $textType,
  ${VikasFields.name} $textType,
  ${VikasFields.age} $textType,
  ${VikasFields.shgname} $textType,
  ${VikasFields.aadharnumber} $textType,
  ${VikasFields.monthlyincome} $textType,
  ${VikasFields.bankname} $textType,
  ${VikasFields.bankaccountnumber} $textType,
  ${VikasFields.shgid} $textType
  )
''');
  }

  Future<Vikas> create(Vikas vikas) async {
    final db = await instance.database;

    final id = await db.insert(tableVikass, vikas.toJson());
    return vikas.copy(id: id);
  }

  Future<Vikas> readVikas(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableVikass,
      columns: VikasFields.values,
      where: '${VikasFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Vikas.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<void> deleteDatabase(String path) async {
    // db = null;
    _database = null;
    databaseFactory.deleteDatabase(path);
  }

  Future<List<Vikas>> readAllVikass() async {
    final db = await instance.database;

    final orderBy = '${VikasFields.time} ASC';

    final result = await db.query(tableVikass, orderBy: orderBy);

    return result.map((json) => Vikas.fromJson(json)).toList();
  }

  Future<int> update(Vikas vikas) async {
    final db = await instance.database;

    return db.update(
      tableVikass,
      vikas.toJson(),
      where: '${VikasFields.id} = ?',
      whereArgs: [vikas.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableVikass,
      where: '${VikasFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}

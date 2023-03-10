import 'package:magazin_app/data/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase{
  static String tablename = 'myCart';
  static LocalDatabase getInstance = LocalDatabase._init();
  Database?_database;

  LocalDatabase._init();

  Future<Database> getDb() async {
    if(_database == null){
      _database = await _initDb('Cart.db');
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDb(String filename) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, filename);

    Database database = await openDatabase(
      path, 
      version: 1,
      onCreate: (Database db, int versino) async  {
        String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
        String textType = 'TEXT';
        String intType = 'INTEGER';
        String doubleType = 'REAL';

        String boolType = 'INTEGER';
        await db.execute('''
        Create table $tablename(
           _id $idType,
           id $intType,
           count $intType,
           title $textType,
           price $doubleType,
           category $textType,
           image $textType,
           description $textType
        )
''');
      });
    print('database yaratildi');
    return database;
  }

  static Future<Model> insertToDatabase(Model product) async {
    var database = await getInstance.getDb();
    int id = await database.insert(tablename, product.toJson());
    print('hammasi yahshi');
    print('hammasi yahshi');
    return product.copyWith(id:id);
  }

  static Future<List<Model>> getList() async {
    var database = await getInstance.getDb();
    var ListOfTodos = await database.query(tablename, columns: [
      '_id',
      "id",
      'count',
      'title',
      'price',
      'category',
      'image',
      "description",
    ]);
    List<Model> list = ListOfTodos.map((e) => Model.fromJson(e)).toList();
    return list;
  }
  static Future<Model> updateTaskById(Model product) async{
    var database = await getInstance.getDb();
    int id = await database.update(
      tablename, 
      product.toJson(),
      where: 'name = ?',
      whereArgs: [product.title],
      );
    print('hammasi yahshi');
    return product.copyWith(databaseid:id);
  }

  static Future<int> deleteTaskById(int id) async {
   var database = await getInstance.getDb();
    return await database.delete(
      tablename,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAll() async{
    var database = await getInstance.getDb();
    return await database.delete(tablename);
  }
}
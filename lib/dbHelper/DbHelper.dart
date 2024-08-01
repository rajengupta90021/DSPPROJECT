import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../Model/TestInformation.dart';

class DbHelper{
  static  Database? _db;

  Future<Database?> get db async{

    if(_db != null){
      return _db!;
    }
    _db =await initDabase();
    return _db!;
  }


  initDabase() async{

    io.Directory documemtDirectory = await getApplicationDocumentsDirectory();
    String  path = join(documemtDirectory.path,'cart2.db');
    var db= await openDatabase(path ,version: 1,onCreate: _oncreate);
    return db;
  }
  void _oncreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cart2 (
      id TEXT PRIMARY KEY,
      rates INTEGER,
      sampleColl TEXT,
      reporting TEXT,
      tests TEXT
    )
  ''');
  }

  Future<String> insert(TestCart testCart) async {
    var dbClient = await db;
    await dbClient?.insert('cart2', testCart.toMap());
    print(" id  ${testCart.id}");
    return testCart.id;
  }




Future<List<TestCart>> getCartList() async {

    var dbClient = await db;
    final List<Map<String,Object?>> queryresult= await dbClient!.query('cart2');

  return queryresult.map((e) => TestCart.fromMap(e)).toList();
  }


  Future<int> delete(String id)async{
    var dbClient = await db ;
    return await dbClient!.delete(
        'cart2',
        where: 'id = ?',
        whereArgs: [id]
    );
  }
  Future<void> clearCart() async {
    final dbb = await db;
    await dbb?.delete('cart2'); // Adjust the table name if different
  }
}
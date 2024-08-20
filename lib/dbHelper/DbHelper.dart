import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../Model/MyOrder.dart';
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




class DBHelperOrder {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }
  Future<Database> _initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'your_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE orders('
              'orderId TEXT PRIMARY KEY, '
              'userId TEXT, '
              'username TEXT, '
              'email TEXT, '
              'password TEXT, '
              'mobile TEXT, '
              'profileImg TEXT, '
              'role TEXT, '
              'createdAt TEXT, '
              'updatedAt TEXT, '
              'childName TEXT, '
              'childUserRelation TEXT, '
              'childUserPhone TEXT, '
              'childUserDob TEXT, '
              'parentChildUserAddress TEXT, '
              'childUserHouseNo TEXT, '
              'childUserPinCode TEXT, '
              'childUserCity TEXT, '
              'childUserState TEXT, '
              'selectedDate TEXT, '
              'startTime TEXT, '
              'endTime TEXT, '
              'totalAmount REAL, '
              'cartItems TEXT, '
              'orderStatus TEXT, '
              'paymentStatus TEXT, '
              'deliveryDate TEXT'
              ')',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('ALTER TABLE orders ADD COLUMN orderStatus TEXT');
          db.execute('ALTER TABLE orders ADD COLUMN paymentStatus TEXT');
          db.execute('ALTER TABLE orders ADD COLUMN deliveryDate TEXT');
        }
      },
      version: 2, // Increment version to trigger onUpgrade
    );
  }


  Future<void> insertOrder(Order order) async {
    final db = await database;
    await db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    final db = await database;
    return await db.query('orders', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<Order?> getOrderById(String orderId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'orders',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );
    if (maps.isNotEmpty) {
      return Order.fromMap(maps.first);
    }
    return null;
  }


  Future<void> updateOrder({
    required String orderId,
    required String orderStatus,
    required String paymentStatus,
    required DateTime deliveryDate,
  }) async {
    final db = await database;
    await db.update(
      'orders',
      {
        'orderStatus': orderStatus,
        'paymentStatus': paymentStatus,
        'deliveryDate': deliveryDate.toIso8601String(),
      },
      where: 'orderId = ?',
      whereArgs: [orderId],
    );
  }
  Future<void> deleteOrder(String orderId) async {
    final db = await database;
    await db.delete(
      'orders',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );
  }

}

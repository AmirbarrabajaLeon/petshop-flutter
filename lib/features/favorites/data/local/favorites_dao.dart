import 'package:sqflite/sqflite.dart';
import '../../../../core/constants/database_constants.dart';
import '../../../../core/database/app_database.dart';
import 'product_entity.dart';

class FavoritesDao {
  Future<Database> get _db async => await AppDatabase().database;

  Future<void> insert(ProductEntity product) async {
    final db = await _db;
    await db.insert(
      DatabaseConstants.favoritesTableName,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(int id) async {
    final db = await _db;
    await db.delete(
      DatabaseConstants.favoritesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ProductEntity>> getAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseConstants.favoritesTableName,
    );

    return List.generate(maps.length, (i) {
      return ProductEntity.fromMap(maps[i]);
    });
  }
}

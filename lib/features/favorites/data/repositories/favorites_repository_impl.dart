import '../../../products/domain/entities/product.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../local/favorites_dao.dart';
import '../local/product_entity.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDao favoritesDao;

  FavoritesRepositoryImpl(this.favoritesDao);

  @override
  Future<List<Product>> getFavorites() async {
    final entities = await favoritesDao.getAll();
    return entities; // ProductEntity extends Product, so this is valid.
  }

  @override
  Future<void> addFavorite(Product product) async {
    await favoritesDao.insert(ProductEntity.fromProduct(product));
  }

  @override
  Future<void> removeFavorite(int productId) async {
    await favoritesDao.delete(productId);
  }
}

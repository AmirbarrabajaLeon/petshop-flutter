import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_service.dart';
import '../../../favorites/data/local/favorites_dao.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService productService;
  final FavoritesDao favoritesDao;

  ProductRepositoryImpl(this.productService, this.favoritesDao);

  @override
  Future<List<Product>> getProducts() async {
    final products = await productService.getProducts();
    final favorites = await favoritesDao.getAll();
    final favoriteIds = favorites.map((e) => e.id).toSet();

    return products.map((product) {
      if (favoriteIds.contains(product.id)) {
        return product.copyWith(isFavorite: true);
      }
      return product;
    }).toList();
  }
}

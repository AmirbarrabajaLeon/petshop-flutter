import '../../../../features/products/domain/entities/product.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class RemoveFavoriteEvent extends FavoritesEvent {
  final Product product;

  RemoveFavoriteEvent(this.product);
}

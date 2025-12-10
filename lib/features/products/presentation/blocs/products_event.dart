import '../../domain/entities/product.dart';

abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {}

class ToggleFavorite extends ProductsEvent {
  final Product product;

  ToggleFavorite(this.product);
}

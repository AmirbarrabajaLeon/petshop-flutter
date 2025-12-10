import '../../../products/domain/entities/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class IncrementQuantity extends CartEvent {
  final Product product;
  IncrementQuantity(this.product);
}

class DecrementQuantity extends CartEvent {
  final Product product;
  DecrementQuantity(this.product);
}

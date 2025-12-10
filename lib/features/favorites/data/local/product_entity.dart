import '../../../../features/products/domain/entities/product.dart';

class ProductEntity extends Product {
  ProductEntity({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    required super.description,
    required super.stock,
    required super.rating,
    required super.category,
    super.isFavorite = true, // Always true for favorites table items
  });

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'] as int,
      name: map['title'] as String,
      price: map['price'] as double,
      image: map['image'] as String,
      description: map['description'] as String,
      stock: map['stock'] as int,
      rating: map['rating'] as double,
      category: map['category'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': name,
      'price': price,
      'image': image,
      'description': description,
      'stock': stock,
      'rating': rating,
      'category': category,
    };
  }

  factory ProductEntity.fromProduct(Product product) {
    return ProductEntity(
      id: product.id,
      name: product.name,
      price: product.price,
      image: product.image,
      description: product.description,
      stock: product.stock,
      rating: product.rating,
      category: product.category,
    );
  }
}

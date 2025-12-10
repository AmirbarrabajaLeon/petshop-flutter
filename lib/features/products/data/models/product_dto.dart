import '../../domain/entities/product.dart';

class ProductDto extends Product {
  ProductDto({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    required super.description,
    required super.stock,
    required super.rating,
    required super.category,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as int,
      name: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      description: json['description'] as String,
      stock: json['stock'] as int,
      rating: (json['rating'] as num).toDouble(),
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
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
}

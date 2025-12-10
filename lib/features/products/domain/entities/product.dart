class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final int stock;
  final double rating;
  final String category;

  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.stock,
    required this.rating,
    required this.category,
    this.isFavorite = false,
  });

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? image,
    String? description,
    int? stock,
    double? rating,
    String? category,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

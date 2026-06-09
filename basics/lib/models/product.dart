class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String category;
  final String imageEmoji;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.imageEmoji,
    required this.rating,
    required this.reviewCount,
    this.isNew = false,
    this.isFavorite = false,
  });

  double get discountPercent =>
      ((originalPrice - price) / originalPrice * 100).roundToDouble();

  bool get hasDiscount => originalPrice > price;

  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      originalPrice: originalPrice,
      category: category,
      imageEmoji: imageEmoji,
      rating: rating,
      reviewCount: reviewCount,
      isNew: isNew,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

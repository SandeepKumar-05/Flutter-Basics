class CartItem {
  final String productId;
  final String name;
  final double price;
  final String imageEmoji;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageEmoji,
    this.quantity = 1,
  });
}

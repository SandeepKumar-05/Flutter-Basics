import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class AppState extends ChangeNotifier {
  // ─── Sample products ───────────────────────────────────────────────
  final List<Product> _products = [
    const Product(
      id: 'p1',
      name: 'Air Max Pro',
      description: 'Premium running shoes with advanced air cushion technology for ultimate comfort.',
      price: 129.99,
      originalPrice: 179.99,
      category: 'Shoes',
      imageEmoji: '👟',
      rating: 4.8,
      reviewCount: 2341,
      isNew: true,
    ),
    const Product(
      id: 'p2',
      name: 'Classic Leather Watch',
      description: 'Elegant timepiece with genuine leather strap and sapphire crystal glass.',
      price: 249.99,
      originalPrice: 249.99,
      category: 'Accessories',
      imageEmoji: '⌚',
      rating: 4.9,
      reviewCount: 876,
    ),
    const Product(
      id: 'p3',
      name: 'Wireless Headphones',
      description: 'Noise-cancelling over-ear headphones with 40h battery life.',
      price: 89.99,
      originalPrice: 149.99,
      category: 'Electronics',
      imageEmoji: '🎧',
      rating: 4.7,
      reviewCount: 5120,
      isNew: true,
    ),
    const Product(
      id: 'p4',
      name: 'Minimalist Backpack',
      description: 'Sleek 20L backpack made from recycled materials, fits 15" laptops.',
      price: 69.99,
      originalPrice: 99.99,
      category: 'Bags',
      imageEmoji: '🎒',
      rating: 4.6,
      reviewCount: 1432,
    ),
    const Product(
      id: 'p5',
      name: 'Smart Ring',
      description: 'Track health metrics 24/7 with this ultra-thin titanium smart ring.',
      price: 199.99,
      originalPrice: 249.99,
      category: 'Electronics',
      imageEmoji: '💍',
      rating: 4.5,
      reviewCount: 643,
      isNew: true,
    ),
    const Product(
      id: 'p6',
      name: 'Cotton Hoodie',
      description: 'Soft 100% organic cotton hoodie with kangaroo pocket.',
      price: 44.99,
      originalPrice: 59.99,
      category: 'Clothing',
      imageEmoji: '🧥',
      rating: 4.4,
      reviewCount: 2891,
    ),
    const Product(
      id: 'p7',
      name: 'Sunglasses UV400',
      description: 'Polarised lenses with UV400 protection and titanium frame.',
      price: 79.99,
      originalPrice: 79.99,
      category: 'Accessories',
      imageEmoji: '🕶️',
      rating: 4.7,
      reviewCount: 1104,
    ),
    const Product(
      id: 'p8',
      name: 'Yoga Mat Pro',
      description: 'Non-slip 6mm thick eco-friendly yoga mat with alignment lines.',
      price: 34.99,
      originalPrice: 54.99,
      category: 'Sports',
      imageEmoji: '🧘',
      rating: 4.8,
      reviewCount: 3230,
    ),
  ];

  final List<CartItem> _cart = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  // ─── Getters ────────────────────────────────────────────────────────
  List<Product> get products => _filteredProducts;
  List<CartItem> get cart => _cart;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  List<Product> get _filteredProducts {
    return _products.where((p) {
      final matchCat =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCat && matchSearch;
    }).toList();
  }

  List<Product> get favoriteProducts =>
      _products.where((p) => p.isFavorite).toList();

  int get cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);

  double get cartTotal =>
      _cart.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  // ─── Actions ────────────────────────────────────────────────────────
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index] =
          _products[index].copyWith(isFavorite: !_products[index].isFavorite);
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    final index = _cart.indexWhere((c) => c.productId == product.id);
    if (index != -1) {
      _cart[index].quantity++;
    } else {
      _cart.add(CartItem(
        productId: product.id,
        name: product.name,
        price: product.price,
        imageEmoji: product.imageEmoji,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cart.removeWhere((c) => c.productId == productId);
    notifyListeners();
  }

  void incrementQty(String productId) {
    final index = _cart.indexWhere((c) => c.productId == productId);
    if (index != -1) {
      _cart[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQty(String productId) {
    final index = _cart.indexWhere((c) => c.productId == productId);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

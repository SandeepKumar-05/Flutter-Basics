import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final AppState state;

  const ProductCard({super.key, required this.product, required this.state});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ProductDetailScreen(product: product),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: AppTheme.textMuted.withAlpha(40), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.bgSurface,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18)),
                    ),
                    child: Center(
                      child: Text(product.imageEmoji,
                          style: const TextStyle(fontSize: 64)),
                    ),
                  ),
                  if (product.isNew)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: AppTheme.accentGradient,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('NEW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  if (product.hasDiscount)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withAlpha(200),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                            '-${product.discountPercent.toInt()}%',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => state.toggleFavorite(product.id),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppTheme.bgCard,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(60),
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isFavorite
                              ? AppTheme.accent
                              : AppTheme.textMuted,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info area
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppTheme.warning, size: 13),
                        const SizedBox(width: 3),
                        Text(product.rating.toString(),
                            style: const TextStyle(
                                color: AppTheme.textSecondary, fontSize: 11)),
                        const SizedBox(width: 4),
                        Text('(${_formatCount(product.reviewCount)})',
                            style: const TextStyle(
                                color: AppTheme.textMuted, fontSize: 11)),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: AppTheme.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                        if (product.hasDiscount) ...[
                          const SizedBox(width: 5),
                          Text(
                              '\$${product.originalPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough)),
                        ],
                        const Spacer(),
                        GestureDetector(
                          onTap: () => state.addToCart(product),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}

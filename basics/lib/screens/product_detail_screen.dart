import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int _selectedSize = 1;
  bool _addedToCart = false;
  late AnimationController _btnController;
  late Animation<double> _btnScale;

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];

  @override
  void initState() {
    super.initState();
    _btnController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _btnScale = Tween<double>(begin: 1.0, end: 0.93).animate(
        CurvedAnimation(parent: _btnController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _btnController.dispose();
    super.dispose();
  }

  void _handleAddToCart(AppState state) async {
    await _btnController.forward();
    await _btnController.reverse();
    state.addToCart(widget.product);
    setState(() => _addedToCart = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _addedToCart = false);
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final p = widget.product;

    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildAppBar(context, state, p),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHero(p),
                    _buildInfo(p),
                    _buildSizeSelector(p),
                    _buildReviews(p),
                    _buildDescription(p),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
          _buildBottomBar(context, state, p),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(
      BuildContext context, AppState state, Product p) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.bgCard.withAlpha(200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back_ios_new,
              color: AppTheme.textPrimary, size: 18),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => state.toggleFavorite(p.id),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.bgCard.withAlpha(200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              p.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: p.isFavorite ? AppTheme.accent : AppTheme.textPrimary,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      pinned: false,
    );
  }

  Widget _buildHero(Product p) {
    return Container(
      height: 320,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.bgCard,
            AppTheme.primary.withAlpha(20),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: AppTheme.primary.withAlpha(40), width: 1),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(p.imageEmoji,
                style: const TextStyle(fontSize: 140)),
          ),
          if (p.hasDiscount)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppTheme.accentGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('-${p.discountPercent.toInt()}% OFF',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfo(Product p) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(p.category,
                          style: const TextStyle(
                              color: AppTheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 8),
                    Text(p.name,
                        style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$${p.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: AppTheme.primary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800)),
                  if (p.hasDiscount)
                    Text('\$${p.originalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ...List.generate(
                5,
                (i) => Icon(
                  i < p.rating.floor()
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: AppTheme.warning,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text('${p.rating}',
                  style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              const SizedBox(width: 6),
              Text('(${p.reviewCount} reviews)',
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelector(Product p) {
    // Only show size for clothing/shoes
    if (p.category != 'Shoes' && p.category != 'Clothing') {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Size',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_sizes.length, (i) {
              final isSelected = _selectedSize == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedSize = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppTheme.primaryGradient : null,
                    color: isSelected ? null : AppTheme.bgCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppTheme.textMuted.withAlpha(60),
                    ),
                  ),
                  child: Center(
                    child: Text(_sizes[i],
                        style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppTheme.textSecondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews(Product p) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Reviews',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('See all ${p.reviewCount}',
                  style: const TextStyle(
                      color: AppTheme.primary, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            name: 'Alex M.',
            rating: 5,
            comment: 'Absolutely love it! The quality is top-notch.',
            date: '2 days ago',
          ),
          const SizedBox(height: 10),
          _ReviewCard(
            name: 'Sara K.',
            rating: 4,
            comment: 'Great product, fast delivery. Highly recommend!',
            date: '1 week ago',
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(Product p) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Description',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(p.description,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 14, height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
      BuildContext context, AppState state, Product p) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: AppTheme.bgDark,
          border: Border(
              top: BorderSide(
                  color: AppTheme.textMuted.withAlpha(40), width: 1)),
        ),
        child: Row(
          children: [
            // Cart button
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: AppTheme.textMuted.withAlpha(60), width: 1),
              ),
              child: const Icon(Icons.shopping_cart_outlined,
                  color: AppTheme.textPrimary),
            ),
            const SizedBox(width: 14),
            // Add to cart button
            Expanded(
              child: ScaleTransition(
                scale: _btnScale,
                child: GestureDetector(
                  onTap: () => _handleAddToCart(state),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: _addedToCart
                          ? const LinearGradient(
                              colors: [AppTheme.success, Color(0xFF00A078)])
                          : AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: (_addedToCart
                                  ? AppTheme.success
                                  : AppTheme.primary)
                              .withAlpha(80),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _addedToCart
                            ? const Row(
                                key: ValueKey('added'),
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle_outline,
                                      color: Colors.white, size: 18),
                                  SizedBox(width: 8),
                                  Text('Added to Cart!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700)),
                                ],
                              )
                            : const Row(
                                key: ValueKey('add'),
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.shopping_bag_outlined,
                                      color: Colors.white, size: 18),
                                  SizedBox(width: 8),
                                  Text('Add to Cart',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
class _ReviewCard extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;
  final String date;

  const _ReviewCard({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: AppTheme.textMuted.withAlpha(40), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.primary.withAlpha(60),
                child: Text(name[0],
                    style: const TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 10),
              Text(name,
                  style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(date,
                  style: const TextStyle(
                      color: AppTheme.textMuted, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                color: AppTheme.warning,
                size: 14,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(comment,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final favorites = state.favoriteProducts;

        return CustomScrollView(
          slivers: [
            _buildHeader(context, favorites.length),
            if (favorites.isEmpty)
              _buildEmptyState()
            else
              _buildProductGrid(context, state, favorites),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }

  SliverToBoxAdapter _buildHeader(BuildContext context, int count) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Wishlist ❤️',
                style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5)),
            const SizedBox(height: 6),
            Text('$count items saved',
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  SliverFillRemaining _buildEmptyState() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withAlpha(20),
                      blurRadius: 30,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: const Text('💔', style: TextStyle(fontSize: 64)),
              ),
              const SizedBox(height: 32),
              const Text('Your Wishlist is empty',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              const Text(
                  'Explore more and shortlist some items. They will appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppTheme.textMuted, fontSize: 15, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildProductGrid(
      BuildContext context, AppState state, favorites) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              ProductCard(product: favorites[index], state: state),
          childCount: favorites.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
      ),
    );
  }
}

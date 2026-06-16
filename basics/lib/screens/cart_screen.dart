import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final cart = state.cart;

        return Scaffold(
          backgroundColor: AppTheme.bgDark,
          body: cart.isEmpty
              ? _buildEmptyState()
              : CustomScrollView(
                  slivers: [
                    _buildHeader(context, state.cartCount),
                    _buildCartList(context, state),
                    const SliverToBoxAdapter(child: SizedBox(height: 120)),
                  ],
                ),
          bottomSheet: cart.isNotEmpty ? _buildCheckoutBar(context, state) : null,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
              child: const Text('🛒', style: TextStyle(fontSize: 64)),
            ),
            const SizedBox(height: 32),
            const Text('Your Cart is empty',
                style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            const Text(
                'Looks like you haven\'t added anything to your cart yet.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTheme.textMuted, fontSize: 15, height: 1.5)),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(BuildContext context, int count) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 52, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Cart 🛍️',
                style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5)),
            const SizedBox(height: 6),
            Text('$count items',
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  SliverList _buildCartList(BuildContext context, AppState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = state.cart[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AppTheme.textMuted.withAlpha(30), width: 1),
            ),
            child: Row(
              children: [
                // Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(item.imageEmoji,
                        style: const TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text('\$${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: AppTheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      // Controls
                      Row(
                        children: [
                          _buildQtyButton(
                            icon: Icons.remove,
                            onTap: () => state.decrementQty(item.productId),
                          ),
                          const SizedBox(width: 12),
                          Text('${item.quantity}',
                              style: const TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(width: 12),
                          _buildQtyButton(
                            icon: Icons.add,
                            onTap: () => state.incrementQty(item.productId),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => state.removeFromCart(item.productId),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.bgSurface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.redAccent, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        childCount: state.cart.length,
      ),
    );
  }

  Widget _buildQtyButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppTheme.bgSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.textPrimary, size: 16),
      ),
    );
  }

  Widget _buildCheckoutBar(BuildContext context, AppState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        border: Border(
            top: BorderSide(color: AppTheme.textMuted.withAlpha(30), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Price',
                    style: TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('\$${state.cartTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Checkout feature coming soon!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  shadowColor: AppTheme.primary.withAlpha(100),
                ),
                child: const Text('Checkout',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

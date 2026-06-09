import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return state.cart.isEmpty ? _buildEmpty() : _buildCart(context, state);
      },
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🛒', style: TextStyle(fontSize: 80)),
          SizedBox(height: 20),
          Text('Your cart is empty',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text('Add items to get started',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCart(BuildContext context, AppState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            itemCount: state.cart.length,
            itemBuilder: (context, i) =>
                _CartTile(item: state.cart[i], state: state),
          ),
        ),
        _buildSummary(context, state),
      ],
    );
  }

  Widget _buildSummary(BuildContext context, AppState state) {
    final subtotal = state.cartTotal;
    const shipping = 4.99;
    final total = subtotal + shipping;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border:
            Border(top: BorderSide(color: AppTheme.textMuted.withAlpha(40))),
      ),
      child: Column(
        children: [
          _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _summaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          Divider(color: AppTheme.textMuted.withAlpha(50)),
          const SizedBox(height: 8),
          _summaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isPrimary: true,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(80),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => _showCheckout(context, state),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 18),
                    SizedBox(width: 8),
                    Text('Checkout',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isPrimary = false}) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(
                color: isPrimary ? AppTheme.textPrimary : AppTheme.textSecondary,
                fontSize: isPrimary ? 16 : 14,
                fontWeight:
                    isPrimary ? FontWeight.w700 : FontWeight.w400)),
        const Spacer(),
        Text(value,
            style: TextStyle(
                color: isPrimary ? AppTheme.primary : AppTheme.textPrimary,
                fontSize: isPrimary ? 18 : 14,
                fontWeight:
                    isPrimary ? FontWeight.w800 : FontWeight.w600)),
      ],
    );
  }

  void _showCheckout(BuildContext context, AppState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.bgCard,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 52)),
            const SizedBox(height: 12),
            const Text('Order Placed!',
                style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Thank you for your purchase.\nYour order is being processed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTheme.textSecondary, fontSize: 14, height: 1.5)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  state.clearCart();
                  Navigator.pop(context);
                },
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
class _CartTile extends StatelessWidget {
  final CartItem item;
  final AppState state;

  const _CartTile({required this.item, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppTheme.textMuted.withAlpha(40), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppTheme.bgSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(item.imageEmoji,
                  style: const TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: AppTheme.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          // Quantity controls
          Row(
            children: [
              _qtyButton(
                icon: Icons.remove,
                onTap: () => state.decrementQty(item.productId),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('${item.quantity}',
                    style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ),
              _qtyButton(
                icon: Icons.add,
                onTap: () => state.incrementQty(item.productId),
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(
      {required IconData icon,
      required VoidCallback onTap,
      bool isPrimary = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          gradient: isPrimary ? AppTheme.primaryGradient : null,
          color: isPrimary ? null : AppTheme.bgSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon,
            color: isPrimary ? Colors.white : AppTheme.textSecondary,
            size: 16),
      ),
    );
  }
}

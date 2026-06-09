import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
      child: Column(
        children: [
          _buildAvatar(),
          const SizedBox(height: 28),
          _buildStats(),
          const SizedBox(height: 28),
          _buildSection('Account', [
            _MenuItem(Icons.person_outline, 'Edit Profile', AppTheme.primary),
            _MenuItem(Icons.location_on_outlined, 'Addresses', AppTheme.accent),
            _MenuItem(Icons.payment_outlined, 'Payment Methods', AppTheme.success),
          ]),
          const SizedBox(height: 16),
          _buildSection('Orders', [
            _MenuItem(Icons.local_shipping_outlined, 'Track Orders', AppTheme.warning),
            _MenuItem(Icons.history_outlined, 'Order History', AppTheme.primary),
            _MenuItem(Icons.replay_outlined, 'Returns & Refunds', AppTheme.accent),
          ]),
          const SizedBox(height: 16),
          _buildSection('Preferences', [
            _MenuItem(Icons.notifications_outlined, 'Notifications', AppTheme.primary),
            _MenuItem(Icons.dark_mode_outlined, 'Appearance', AppTheme.textSecondary),
            _MenuItem(Icons.language_outlined, 'Language', AppTheme.success),
          ]),
          const SizedBox(height: 16),
          _buildSection('Support', [
            _MenuItem(Icons.help_outline, 'Help Center', AppTheme.primary),
            _MenuItem(Icons.privacy_tip_outlined, 'Privacy Policy', AppTheme.textSecondary),
            _MenuItem(Icons.logout, 'Log Out', AppTheme.accent),
          ]),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(80),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: Text('SK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppTheme.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text('Sandeep Kumar',
            style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        const Text('sandeep@example.com',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.warning.withAlpha(30),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.warning.withAlpha(80)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, color: AppTheme.warning, size: 16),
              SizedBox(width: 6),
              Text('Premium Member',
                  style: TextStyle(
                      color: AppTheme.warning,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: AppTheme.textMuted.withAlpha(40), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem('12', 'Orders'),
          _divider(),
          _StatItem('5', 'Wishlist'),
          _divider(),
          _StatItem('3', 'Reviews'),
          _divider(),
          _StatItem('\$842', 'Spent'),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 36,
        color: AppTheme.textMuted.withAlpha(50),
      );

  Widget _buildSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(18),
            border:
                Border.all(color: AppTheme.textMuted.withAlpha(40), width: 1),
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final i = e.key;
              final item = e.value;
              return Column(
                children: [
                  _buildMenuItem(item),
                  if (i < items.length - 1)
                    Divider(
                        height: 1,
                        color: AppTheme.textMuted.withAlpha(30),
                        indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: item.color.withAlpha(30),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(item.icon, color: item.color, size: 18),
      ),
      title: Text(item.label,
          style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right,
          color: AppTheme.textMuted, size: 18),
      onTap: () {},
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;

  const _MenuItem(this.icon, this.label, this.color);
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                color: AppTheme.textSecondary, fontSize: 12)),
      ],
    );
  }
}

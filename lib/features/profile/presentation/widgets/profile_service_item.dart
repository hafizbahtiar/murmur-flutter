import 'package:flutter/material.dart';

class ProfileServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final Color? iconColor;
  final String? badgeText;

  const ProfileServiceItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.iconColor,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? Colors.blue, size: 24),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          if (trailing != null) ...[
            Text(trailing!, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            const SizedBox(width: 4),
          ],
          if (badgeText != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              color: const Color(0xFFEE4D2D),
              child: Text(badgeText!, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
            const SizedBox(width: 4),
          ],
          const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

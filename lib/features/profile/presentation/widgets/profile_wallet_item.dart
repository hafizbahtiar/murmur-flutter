import 'package:flutter/material.dart';

class ProfileWalletItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final bool isButton;
  final bool badge;

  const ProfileWalletItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.subtitleColor,
    this.isButton = false,
    this.badge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, size: 28, color: Colors.black87),
            if (badge)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Color(0xFFEE4D2D), shape: BoxShape.circle),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        if (isButton && subtitle != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEE4D2D)),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(subtitle!, style: const TextStyle(color: Color(0xFFEE4D2D), fontSize: 10)),
          )
        else if (subtitle != null)
          Text(subtitle!, style: TextStyle(color: subtitleColor ?? Colors.black87, fontSize: 10)),
      ],
    );
  }
}

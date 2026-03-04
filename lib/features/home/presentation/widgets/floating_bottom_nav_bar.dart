import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatingBottomNavBar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final bool isShrunk;
  final int unreadCount;

  const FloatingBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.isShrunk = false,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // const primaryColor = Color(0xFFEE4D2D);
    // Using context theme or hardcoded for Murmur
    final primaryColor = const Color(0xFFEE4D2D);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      margin: isShrunk ? const EdgeInsets.fromLTRB(80, 0, 80, 20) : const EdgeInsets.fromLTRB(20, 0, 20, 30),
      height: isShrunk ? 56 : 70, // Slightly adjusted heights
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85), // Translucent background
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2), // Subtle border
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, 0, Icons.home_rounded, Icons.home_outlined, 'Home', primaryColor),
              _buildNavItem(context, 1, Icons.shopping_bag_rounded, Icons.shopping_bag_outlined, 'Mall', primaryColor),
              _buildNavItem(
                context,
                2,
                Icons.notifications_rounded,
                Icons.notifications_outlined,
                'Notify',
                primaryColor,
                badgeCount: unreadCount,
              ),
              _buildNavItem(context, 3, Icons.person_rounded, Icons.person_outline_rounded, 'Me', primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
    Color primaryColor, {
    int badgeCount = 0,
  }) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? primaryColor : Colors.grey;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  child: Icon(isSelected ? activeIcon : inactiveIcon, color: color, size: 26),
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        badgeCount > 99 ? '99+' : badgeCount.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              height: isShrunk ? 0 : 18,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: AnimatedOpacity(
                  opacity: isShrunk ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: Column(
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

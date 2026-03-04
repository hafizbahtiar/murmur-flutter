import 'dart:ui';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final double expandedHeight;
  final bool pinned;
  final bool centerCollapsedTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? expandedTitleStyle;
  final TextStyle? collapsedTitleStyle;
  final Widget? flexibleContent;
  final EdgeInsetsGeometry contentPadding;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.expandedHeight = 140,
    this.pinned = true,
    this.centerCollapsedTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.expandedTitleStyle,
    this.collapsedTitleStyle,
    this.flexibleContent,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.scaffoldBackgroundColor;
    final fgColor = foregroundColor ?? theme.colorScheme.onSurface;
    final defaultExpandedStyle = theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, color: fgColor);
    final defaultCollapsedStyle = theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: fgColor);

    return SliverAppBar(
      pinned: pinned,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      expandedHeight: expandedHeight,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading,
      actions: actions,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = MediaQuery.paddingOf(context).top;
          final minHeight = topPadding + kToolbarHeight;
          final maxDelta = (expandedHeight - minHeight).abs() < 0.001 ? 1.0 : (expandedHeight - minHeight);
          final progress = ((constraints.maxHeight - minHeight) / maxDelta).clamp(0.0, 1.0);
          final titleStyle = TextStyle.lerp(
            collapsedTitleStyle ?? defaultCollapsedStyle,
            expandedTitleStyle ?? defaultExpandedStyle,
            progress,
          );
          final titleAlignment = Alignment.lerp(
            centerCollapsedTitle ? Alignment.center : Alignment.centerLeft,
            Alignment.bottomLeft,
            progress,
          )!;

          return Stack(
            fit: StackFit.expand,
            children: [
              if (flexibleContent != null)
                Opacity(
                  opacity: progress,
                  child: Padding(
                    padding: EdgeInsets.only(top: topPadding + kToolbarHeight),
                    child: flexibleContent,
                  ),
                ),
              Padding(
                padding: contentPadding.add(EdgeInsets.only(top: topPadding + 8, bottom: 10)),
                child: Align(
                  alignment: titleAlignment,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: lerpDouble(0, 0.5, progress) ?? 0,
                        sigmaY: lerpDouble(0, 0.5, progress) ?? 0,
                      ),
                      child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: titleStyle),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

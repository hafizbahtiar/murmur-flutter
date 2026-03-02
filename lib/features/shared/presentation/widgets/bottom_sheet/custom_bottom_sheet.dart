import 'package:flutter/material.dart';

/// Shows a customizable bottom sheet with a drag handle and dynamic content.
Future<T?> showCustomBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  Widget? header,
  Widget? footer,
  double? heightFactor,
  bool isDismissible = true,
  bool enableDrag = true,
  Color? backgroundColor,
  double borderRadius = 16.0,
  EdgeInsets padding = const EdgeInsets.all(16.0),
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (context) => CustomBottomSheetContent(
      title: title,
      header: header,
      footer: footer,
      heightFactor: heightFactor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      padding: padding,
      child: child,
    ),
  );
}

/// Shows a draggable bottom sheet that can expand/collapse.
Future<T?> showDraggableBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext, ScrollController) builder,
  String? title,
  Widget? header,
  Widget? footer,
  double initialChildSize = 0.5,
  double minChildSize = 0.25,
  double maxChildSize = 0.9,
  bool isDismissible = true,
  bool enableDrag = true,
  Color? backgroundColor,
  double borderRadius = 16.0,
  EdgeInsets padding = const EdgeInsets.all(16.0),
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (context, scrollController) {
        return CustomBottomSheetContent(
          title: title,
          header: header,
          footer: footer,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          padding: padding,
          scrollController: scrollController, // Pass controller to content
          child: builder(context, scrollController),
        );
      },
    ),
  );
}

class CustomBottomSheetContent extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? header;
  final Widget? footer;
  final double? heightFactor;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final ScrollController? scrollController;

  const CustomBottomSheetContent({
    super.key,
    required this.child,
    this.title,
    this.header,
    this.footer,
    this.heightFactor,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.scaffoldBackgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag Handle
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
            ),

            // Header
            if (title != null || header != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:
                    header ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title ?? '',
                            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        ),
                      ],
                    ),
              ),
              const Divider(),
            ],

            // Content
            if (heightFactor != null)
              SizedBox(height: MediaQuery.of(context).size.height * heightFactor!, child: child)
            else if (scrollController != null)
              Expanded(child: child) // Expand to fill available space in DraggableSheet
            else
              Flexible(
                child: SingleChildScrollView(controller: scrollController, padding: padding, child: child),
              ),

            // Footer
            if (footer != null) ...[
              const Divider(height: 1),
              Padding(padding: const EdgeInsets.all(16.0), child: footer!),
            ],
          ],
        ),
      ),
    );
  }
}

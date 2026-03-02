import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/product.dart';
import '../../screens/product_detail_screen.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const primaryColor = Color(0xFFEE4D2D); // Shopee Orange

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(color: Colors.grey.withAlpha(25), spreadRadius: 1, blurRadius: 2, offset: const Offset(0, 1)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image 1:1 Aspect Ratio
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      child: CachedNetworkImage(
                        imageUrl: 'https://picsum.photos/200?random=${product.id}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.grey),
                      ),
                    ),
                  ),
                  // Discount Tag (Top Right)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      color: const Color(0xFFFFECEB), // Light pink bg
                      child: const Text(
                        '-86%',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ),
                  ),
                  // Bottom Banners
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Container(
                          color: const Color(0xFF26AA99), // Teal
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: const Text(
                            'FREE\nSHIPPING',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          color: const Color(0xFFF6D600), // Yellow
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          height: 20, // Match height roughly
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '10% CASHBACK',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFFEE4D2D)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text.rich(
                      TextSpan(
                        children: [
                          if (product.isPreferred)
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Container(
                                margin: const EdgeInsets.only(right: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD0011B), // Shopee Preferred Red
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Text(
                                  'Preferred',
                                  style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          TextSpan(
                            text: product.name,
                            style: const TextStyle(fontSize: 14, height: 1.2, color: Colors.black87),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Tags Row (COD)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF26AA99)), // Teal border
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'COD',
                        style: TextStyle(fontSize: 9, color: Color(0xFF26AA99), fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    // Price and Sold Count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              'RM',
                              style: TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 1),
                            Text(
                              product.price.toStringAsFixed(2),
                              style: const TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text('5k+ sold', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

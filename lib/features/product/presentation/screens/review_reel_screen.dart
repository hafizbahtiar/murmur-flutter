import 'package:flutter/material.dart';
import '../../domain/models/product.dart';
import '../../domain/models/product_review.dart';
import '../../../shared/presentation/widgets/adaptive_back_button.dart';

class ReviewReelScreen extends StatefulWidget {
  final List<ProductReview> reviews;
  final int initialIndex;
  final Product product;

  const ReviewReelScreen({super.key, required this.reviews, required this.initialIndex, required this.product});

  @override
  State<ReviewReelScreen> createState() => _ReviewReelScreenState();
}

class _ReviewReelScreenState extends State<ReviewReelScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.reviews.length,
        itemBuilder: (context, index) {
          final review = widget.reviews[index];
          // Skip reviews without images if desired, or handle them gracefully
          if (review.imageUrls.isEmpty) {
            return Center(
              child: Text('No media for this review', style: TextStyle(color: Colors.white)),
            );
          }
          return _ReviewReelItem(review: review, product: widget.product);
        },
      ),
    );
  }
}

class _ReviewReelItem extends StatefulWidget {
  final ProductReview review;
  final Product product;

  const _ReviewReelItem({required this.review, required this.product});

  @override
  State<_ReviewReelItem> createState() => _ReviewReelItemState();
}

class _ReviewReelItemState extends State<_ReviewReelItem> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final review = widget.review;
    final totalImages = review.imageUrls.length;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Image Carousel
        PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: totalImages,
          onPageChanged: (index) {
            setState(() {
              _currentImageIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              review.imageUrls[index],
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        ),

        // Top Overlay (Back button + Counter)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const AdaptiveBackButton(color: Colors.white),
                  const Spacer(),
                  if (totalImages > 1)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${_currentImageIndex + 1}/$totalImages',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  const Spacer(),
                  // Empty SizedBox to balance the row if needed, or actions
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
        ),

        // Right Actions (Avatar, Helpful, More)
        Positioned(
          right: 16,
          bottom: 120, // Adjust based on bottom content height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 20, backgroundImage: NetworkImage(review.userAvatarUrl)),
              const SizedBox(height: 24),
              Column(
                children: const [
                  Icon(Icons.thumb_up, color: Colors.white, size: 28),
                  SizedBox(height: 4),
                  Text('Helpful', style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: const [
                  Icon(Icons.more_horiz, color: Colors.white, size: 28),
                  SizedBox(height: 4),
                  Text('More', style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
            ],
          ),
        ),

        // Bottom Content (User info, Comment, Product Card)
        Positioned(
          left: 16,
          right: 64, // Leave space for right actions
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // User Name
              Text(
                '@${review.userName}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              // Rating
              Row(
                children: List.generate(5, (index) {
                  return Icon(index < review.rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 14);
                }),
              ),
              const SizedBox(height: 8),

              // Variation
              if (review.variant != null)
                Text('Variation: ${review.variant}', style: TextStyle(color: Colors.grey[300], fontSize: 12)),
              const SizedBox(height: 8),

              // Comment
              Text(
                review.comment,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 4),
              const Text('See More', style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 12),

              // Product Snippet Card
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    Image.network(
                      widget.product.images.isNotEmpty ? widget.product.images.first : 'https://picsum.photos/50/50',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            'RM${widget.product.price.toStringAsFixed(2)}',
                            style: const TextStyle(color: Color(0xFFEE4D2D), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {}, // Already on product page effectively
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE4D2D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(0, 24),
                        textStyle: const TextStyle(fontSize: 10),
                      ),
                      child: const Text('Buy Now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Date
              Text(_formatDate(review.date), style: TextStyle(color: Colors.grey[400], fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour}:${date.minute}';
  }
}

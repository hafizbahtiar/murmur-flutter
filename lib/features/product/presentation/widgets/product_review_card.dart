import 'package:flutter/material.dart';
import '../../domain/models/product_review.dart';

class ProductReviewCard extends StatelessWidget {
  final ProductReview review;
  final bool isDetailView;
  final Function(int index)? onImageTap;

  const ProductReviewCard({super.key, required this.review, this.isDetailView = false, this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(review.userAvatarUrl), radius: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  review.userName,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isDetailView)
                const Icon(Icons.more_horiz, size: 16, color: Colors.grey)
              else
                Row(
                  children: const [
                    Text('Helpful (0)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(width: 4),
                    Icon(Icons.thumb_up_outlined, size: 14, color: Colors.grey),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              IconData icon = Icons.star_border;
              if (review.rating >= index + 1) {
                icon = Icons.star;
              } else if (review.rating >= index + 0.5) {
                icon = Icons.star_half;
              }
              return Icon(
                icon,
                size: 12,
                color: const Color(0xFFEE4D2D),
              );
            }),
          ),
          if (review.variant != null) ...[
            const SizedBox(height: 4),
            Text('Variation: ${review.variant}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
          const SizedBox(height: 8),
          Text(review.comment, style: const TextStyle(fontSize: 14, height: 1.3)),
          if (review.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.imageUrls.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onImageTap?.call(index),
                    child: Container(
                      width: 72,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(image: NetworkImage(review.imageUrls[index]), fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Text(_formatDate(review.date), style: TextStyle(fontSize: 10, color: Colors.grey[500])),
              const Spacer(),
              if (!isDetailView) ...[
                const Text('Helpful', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(width: 4),
                const Icon(Icons.thumb_up_outlined, size: 14, color: Colors.grey),
              ],
            ],
          ),
          if (!isDetailView) ...[
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Seller Response', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour}:${date.minute}';
  }
}

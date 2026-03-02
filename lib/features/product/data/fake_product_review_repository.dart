import '../domain/models/product_review.dart';
import '../domain/repositories/product_review_repository.dart';

class FakeProductReviewRepository implements ProductReviewRepository {
  static final _reviews = [
    // iPhone 15 Pro Max (id: 1)
    ProductReview(
      id: 'r1',
      productId: '1',
      userName: 'John Doe',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=1',
      rating: 5.0,
      comment: 'Absolutely loving the new titanium design! It feels so much lighter than the 14 Pro Max. The camera is insane.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      imageUrls: ['https://picsum.photos/200/300?random=1', 'https://picsum.photos/200/300?random=2'],
      variant: 'Titanium Blue, 256GB',
    ),
    ProductReview(
      id: 'r2',
      productId: '1',
      userName: 'Sarah Lee',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=2',
      rating: 4.5,
      comment: 'Great phone, but the battery life could be slightly better. Still, a huge upgrade from my iPhone 11.',
      date: DateTime.now().subtract(const Duration(days: 5)),
      variant: 'Natural Titanium, 512GB',
    ),
    ProductReview(
      id: 'r3',
      productId: '1',
      userName: 'Mike Chen',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=3',
      rating: 5.0,
      comment: 'Fast delivery! The phone arrived in perfect condition. Highly recommend this seller.',
      date: DateTime.now().subtract(const Duration(days: 10)),
      variant: 'Black Titanium, 1TB',
    ),

    // MacBook Pro (id: 2)
    ProductReview(
      id: 'r4',
      productId: '2',
      userName: 'Emily Blunt',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=4',
      rating: 5.0,
      comment: 'The M3 Pro chip is a beast. I edit 4K videos seamlessly. The Space Black color is stunning and collects fewer fingerprints.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      variant: 'Space Black, 18GB RAM',
    ),
    ProductReview(
      id: 'r5',
      productId: '2',
      userName: 'David Kim',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=5',
      rating: 4.0,
      comment: 'Expensive, but worth it for professional work. Screen is beautiful.',
      date: DateTime.now().subtract(const Duration(days: 15)),
      imageUrls: ['https://picsum.photos/200/300?random=3'],
    ),

    // AirPods Pro (id: 3)
    ProductReview(
      id: 'r6',
      productId: '3',
      userName: 'Jessica Tan',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=6',
      rating: 5.0,
      comment: 'Noise cancellation is magic. I use them on the train every day and I hear nothing but my music.',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ProductReview(
      id: 'r7',
      productId: '3',
      userName: 'Alex Wong',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=7',
      rating: 3.0,
      comment: 'Good sound, but they fall out of my ears sometimes when I run.',
      date: DateTime.now().subtract(const Duration(days: 20)),
    ),

    // Samsung S24 Ultra (id: 4)
    ProductReview(
      id: 'r8',
      productId: '4',
      userName: 'Chris Evans',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=8',
      rating: 5.0,
      comment: 'The AI features are actually useful! Circle to Search is a game changer. Camera zoom is unbelievable.',
      date: DateTime.now().subtract(const Duration(days: 4)),
      variant: 'Titanium Gray, 512GB',
    ),

    // Sony Headphones (id: 5)
    ProductReview(
      id: 'r9',
      productId: '5',
      userName: 'Music Lover',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=9',
      rating: 4.5,
      comment: 'Super comfortable and the sound quality is top notch. The app is a bit clunky though.',
      date: DateTime.now().subtract(const Duration(days: 8)),
      variant: 'Black',
    ),

    // Logitech Mouse (id: 6)
    ProductReview(
      id: 'r10',
      productId: '6',
      userName: 'Dev Guy',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=10',
      rating: 5.0,
      comment: 'Best mouse for productivity. The scroll wheel is addictive.',
      date: DateTime.now().subtract(const Duration(days: 12)),
    ),

    // Nintendo Switch (id: 7)
    ProductReview(
      id: 'r11',
      productId: '7',
      userName: 'Gamer Girl',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=11',
      rating: 5.0,
      comment: 'The OLED screen makes such a huge difference. Zelda looks amazing!',
      date: DateTime.now().subtract(const Duration(days: 6)),
      variant: 'White Joy-Con',
    ),
  ];

  @override
  Future<List<ProductReview>> getReviewsByProductId(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return _reviews.where((review) => review.productId == productId).toList();
  }
}

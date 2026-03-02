import '../domain/models/product_review.dart';
import '../domain/repositories/product_review_repository.dart';

class FakeProductReviewRepository implements ProductReviewRepository {
  static final _reviews = [
    // iPhone 15 Pro Max (id: 1) - Mixed ratings and media
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
      rating: 4.0,
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
    ProductReview(
      id: 'r12',
      productId: '1',
      userName: 'Angry Buyer',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=12',
      rating: 1.0,
      comment: 'Box was damaged upon arrival. Very disappointed.',
      date: DateTime.now().subtract(const Duration(days: 12)),
      imageUrls: ['https://picsum.photos/200/300?random=12'],
      variant: 'Natural Titanium, 256GB',
    ),
    ProductReview(
      id: 'r13',
      productId: '1',
      userName: 'Tech Reviewer',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=13',
      rating: 3.0,
      comment: 'It is okay, but not worth the upgrade if you have the 14 Pro.',
      date: DateTime.now().subtract(const Duration(days: 15)),
    ),
    ProductReview(
      id: 'r14',
      productId: '1',
      userName: 'Alice Wonder',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=14',
      rating: 5.0,
      comment: 'Best purchase ever! The zoom lens is incredible.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      imageUrls: ['https://picsum.photos/200/300?random=14'],
      variant: 'Blue Titanium, 512GB',
    ),

    ProductReview(
      id: 'r15',
      productId: '1',
      userName: 'Unlucky One',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=15',
      rating: 2.0,
      comment: 'Touch screen is not responsive sometimes.',
      date: DateTime.now().subtract(const Duration(days: 18)),
      variant: 'Black Titanium, 256GB',
    ),

    ProductReview(
      id: 'r16',
      productId: '1',
      userName: 'Fan Boy',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=16',
      rating: 5.0,
      comment: 'Just perfect. No complaints.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ProductReview(
      id: 'r17',
      productId: '1',
      userName: 'Photo Grapher',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=17',
      rating: 5.0,
      comment: 'The raw photos are huge but detailed.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      imageUrls: ['https://picsum.photos/200/300?random=17'],
      variant: 'Black Titanium, 1TB',
    ),
    ProductReview(
      id: 'r18',
      productId: '1',
      userName: 'Speedster',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=18',
      rating: 5.0,
      comment: 'A17 Pro is blazing fast.',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    // Test Scenario Product (id: 99)
    ProductReview(
      id: 't1',
      productId: '99',
      userName: 'Scenario User 1',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=991',
      rating: 5.0,
      comment: '5 star with media',
      date: DateTime.now(),
      imageUrls: ['https://picsum.photos/200/300?random=991'],
    ),
    ProductReview(
      id: 't2',
      productId: '99',
      userName: 'Scenario User 2',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=992',
      rating: 5.0,
      comment: '5 star no media',
      date: DateTime.now(),
    ),
    ProductReview(
      id: 't3',
      productId: '99',
      userName: 'Scenario User 3',
      userAvatarUrl: 'https://i.pravatar.cc/150?u=993',
      rating: 5.0,
      comment: '5 star no media',
      date: DateTime.now(),
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

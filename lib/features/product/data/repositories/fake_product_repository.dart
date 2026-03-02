import '../../domain/models/product.dart';
import '../../domain/repositories/product_repository.dart';

class FakeProductRepository implements ProductRepository {
  static const _products = [
    Product(
      id: '1',
      name:
          'iPhone 15 Pro Max 256GB/512GB/1TB - 6.7" Super Retina XDR Display, A17 Pro Chip, 48MP Camera, Titanium Design',
      description: 'The latest iPhone with A16 Bionic chip and 48MP camera.',
      price: 4999,
      isPreferred: true,
      images: [
        'https://picsum.photos/400/400?random=1_1',
        'https://picsum.photos/400/400?random=1_2',
        'https://picsum.photos/400/400?random=1_3',
        'https://picsum.photos/400/400?random=1_4',
        'https://picsum.photos/400/400?random=1_5',
      ],
    ),
    Product(
      id: '2',
      name: 'MacBook Pro 14-inch M3 Pro Chip 18GB RAM 512GB SSD - Space Black (Late 2023) - Liquid Retina XDR Display',
      description: 'M3 Pro chip, 18GB RAM, 512GB SSD. Space Black.',
      price: 8999,
      images: [
        'https://picsum.photos/400/400?random=2_1',
        'https://picsum.photos/400/400?random=2_2',
        'https://picsum.photos/400/400?random=2_3',
      ],
    ),
    Product(
      id: '3',
      name: 'Apple AirPods Pro (2nd Generation) with MagSafe Charging Case (USB-C) - Active Noise Cancellation',
      description: 'Active Noise Cancellation and Transparency mode.',
      price: 999,
      isPreferred: true,
      images: [
        'https://picsum.photos/400/400?random=3_1',
        'https://picsum.photos/400/400?random=3_2',
        'https://picsum.photos/400/400?random=3_3',
        'https://picsum.photos/400/400?random=3_4',
      ],
    ),
    Product(
      id: '4',
      name: 'Samsung Galaxy S24 Ultra 5G AI Smartphone (12GB+256GB/512GB/1TB) | 200MP Camera | S Pen',
      description: 'Galaxy AI is here. Welcome to the era of mobile AI.',
      price: 6299,
      isPreferred: true,
      images: [
        'https://picsum.photos/400/400?random=4_1',
        'https://picsum.photos/400/400?random=4_2',
        'https://picsum.photos/400/400?random=4_3',
      ],
    ),
    Product(
      id: '5',
      name: 'Sony WH-1000XM5 Wireless Noise Cancelling Headphones - Industry Leading Noise Cancellation',
      description: 'Industry-leading noise cancellation optimized to you.',
      price: 1399,
      images: [
        'https://picsum.photos/400/400?random=5_1',
        'https://picsum.photos/400/400?random=5_2',
      ],
    ),
    Product(
      id: '6',
      name: 'Logitech MX Master 3S Performance Wireless Mouse - 8K DPI Tracking, Quiet Clicks',
      description: 'An icon remastered for Mac.',
      price: 499,
      isPreferred: true,
      images: [
        'https://picsum.photos/400/400?random=6_1',
        'https://picsum.photos/400/400?random=6_2',
      ],
    ),
    Product(
      id: '7',
      name: 'Nintendo Switch OLED Model - White Joy-Con - 7-inch OLED Screen - 64GB Storage',
      description: 'Play at home on the TV or on-the-go with a vibrant OLED screen.',
      price: 1299,
      images: [
        'https://picsum.photos/400/400?random=7_1',
        'https://picsum.photos/400/400?random=7_2',
      ],
    ),
    Product(
      id: '8',
      name: 'Dyson V12 Detect Slim Fluffy Vacuum Cleaner - Laser reveals microscopic dust',
      description: 'Powerful, lightweight and detects hidden dust.',
      price: 2999,
      isPreferred: true,
      images: [
        'https://picsum.photos/400/400?random=8_1',
        'https://picsum.photos/400/400?random=8_2',
      ],
    ),
    Product(
      id: '9',
      name: 'Xiaomi Smart Air Purifier 4 Pro - OLED Touch Display - Negative Ion Generator',
      description: 'Breath clean, breath healthy.',
      price: 699,
      images: [
        'https://picsum.photos/400/400?random=9_1',
        'https://picsum.photos/400/400?random=9_2',
      ],
    ),
    Product(
      id: '10',
      name: 'Royal Kludge RK61 Mechanical Keyboard 60% Wireless Bluetooth/2.4Ghz/Wired',
      description: 'Compact 61 keys layout mechanical keyboard.',
      price: 159,
      isPreferred: true,
      images: [
        'https://picsum.photos/400/400?random=10_1',
        'https://picsum.photos/400/400?random=10_2',
      ],
    ),
  ];

  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _products;
  }

  @override
  Future<Product> fetchProductDetail(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _products.firstWhere(
      (p) => p.id == id,
      orElse: () => Product(
        id: id,
        name: 'Product $id',
        description: 'This is a detailed description for Product $id.',
        price: 1999,
      ),
    );
  }
}

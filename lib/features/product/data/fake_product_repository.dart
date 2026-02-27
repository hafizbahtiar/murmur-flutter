import '../domain/models/product.dart';
import '../domain/repositories/product_repository.dart';

class FakeProductRepository implements ProductRepository {
  static const _products = [
    Product(
      id: '1',
      name:
          'iPhone 15 Pro Max 256GB/512GB/1TB - 6.7" Super Retina XDR Display, A17 Pro Chip, 48MP Camera, Titanium Design',
      description: 'The latest iPhone with A16 Bionic chip and 48MP camera.',
      price: 4999,
      isPreferred: true,
    ),
    Product(
      id: '2',
      name: 'MacBook Pro 14-inch M3 Pro Chip 18GB RAM 512GB SSD - Space Black (Late 2023) - Liquid Retina XDR Display',
      description: 'M3 Pro chip, 18GB RAM, 512GB SSD. Space Black.',
      price: 8999,
    ),
    Product(
      id: '3',
      name: 'Apple AirPods Pro (2nd Generation) with MagSafe Charging Case (USB-C) - Active Noise Cancellation',
      description: 'Active Noise Cancellation and Transparency mode.',
      price: 999,
      isPreferred: true,
    ),
    Product(
      id: '4',
      name: 'Samsung Galaxy S24 Ultra 5G AI Smartphone (12GB+256GB/512GB/1TB) | 200MP Camera | S Pen',
      description: 'Galaxy AI is here. Welcome to the era of mobile AI.',
      price: 6299,
      isPreferred: true,
    ),
    Product(
      id: '5',
      name: 'Sony WH-1000XM5 Wireless Noise Cancelling Headphones - Industry Leading Noise Cancellation',
      description: 'Industry-leading noise cancellation optimized to you.',
      price: 1399,
    ),
    Product(
      id: '6',
      name: 'Logitech MX Master 3S Performance Wireless Mouse - 8K DPI Tracking, Quiet Clicks',
      description: 'An icon remastered for Mac.',
      price: 499,
      isPreferred: true,
    ),
    Product(
      id: '7',
      name: 'Nintendo Switch OLED Model - White Joy-Con - 7-inch OLED Screen - 64GB Storage',
      description: 'Play at home on the TV or on-the-go with a vibrant OLED screen.',
      price: 1299,
    ),
    Product(
      id: '8',
      name: 'Dyson V12 Detect Slim Fluffy Vacuum Cleaner - Laser reveals microscopic dust',
      description: 'Powerful, lightweight and detects hidden dust.',
      price: 2999,
      isPreferred: true,
    ),
    Product(
      id: '9',
      name: 'Xiaomi Smart Air Purifier 4 Pro - OLED Touch Display - Negative Ion Generator',
      description: 'Breath clean, breath healthy.',
      price: 699,
    ),
    Product(
      id: '10',
      name: 'Royal Kludge RK61 Mechanical Keyboard 60% Wireless Bluetooth/2.4Ghz/Wired',
      description: 'Compact 61 keys layout mechanical keyboard.',
      price: 159,
      isPreferred: true,
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

class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> images;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isFeatured;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.images = const [],
    required this.description,
    this.sizes = const [],
    this.colors = const [],
    this.rating = 4.5,
    this.reviewCount = 0,
    this.isNew = false,
    this.isFeatured = false,
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  int get discountPercent {
    if (!hasDiscount) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }

  String get formattedPrice => 'Rs. ${price.toStringAsFixed(0)}';
  String get formattedOriginalPrice =>
      originalPrice != null ? 'Rs. ${originalPrice!.toStringAsFixed(0)}' : '';
}

// Mock product data
class ProductData {
  static List<Product> get allProducts => [
        Product(
          id: '1',
          name: 'Linen Blend Blazer',
          brand: 'AARA Studio',
          category: 'Women',
          price: 8500,
          originalPrice: 12000,
          imageUrl:
              'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=600',
          images: [
            'https://images.unsplash.com/photo-1594938298603-c8148c4b4e82?w=600',
            'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=600',
          ],
          description:
              'A sophisticated linen-blend blazer perfect for both formal and casual occasions. Featuring a relaxed silhouette with structured shoulders.',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['Beige', 'Black', 'Ivory'],
          rating: 4.7,
          reviewCount: 142,
          isFeatured: true,
        ),
        Product(
          id: '2',
          name: 'Silk Wrap Dress',
          brand: 'AARA Luxe',
          category: 'Women',
          price: 11500,
          originalPrice: 15000,
          imageUrl:
              'https://images.unsplash.com/photo-1572804013427-4d7ca7268217?w=600',
          images: [
            'https://images.unsplash.com/photo-1572804013427-4d7ca7268217?w=600',
          ],
          description:
              'Elegantly draped silk wrap dress that transitions effortlessly from day to evening. The fluid silhouette flatters all body types.',
          sizes: ['XS', 'S', 'M', 'L'],
          colors: ['Dusty Rose', 'Sage', 'Camel'],
          rating: 4.9,
          reviewCount: 89,
          isNew: true,
          isFeatured: true,
        ),
        Product(
          id: '3',
          name: 'Slim Fit Chinos',
          brand: 'AARA Men',
          category: 'Men',
          price: 4200,
          imageUrl:
              'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=600',
          images: [
            'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=600',
          ],
          description:
              'Classic slim-fit chinos crafted from premium cotton blend. Versatile enough for the office or weekend outings.',
          sizes: ['28', '30', '32', '34', '36'],
          colors: ['Khaki', 'Navy', 'Olive', 'Stone'],
          rating: 4.5,
          reviewCount: 213,
          isFeatured: true,
        ),
        Product(
          id: '4',
          name: 'Oversized Knit Sweater',
          brand: 'AARA Cozy',
          category: 'Women',
          price: 6800,
          originalPrice: 8500,
          imageUrl:
              'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=600',
          images: [
            'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=600',
          ],
          description:
              'Chunky oversized knit sweater in a relaxed fit. Made from soft wool blend for warmth and comfort.',
          sizes: ['S/M', 'L/XL'],
          colors: ['Cream', 'Caramel', 'Grey'],
          rating: 4.6,
          reviewCount: 67,
          isNew: true,
        ),
        Product(
          id: '5',
          name: 'Oxford Button-Down',
          brand: 'AARA Men',
          category: 'Men',
          price: 3800,
          imageUrl:
              'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=600',
          images: [
            'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=600',
          ],
          description:
              'A timeless Oxford shirt crafted from 100% cotton. Features a classic collar and chest pocket detail.',
          sizes: ['S', 'M', 'L', 'XL', 'XXL'],
          colors: ['White', 'Light Blue', 'Pink', 'Striped'],
          rating: 4.4,
          reviewCount: 198,
        ),
        Product(
          id: '6',
          name: 'Wide Leg Trousers',
          brand: 'AARA Studio',
          category: 'Women',
          price: 5500,
          originalPrice: 7200,
          imageUrl:
              'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600',
          images: [
            'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600',
          ],
          description:
              'Fluid wide-leg trousers in a tailored cut. The high waist elongates the silhouette for a sophisticated look.',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['Ecru', 'Black', 'Terracotta'],
          rating: 4.8,
          reviewCount: 112,
          isFeatured: true,
        ),
        Product(
          id: '7',
          name: 'Leather Belt',
          brand: 'AARA Accessories',
          category: 'Accessories',
          price: 2200,
          imageUrl:
              'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600',
          images: [
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600',
          ],
          description:
              'Premium full-grain leather belt with a brushed gold buckle. A wardrobe essential that elevates any outfit.',
          sizes: ['S', 'M', 'L', 'XL'],
          colors: ['Tan', 'Black', 'Cognac'],
          rating: 4.3,
          reviewCount: 54,
        ),
        Product(
          id: '8',
          name: 'Floral Midi Skirt',
          brand: 'AARA Studio',
          category: 'Women',
          price: 4800,
          imageUrl:
              'https://images.unsplash.com/photo-1583496661160-fb5218523f91?w=600',
          images: [
            'https://images.unsplash.com/photo-1583496661160-fb5218523f91?w=600',
          ],
          description:
              'Romantic floral print midi skirt with a flowing A-line silhouette. Features an elasticated waist for comfort.',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['Blush Floral', 'Earth Floral'],
          rating: 4.6,
          reviewCount: 88,
          isNew: true,
        ),
        Product(
          id: '9',
          name: 'Structured Tote Bag',
          brand: 'AARA Accessories',
          category: 'Accessories',
          price: 9800,
          originalPrice: 13500,
          imageUrl:
              'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=600',
          images: [
            'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=600',
          ],
          description:
              'Spacious structured tote in premium vegan leather. Features interior pockets and magnetic closure.',
          sizes: ['One Size'],
          colors: ['Camel', 'Black', 'Burgundy'],
          rating: 4.9,
          reviewCount: 176,
          isFeatured: true,
        ),
        Product(
          id: '10',
          name: 'Cashmere Scarf',
          brand: 'AARA Luxe',
          category: 'Accessories',
          price: 5200,
          imageUrl:
              'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=600',
          images: [
            'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=600',
          ],
          description:
              'Ultra-soft cashmere scarf in a generous size. Versatile enough to wear as a wrap, shawl, or traditional scarf.',
          sizes: ['One Size'],
          colors: ['Camel', 'Ivory', 'Charcoal', 'Blush'],
          rating: 4.8,
          reviewCount: 93,
        ),
        Product(
          id: '11',
          name: 'Tailored Suit Jacket',
          brand: 'AARA Men',
          category: 'Men',
          price: 15500,
          originalPrice: 19000,
          imageUrl:
              'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600',
          images: [
            'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600',
          ],
          description:
              'A precisely tailored suit jacket in Italian wool blend. Single-breasted with notch lapels and two-button closure.',
          sizes: ['S', 'M', 'L', 'XL', 'XXL'],
          colors: ['Charcoal', 'Navy', 'Black'],
          rating: 4.7,
          reviewCount: 61,
          isFeatured: true,
        ),
        Product(
          id: '12',
          name: 'Ribbed Tank Top',
          brand: 'AARA Basics',
          category: 'Women',
          price: 1800,
          imageUrl:
              'https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?w=600',
          images: [
            'https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?w=600',
          ],
          description:
              'A wardrobe essential ribbed tank top in a slim fit. Made from soft, breathable cotton blend.',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['White', 'Black', 'Mocha', 'Sage'],
          rating: 4.4,
          reviewCount: 320,
          isNew: false,
        ),
      ];

  static List<String> get categories => [
        'All',
        'Women',
        'Men',
        'Accessories',
        'New Arrivals',
        'Sale',
      ];
}

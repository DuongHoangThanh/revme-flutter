import '../enum/product_category.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final BigInt ethPrice;
  final bool isActive;
  final ProductCategory category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ethPrice,
    required this.isActive,
    required this.category,
  });

  factory Product.fromBlockchain(int id, String name, BigInt ethPrice,
      bool isActive, ProductCategory category) {
    return Product(
      id: id,
      name: name,
      description: 'Description for $name',
      imageUrl: _getImageForCategory(category),
      ethPrice: ethPrice,
      isActive: isActive,
      category: category,
    );
  }

  static String _getImageForCategory(ProductCategory category) {
    switch (category) {
      case ProductCategory.food:
        return 'https://images.unsplash.com/photo-1490645935967-10de6ba17061';
      case ProductCategory.equipment:
        return 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438';
      case ProductCategory.medicine:
        return 'https://images.unsplash.com/photo-1584308074727-e93dca1a2697';
    }
  }
}

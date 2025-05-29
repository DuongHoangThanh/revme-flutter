import 'package:rev_me_app/core/models/product.dart';

import '../../core/enum/product_category.dart';

class LocalProduct {
  List<Product> getProducts() {
    final List<Product> mockProducts = [
      Product(
        id: 1,
        name: 'Protein Shake',
        description: 'High quality protein shake for muscle recovery',
        imageUrl:
            'https://dymatize.imgix.net/a/blog/ChocPeppermintProteinShake_1856x1236.jpg?ar=928%3A618&auto=format%2Ccompress&fit=crop&ixlib=php-3.1.0&s=16528de05896185ee56d4574ff411d60',
        ethPrice: BigInt.from(100000000000000000),
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 2,
        name: 'Dumbbells Set',
        description: 'Adjustable dumbbells set for home workouts',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrhgxhPsy63RNpO3KjCapgaZbPCzw0J8BYVA&s',
        ethPrice: BigInt.from(5000000000000000),
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 3,
        name: 'Vitamin Complex',
        description: 'Daily vitamin complex for athletes',
        imageUrl:
            'https://bizweb.dktcdn.net/thumb/1024x1024/100/462/999/products/240577110-4655693474549767-2813376463094547685-n-768x768.jpg?v=1683076949843',
        ethPrice: BigInt.from(2000000000000000),
        isActive: true,
        category: ProductCategory.medicine,
      ),
      Product(
        id: 4,
        name: 'Yoga Mat',
        description: 'Premium non-slip yoga mat',
        imageUrl:
            'https://cdn.thewirecutter.com/wp-content/media/2024/07/yoga-mat-2048px-1633-2x1-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
        ethPrice: BigInt.from(3000000000000000),
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 5,
        name: 'Energy Bar',
        description: 'Nutritious energy bar with nuts and dried fruits',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeqA9-_GzIUh6kkNJF91p1JWbvMcFEeGXBKQ&s',
        ethPrice: BigInt.from(500000000000000),
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 6,
        name: 'Omega-3 Supplements',
        description: 'High-quality fish oil supplements',
        imageUrl:
            'https://product.hstatic.net/200000713511/product/fish-oil-natural-made-300-vien_00f5522296424117b6681a159172f4e5.jpg',
        ethPrice: BigInt.from(1500000000000000),
        isActive: true,
        category: ProductCategory.medicine,
      ),
    ];
    return mockProducts;
  }
}

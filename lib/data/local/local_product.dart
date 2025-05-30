import 'package:rev_me_app/core/models/product.dart';

import '../../core/enum/product_category.dart';

class LocalProduct {
  List<Product> getProducts() {
    final List<Product> mockProducts = [
      // Existing products
      Product(
        id: 1,
        name: 'Protein Shake',
        description: 'High quality protein shake for muscle recovery',
        imageUrl:
        'https://dymatize.imgix.net/a/blog/ChocPeppermintProteinShake_1856x1236.jpg?ar=928%3A618&auto=format%2Ccompress&fit=crop&ixlib=php-3.1.0&s=16528de05896185ee56d4574ff411d60',
        ethPrice: BigInt.from(100000000000000000), // 0.1 ETH
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 2,
        name: 'Dumbbells Set',
        description: 'Adjustable dumbbells set for home workouts',
        imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrhgxhPsy63RNpO3KjCapgaZbPCzw0J8BYVA&s',
        ethPrice: BigInt.from(2500000000000000000), // 2.5 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 3,
        name: 'Vitamin Complex',
        description: 'Daily vitamin complex for athletes',
        imageUrl:
        'https://bizweb.dktcdn.net/thumb/1024x1024/100/462/999/products/240577110-4655693474549767-2813376463094547685-n-768x768.jpg?v=1683076949843',
        ethPrice: BigInt.from(300000000000000000), // 0.3 ETH
        isActive: true,
        category: ProductCategory.medicine,
      ),
      Product(
        id: 4,
        name: 'Yoga Mat',
        description: 'Premium non-slip yoga mat',
        imageUrl:
        'https://cdn.thewirecutter.com/wp-content/media/2024/07/yoga-mat-2048px-1633-2x1-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
        ethPrice: BigInt.from(450000000000000000), // 0.45 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 5,
        name: 'Energy Bar',
        description: 'Nutritious energy bar with nuts and dried fruits',
        imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeqA9-_GzIUh6kkNJF91p1JWbvMcFEeGXBKQ&s',
        ethPrice: BigInt.from(150000000000000000), // 0.15 ETH
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 6,
        name: 'Omega-3 Supplements',
        description: 'High-quality fish oil supplements',
        imageUrl:
        'https://product.hstatic.net/200000713511/product/fish-oil-natural-made-300-vien_00f5522296424117b6681a159172f4e5.jpg',
        ethPrice: BigInt.from(250000000000000000), // 0.25 ETH
        isActive: true,
        category: ProductCategory.medicine,
      ),

      // New Food Category Products
      Product(
        id: 7,
        name: 'Whey Protein Isolate',
        description: 'Premium whey protein isolate with 27g protein per serving, perfect for post-workout recovery',
        imageUrl: 'https://cdn.xaxi.vn/tpcn/img/california-gold-nutrition-sport-whey-protein-isolate-1-lb-16-oz-454-g-71031.jpg',
        ethPrice: BigInt.from(800000000000000000), // 0.8 ETH
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 8,
        name: 'BCAA Powder',
        description: 'Branched-chain amino acids supplement to support muscle growth and reduce fatigue during workouts',
        imageUrl: 'https://boltnutritions.com/cdn/shop/files/1_53ff8126-6b8b-4882-b9ba-67a20ae25a1e.jpg?v=1743507868&width=1946',
        ethPrice: BigInt.from(650000000000000000), // 0.65 ETH
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 9,
        name: 'Pre-Workout Energy Drink',
        description: 'Advanced formula with caffeine, beta-alanine and creatine for maximum workout performance',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOS_iRAcsrXj3EQ2S47N2mZarCf0qhy7Jccw&s',
        ethPrice: BigInt.from(500000000000000000), // 0.5 ETH
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 10,
        name: 'Protein Pancake Mix',
        description: 'Delicious high-protein pancake mix with 15g protein per serving, low sugar and carbs',
        imageUrl: 'https://cdn.premierprotein.com/p/a/baseprod/Premier_Protein_Pancake_Mix_Original_Thumbnail.jpg',
        ethPrice: BigInt.from(350000000000000000), // 0.35 ETH
        isActive: true,
        category: ProductCategory.food,
      ),

      // New Equipment Category Products
      Product(
        id: 11,
        name: 'Resistance Bands Set',
        description: 'Complete set of 5 resistance bands with different tension levels, handles, ankle straps and door anchor',
        imageUrl: 'https://m.media-amazon.com/images/I/61D-J58lmLL.jpg',
        ethPrice: BigInt.from(700000000000000000), // 0.7 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 12,
        name: 'Jump Rope',
        description: 'Premium adjustable jump rope with ball bearings for smooth rotation and comfortable foam handles',
        imageUrl: 'https://www.gaiam.com/cdn/shop/products/05-64484_GAIAM-WEIGHTED-JUMP-ROPE_A.jpg?v=1635877894',
        ethPrice: BigInt.from(250000000000000000), // 0.25 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 13,
        name: 'Fitness Tracker',
        description: 'Smart fitness band with heart rate monitor, step counter, sleep tracking and workout modes',
        imageUrl: 'https://pyxis.nymag.com/v1/imgs/921/c0c/d56eeaa21522d8918ee1cedde9dea91293.rsquare.w600.jpg',
        ethPrice: BigInt.from(3800000000000000000), // 3.8 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 14,
        name: 'AB Roller Wheel',
        description: 'Core strength trainer with ergonomic handles and non-slip rubber wheel for stability',
        imageUrl: 'https://target.scene7.com/is/image/Target/GUEST_ce2cca5e-6fd7-4990-9c38-f22ad1d23f00',
        ethPrice: BigInt.from(280000000000000000), // 0.28 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 15,
        name: 'Foam Roller',
        description: 'High-density foam roller for muscle recovery, myofascial release and physical therapy',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj3fEb87o5I-QgtgBdK0ejyqp1pOrV5XYoJr6rtp2-LtskU2u8zp3DPUaIt4feHvuzDw8&usqp=CAU',
        ethPrice: BigInt.from(370000000000000000), // 0.37 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),

      // New Medicine Category Products
      Product(
        id: 16,
        name: 'Magnesium Supplements',
        description: 'Magnesium glycinate tablets for muscle function, recovery and improved sleep quality',
        imageUrl: 'https://pics.walgreens.com/prodimg/658802/450.jpg',
        ethPrice: BigInt.from(180000000000000000), // 0.18 ETH
        isActive: true,
        category: ProductCategory.medicine,
      ),
      Product(
        id: 17,
        name: 'Joint Support Formula',
        description: 'Complete joint support with glucosamine, chondroitin, MSM and turmeric for improved mobility',
        imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/713RJrYHi+S.jpg',
        ethPrice: BigInt.from(420000000000000000), // 0.42 ETH
        isActive: true,
        category: ProductCategory.medicine,
      ),
      Product(
        id: 18,
        name: 'ZMA Sleep Aid',
        description: 'Zinc, Magnesium and Vitamin B6 formula to enhance recovery and improve sleep quality',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6sNlSNhd7yq6_0UKA9n7862dENEvyQFOB4w&s',
        ethPrice: BigInt.from(250000000000000000), // 0.25 ETH
        isActive: true,
        category: ProductCategory.medicine,
      ),
      Product(
        id: 19,
        name: 'Probiotic Complex',
        description: '50 billion CFU probiotic with 15 strains for gut health, digestion and immune support',
        imageUrl: 'https://cdn.famitaa.com/uploads/noidung/thumb/men-vi-sinh-gnc-probiotic-complex-extra-strength-100-billion-cfus-20-vien_00801.jpg',
        ethPrice: BigInt.from(480000000000000000), // 0.48 ETH
        isActive: true,
        category: ProductCategory.medicine,
      ),
      Product(
        id: 20,
        name: 'Collagen Peptides',
        description: 'Unflavored collagen powder for joint health, skin elasticity and muscle support',
        imageUrl: 'https://bizweb.dktcdn.net/100/011/344/products/orgain-collagen-peptides-50-superfoods-1lbs-unflavored3.jpg?v=1737083914190',
        ethPrice: BigInt.from(550000000000000000), // 0.55 ETH
        isActive: true,
        category: ProductCategory.medicine,
      ),

      // Additional Equipment
      Product(
        id: 21,
        name: 'Push-Up Handles',
        description: 'Ergonomic push-up bars with padded grips for improved form and reduced wrist strain',
        imageUrl: 'https://m.media-amazon.com/images/I/619HPn+7P0L._AC_SL1500_.jpg',
        ethPrice: BigInt.from(210000000000000000), // 0.21 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),
      Product(
        id: 22,
        name: 'Digital Smart Scale',
        description: 'Bluetooth-enabled scale measuring weight, BMI, body fat percentage and more',
        imageUrl: 'https://image.made-in-china.com/2f0j00kcKfTVvqEmoI/Ihome-LED-Display-Digital-Smart-Scale-Body-Scale.webp',
        ethPrice: BigInt.from(1950000000000000000), // 1.95 ETH
        isActive: true,
        category: ProductCategory.equipment,
      ),

      // Additional Food Products
      Product(
        id: 23,
        name: 'Electrolyte Powder',
        description: 'Zero-sugar hydration formula with essential electrolytes for workout recovery',
        imageUrl: 'https://bizweb.dktcdn.net/100/011/344/products/nutricost-electrolyte-advanced-powder-bu-dien-giai-gymstore-jpeg.jpg?v=1692345564267',
        ethPrice: BigInt.from(280000000000000000), // 0.28 ETH
        isActive: true,
        category: ProductCategory.food,
      ),
      Product(
        id: 24,
        name: 'Protein Cookie',
        description: 'Soft-baked cookies with 15g protein and only 5g sugar, perfect post-workout snack',
        imageUrl: 'https://www.questnutrition.com/cdn/shop/files/qst-protck-protein-cookie-variety-pack_81a52816-0832-4cea-979f-28fb4c4c0cab.png?v=1701716233',
        ethPrice: BigInt.from(190000000000000000), // 0.19 ETH
        isActive: true,
        category: ProductCategory.food,
      ),
    ];
    return mockProducts;
  }
}
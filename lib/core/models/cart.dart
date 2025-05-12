import '../models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final bool usedTokens;

  CartItem({
    required this.product,
    required this.quantity,
    required this.usedTokens,
  });

  BigInt get totalEthPrice => product.ethPrice * BigInt.from(quantity);
  BigInt get totalFitPrice => product.fitPrice * BigInt.from(quantity);
}
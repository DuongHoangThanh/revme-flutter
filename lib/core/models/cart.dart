import '../models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  BigInt get totalEthPrice => product.ethPrice * BigInt.from(quantity);
}
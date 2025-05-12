import 'package:flutter/material.dart';
import '../core/models/cart.dart';
import '../core/models/product.dart';
import '../core/enum/product_category.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  bool _isLoading = true;

  CartViewModel() {
    _loadCart();
  }

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  BigInt get totalEthPrice {
    return _cartItems.fold(
        BigInt.zero,
            (sum, item) => sum + (item.usedTokens ? BigInt.zero : item.totalEthPrice)
    );
  }

  BigInt get totalFitPrice {
    return _cartItems.fold(
        BigInt.zero,
            (sum, item) => sum + (item.usedTokens ? item.totalFitPrice : BigInt.zero)
    );
  }

  Future<void> _loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      // This would normally load from storage or an API
      // For demo, we'll add some mock items
      await Future.delayed(const Duration(seconds: 1));

      _cartItems.addAll([
        CartItem(
          product: Product(
            id: 1,
            name: 'Protein Shake',
            description: 'High quality protein shake for muscle recovery',
            imageUrl: 'https://images.unsplash.com/photo-1594059917370-abcc813eb875',
            ethPrice: BigInt.from(1000000000000000),
            fitPrice: BigInt.parse('10000000000000000000'), // 10 FIT tokens
            isActive: true,
            category: ProductCategory.food,
          ),
          quantity: 2,
          usedTokens: true,
        ),
        CartItem(
          product: Product(
            id: 2,
            name: 'Dumbbells Set',
            description: 'Adjustable dumbbells set for home workouts',
            imageUrl: 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2',
            ethPrice: BigInt.from(5000000000000000),
            fitPrice: BigInt.parse('50000000000000000000'), // 50 FIT tokens
            isActive: true,
            category: ProductCategory.equipment,
          ),
          quantity: 1,
          usedTokens: false,
        ),
      ]);
    } catch (e) {
      print('Error loading cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      final item = _cartItems[index];
      final updatedItem = CartItem(
        product: item.product,
        quantity: newQuantity,
        usedTokens: item.usedTokens,
      );
      _cartItems[index] = updatedItem;
      notifyListeners();
    }
  }

  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  Future<void> checkout(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      // This would normally call your blockchain service
      // BlockchainService().processCartPurchase(_cartItems);

      _cartItems.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Purchase completed successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during checkout: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
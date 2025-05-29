import 'package:flutter/material.dart';
import '../core/models/cart.dart';
import '../core/models/product.dart';
import '../core/enum/product_category.dart';
import '../core/services/blockchain_service.dart';
import '../core/services/transaction_service.dart';
import '../core/services/user_preferences_service.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  bool _isLoading = true;
  final BlockchainService _blockchainService = BlockchainService();
  final TransactionService _transactionService = TransactionService();
  String _userAddress = '';
  String _walletPrivateKey = '';
  Map<String, String?> _userInfo = {};

  CartViewModel() {
    _loadCart();
    _loadUserInfo();
    loadUserAddress();
  }
  void loadUserAddress() async {
    String? address = await UserPreferencesService.getWalletAddress();
    _userAddress = address ?? '';
    String? privateKey = await UserPreferencesService.getWalletPrivateKey();
    _walletPrivateKey = privateKey ?? '';
    notifyListeners();
  }
  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  // Getters for user info
  String get userName => _userInfo['name'] ?? 'Guest User';
  String get userPhone => _userInfo['phone'] ?? '';
  String get shippingAddress => _userInfo['address'] ?? '';
  String get userCity => _userInfo['city'] ?? '';
  String get userWalletAddress => _userInfo['walletAddress'] ?? _userAddress;

  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  BigInt get totalEthPrice {
    return _cartItems.fold(
      BigInt.zero,
      (sum, item) => sum + item.totalEthPrice
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
            ethPrice: BigInt.from(100000000000000000), // 0.1 ETH
            isActive: true,
            category: ProductCategory.food,
          ),
          quantity: 2,
        ),
        CartItem(
          product: Product(
            id: 2,
            name: 'Dumbbells Set',
            description: 'Adjustable dumbbells set for home workouts',
            imageUrl: 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2',
            ethPrice: BigInt.from(500000000000000000), // 0.5 ETH
            isActive: true,
            category: ProductCategory.equipment,
          ),
          quantity: 1,
        ),
      ]);
    } catch (e) {
      print('Error loading cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load user info from SharedPreferences
  Future<void> _loadUserInfo() async {
    try {
      final walletAddress = await UserPreferencesService.getWalletAddress();
      if (walletAddress != null && walletAddress.isNotEmpty) {
        _userAddress = walletAddress;
      }
      
      _userInfo = await UserPreferencesService.getAllUserInfo();
      notifyListeners();
    } catch (e) {
      print('Error loading user info: $e');
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
    try {
      _isLoading = true;
      notifyListeners();

      // Đảm bảo lấy địa chỉ ví mới nhất
      await _loadUserInfo();
      
      // Connect to blockchain
      final connected = await _blockchainService.initBlockchain();
      if (!connected) {
        throw Exception('Failed to connect to blockchain');
      }

      // Process each cart item
      for (final item in _cartItems) {
        final result = await _blockchainService.purchaseProduct(
          item.product.id,
          item.totalEthPrice,
          userWalletAddress,
          _walletPrivateKey
        );

        if (result.success) {
          // Save transaction to Firebase
          await _transactionService.saveTransaction(
            userAddress: _userAddress,
            productName: item.product.name,
            ethAmount: item.totalEthPrice,
            txHash: result.txHash!,
            description: 'Purchased ${item.quantity}x ${item.product.name} for ${item.totalEthPrice} ETH',
          );
        } else {
          throw Exception(result.message);
        }
      }

      _cartItems.clear();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Purchase completed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }

    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error during checkout: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
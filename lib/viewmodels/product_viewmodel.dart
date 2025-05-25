import 'package:flutter/material.dart';
import '../core/models/product.dart';
import '../core/enum/product_category.dart';
import '../core/services/blockchain_service.dart';
import '../core/services/transaction_service.dart';

class ProductViewModel extends ChangeNotifier {
  final BlockchainService _blockchainService;
  final TransactionService _transactionService = TransactionService();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String _error = '';
  ProductCategory? _selectedCategory;
  bool _isBlockchainConnected = false;
  bool _isBlockchainLoading = false;
  double ethBalance = 0;

  // Use a default address for testing
  final String _userAddress = '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266';

  ProductViewModel({required BlockchainService blockchainService})
      : _blockchainService = blockchainService;

  // Getters
  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  bool get isBlockchainLoading => _isBlockchainLoading;
  bool get isBlockchainConnected => _isBlockchainConnected;
  String get error => _error;
  ProductCategory? get selectedCategory => _selectedCategory;
  String get userAddress => _userAddress;

  // Initialize the view model
  Future<void> init() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      await fetchProducts();
      fetchEthBalance();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error loading products: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch the ETH balance
  Future<void> fetchEthBalance() async {
    ethBalance = await _blockchainService.getEthBalance(_userAddress);
    notifyListeners();
  }

  // Connect to blockchain - only called when needed
  Future<bool> connectToBlockchain() async {
    if (_isBlockchainConnected) return true;

    try {
      _isBlockchainLoading = true;
      notifyListeners();

      _isBlockchainConnected = await _blockchainService.initBlockchain();

      if (_isBlockchainConnected) {
        await fetchEthBalance();
      }

      _isBlockchainLoading = false;
      notifyListeners();
      return _isBlockchainConnected;
    } catch (e) {
      _error = 'Failed to connect to blockchain: $e';
      _isBlockchainLoading = false;
      _isBlockchainConnected = false;
      notifyListeners();
      return false;
    }
  }

  // Fetch products
  Future<void> fetchProducts() async {
    try {
      _allProducts = await _blockchainService.getProducts();
      _applyFilter();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to fetch products: $e';
      notifyListeners();
    }
  }

  // Filter products by category
  void filterByCategory(ProductCategory? category) {
    _selectedCategory = category;
    _applyFilter();
    notifyListeners();
  }

  // Internal method to apply the category filter
  void _applyFilter() {
    if (_selectedCategory == null) {
      _filteredProducts = List.from(_allProducts);
    } else {
      _filteredProducts = _allProducts
          .where((product) => product.category == _selectedCategory)
          .toList();
    }
  }

  // Purchase a product with ETH
  Future<PurchaseResult> purchaseProduct(Product product, bool useEth) async {
    try {
      _isBlockchainLoading = true;
      notifyListeners();

      // Try to connect to blockchain first
      final connected = await connectToBlockchain();

      // Make purchase
      final result = await _blockchainService.purchaseProduct(
        product.id,
        product.ethPrice,
        _userAddress,
      );

      // If successful, save transaction to Firebase
      // if (result.success) {
      //   await _transactionService.saveTransaction(
      //     userAddress: _userAddress,
      //     productName: product.name,
      //     ethAmount: product.ethPrice,
      //     txHash: result.txHash!,
      //     description: 'Purchased ${product.name} for ${product.ethPrice} ETH',
      //   );
      // }

      // If connected successfully, refresh balance
      if (connected) {
        await fetchEthBalance();
      }

      _isBlockchainLoading = false;
      notifyListeners();

      return result;
    } catch (e) {
      _error = 'Purchase failed: $e';
      _isBlockchainLoading = false;
      notifyListeners();
      return PurchaseResult(
        success: false,
        message: 'Error: $e',
        mockMode: true
      );
    }
  }
}
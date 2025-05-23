
import 'package:flutter/material.dart';
import '../core/models/product.dart';
import '../core/enum/product_category.dart';
import '../core/services/blockchain_service.dart';

class ProductViewModel extends ChangeNotifier {
  final BlockchainService _blockchainService;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String _error = '';
  ProductCategory? _selectedCategory;
  BigInt _userBalance = BigInt.zero;
  bool _isBlockchainConnected = false;
  bool _isBlockchainLoading = false;
  double ethBalance = 0;

  // Use a default address for testing
  String _userAddress = '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266';

  ProductViewModel({required BlockchainService blockchainService})
      : _blockchainService = blockchainService;

  // Getters
  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  bool get isBlockchainLoading => _isBlockchainLoading;
  bool get isBlockchainConnected => _isBlockchainConnected;
  String get error => _error;
  ProductCategory? get selectedCategory => _selectedCategory;
  BigInt get userBalance => _userBalance;
  String get userAddress => _userAddress;

  // Initialize the view model - just load products, don't connect to blockchain
  Future<void> init() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      // Just fetch products (these are hardcoded)
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

  // Add this method to fetch the balance
  Future<void> fetchEthBalance() async {
    final blockchainService = BlockchainService();
    ethBalance = await blockchainService.getEthBalance(_userAddress);
    notifyListeners();
  }

  // Connect to blockchain - only called when needed
  Future<bool> connectToBlockchain() async {
    if (_isBlockchainConnected) return true;

    try {
      _isBlockchainLoading = true;
      notifyListeners();

      // Try to init blockchain and get balance
      _isBlockchainConnected = await _blockchainService.initBlockchain();

      if (_isBlockchainConnected) {
        await fetchUserBalance();
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

  // Fetch the user's FIT token balance
  Future<void> fetchUserBalance() async {
    try {
      _userBalance = await _blockchainService.getBalance(_userAddress);
      notifyListeners();
    } catch (e) {
      print('Error fetching balance: $e');
      // Don't update error message for balance issues
    }
  }

  // Fetch products (hardcoded data)
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

  // Purchase a product using either ETH or FIT tokens
  Future<PurchaseResult> purchaseProduct(Product product, bool useEth) async {
    try {
      _isBlockchainLoading = true;
      notifyListeners();

      // Try to connect to blockchain first
      final connected = await connectToBlockchain();

      PurchaseResult result;
      if (useEth) {
        // Purchase with ETH
        result = await _blockchainService.purchaseProduct(
            product.id,
            product.ethPrice,
            _userAddress,
        );
      } else {
        // Purchase with FIT tokens
        result = await _blockchainService.redeemReward(_userAddress, product.id);
      }

      // If connected successfully, refresh balance
      if (connected) {
        await fetchUserBalance();
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

  // For development/testing - add FIT tokens to the user's account
  // Future<PurchaseResult> mintTestTokens() async {
  //   try {
  //     _isBlockchainLoading = true;
  //     notifyListeners();
  //
  //     // Try to connect to blockchain first
  //     await connectToBlockchain();
  //
  //     // Mint 100 FIT tokens
  //     final result = await _blockchainService.mintTokens(
  //         _userAddress,
  //         BigInt.parse('100000000000000000000') // 100 tokens with 18 decimals
  //     );
  //
  //     // If minting was successful, update the balance
  //     if (result.success) {
  //       if (result.mockMode && result.mockAmount != null) {
  //         // In mock mode, just add the minted amount to the current balance
  //         _userBalance += result.mockAmount!;
  //       } else {
  //         // In real mode, fetch the updated balance
  //         await fetchUserBalance();
  //       }
  //     }
  //
  //     _isBlockchainLoading = false;
  //     notifyListeners();
  //
  //     return result;
  //   } catch (e) {
  //     _error = 'Failed to mint tokens: $e';
  //     _isBlockchainLoading = false;
  //     notifyListeners();
  //     return PurchaseResult(
  //         success: false,
  //         message: 'Error: $e',
  //         mockMode: true
  //     );
  //   }
  // }
  Future<PurchaseResult> mintTestTokens() async {
    try {
      _isBlockchainLoading = true;
      notifyListeners();

      // Check if user is owner
      bool isUserOwner = await _blockchainService.isOwner(_userAddress);
      if (!isUserOwner) {
        _isBlockchainLoading = false;
        notifyListeners();
        return PurchaseResult(
            success: false,
            message: 'Only contract owner can mint tokens',
            mockMode: false
        );
      }

      // Try to connect to blockchain first
      await connectToBlockchain();

      // Mint 100 FIT tokens
      final result = await _blockchainService.mintTokens(
          _userAddress,
          BigInt.parse('1000000000000000000000') // 1000 tokens with 18 decimals
      );

      // If minting was successful, update the balance
      if (result.success) {
        await Future.delayed(Duration(seconds: 2)); // Give time for blockchain to update
        await fetchUserBalance();
      }

      _isBlockchainLoading = false;
      notifyListeners();

      return result;
    } catch (e) {
      _error = 'Failed to mint tokens: $e';
      _isBlockchainLoading = false;
      notifyListeners();
      return PurchaseResult(
          success: false,
          message: 'Error: $e',
          mockMode: false
      );
    }
  }

}
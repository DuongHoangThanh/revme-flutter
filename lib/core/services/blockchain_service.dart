import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'dart:convert';
import 'dart:async';

import '../enum/product_category.dart';
import '../enum/transaction_type.dart';
import '../models/product.dart';
import '../models/transaction.dart' as tran;

class BlockchainService {
  Web3Client? _client;
  DeployedContract? _contract;
  final firestore.FirebaseFirestore _db = firestore.FirebaseFirestore.instance;

  bool _isInitialized = false;

  // Mock data for products
  final List<Product> _mockProducts = [
    Product(
      id: 1,
      name: 'Protein Shake',
      description: 'High quality protein shake for muscle recovery',
      imageUrl: 'https://dymatize.imgix.net/a/blog/ChocPeppermintProteinShake_1856x1236.jpg?ar=928%3A618&auto=format%2Ccompress&fit=crop&ixlib=php-3.1.0&s=16528de05896185ee56d4574ff411d60',
      ethPrice: BigInt.from(100000000000000000),
      isActive: true,
      category: ProductCategory.food,
    ),
    Product(
      id: 2,
      name: 'Dumbbells Set',
      description: 'Adjustable dumbbells set for home workouts',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrhgxhPsy63RNpO3KjCapgaZbPCzw0J8BYVA&s',
      ethPrice: BigInt.from(5000000000000000),
      isActive: true,
      category: ProductCategory.equipment,
    ),
    Product(
      id: 3,
      name: 'Vitamin Complex',
      description: 'Daily vitamin complex for athletes',
      imageUrl: 'https://bizweb.dktcdn.net/thumb/1024x1024/100/462/999/products/240577110-4655693474549767-2813376463094547685-n-768x768.jpg?v=1683076949843',
      ethPrice: BigInt.from(2000000000000000),
      isActive: true,
      category: ProductCategory.medicine,
    ),
    Product(
      id: 4,
      name: 'Yoga Mat',
      description: 'Premium non-slip yoga mat',
      imageUrl: 'https://cdn.thewirecutter.com/wp-content/media/2024/07/yoga-mat-2048px-1633-2x1-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      ethPrice: BigInt.from(3000000000000000),
      isActive: true,
      category: ProductCategory.equipment,
    ),
    Product(
      id: 5,
      name: 'Energy Bar',
      description: 'Nutritious energy bar with nuts and dried fruits',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeqA9-_GzIUh6kkNJF91p1JWbvMcFEeGXBKQ&s',
      ethPrice: BigInt.from(500000000000000),
      isActive: true,
      category: ProductCategory.food,
    ),
    Product(
      id: 6,
      name: 'Omega-3 Supplements',
      description: 'High-quality fish oil supplements',
      imageUrl: 'https://product.hstatic.net/200000713511/product/fish-oil-natural-made-300-vien_00f5522296424117b6681a159172f4e5.jpg',
      ethPrice: BigInt.from(1500000000000000),
      isActive: true,
      category: ProductCategory.medicine,
    ),
  ];

  BlockchainService();

  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts;
  }

  Future<bool> initBlockchain() async {
    if (_isInitialized) return true;

    try {
      print("Initializing blockchain connection...");

      const String blockchainUrl = 'http://192.168.1.119:8545'; // Change to your Ganache URL
      _client = Web3Client(blockchainUrl, http.Client());

      // Test connection with timeout - show a more detailed error message
      try {
        final networkId = await _client!.getNetworkId().timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            throw TimeoutException("Connection to blockchain at $blockchainUrl timed out");
          },
        );
        print("Connected to blockchain network with ID: $networkId");
      } catch (e) {
        print("Failed to connect to blockchain: $e");
        return false;
      }

      try {
        await _initContract();
        _isInitialized = true;
        print("Blockchain connection initialized successfully");
        return true;
      } catch (e) {
        print("Failed to initialize contract: $e");
        return false;
      }
    } catch (e) {
      print('Failed to initialize blockchain: $e');
      _isInitialized = false;
      return false;
    }
  }

  Future<bool> isOwner(String userAddress) async {
    if (_contract == null || _client == null) {
      await initBlockchain();
    }

    try {
      final owner = await _client!.call(
        contract: _contract!,
        function: _contract!.function('owner'),
        params: [],
      );

      String ownerAddress = (owner.first as EthereumAddress).hex;
      return ownerAddress.toLowerCase() == userAddress.toLowerCase();
    } catch (e) {
      print('Error checking owner: $e');
      return false;
    }
  }

  Future<void> _initContract() async {
    try {
      String jsonString = await rootBundle.loadString('assets/fitness_token_abi.json');
      final jsonData = jsonDecode(jsonString);
      final abi = jsonData['abi'];

      // Contract address after deployment
      String contractAddress = "0xcBD8aFaC84Cd50B36ABA254969a6541c8d66dBC8";

      _contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(abi), 'FitnessToken'),
        EthereumAddress.fromHex(contractAddress),
      );

      // Only initialize functions that exist in the contract
      final functions = _contract!.abi.functions;
      print("Available functions in contract: ${functions.map((f) => f.name).toList()}");
    } catch (e) {
      print('Error initializing contract: $e');
      rethrow;
    }
  }

  // Add this method to your BlockchainService class
  Future<double> getEthBalance(String address) async {
    if (!await initBlockchain()) {
      return 0.0; // Return zero if can't connect
    }

    try {
      final balance = await _client!.getBalance(EthereumAddress.fromHex(address));

      // Convert from wei to ether for a readable format
      final etherValue = balance.getValueInUnit(EtherUnit.ether);
      print('HHH ETH balance: $etherValue');

      // Trả về dạng double
      return double.parse(etherValue.toStringAsFixed(6));
    } catch (e) {
      print('Error getting ETH balance: $e');
      return 0.0; // Return zero on error
    }
  }

  // Simulate purchase with ETH and save to Firebase
  Future<PurchaseResult> purchaseProduct(int productId, BigInt ethAmount, String userAddress) async {
    // First try to connect to blockchain
    if (!await initBlockchain()) {
      return PurchaseResult(
          success: false,
          message: "Cannot connect to blockchain service",
          mockMode: true
      );
    }

    try {
      const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
      final credentials = EthPrivateKey.fromHex(privateKey);

      // Find product details
      final product = _mockProducts.firstWhere((p) => p.id == productId);

      final txHash = await _client!.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex('0x70997970C51812dc3A010C7d01b50e0d17dc79C8'),
          value: EtherAmount.fromBigInt(EtherUnit.wei, ethAmount),
        ),
        chainId: 1337,
      ).timeout(const Duration(seconds: 10));

      // Save transaction to Firebase
      await saveTransaction(
        userAddress: userAddress,
        productName: product.name,
        ethAmount: ethAmount,
        txHash: txHash,
        description: 'Purchase: ${product.name}',
      );

      return PurchaseResult(
          success: true,
          message: "Purchase successful! Transaction: ${txHash.substring(0, 10)}...",
          txHash: txHash
      );

    } catch (e) {
      print('Error purchasing product: $e');

      // If blockchain fails, create a mock transaction
      final product = _mockProducts.firstWhere((p) => p.id == productId);
      final mockTxHash = 'mock_${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}';

      // Save mock transaction to Firebase
      await saveTransaction(
        userAddress: userAddress,
        productName: product.name,
        ethAmount: ethAmount,
        txHash: mockTxHash,
        description: 'Purchase: ${product.name} (Mock)',
      );

      return PurchaseResult(
          success: true,
          message: "Purchase completed in mock mode",
          txHash: mockTxHash,
          mockMode: true
      );
    }
  }

  // Save transaction to Firebase
  Future<void> saveTransaction({
    required String userAddress,
    required String productName,
    required BigInt ethAmount,
    required String txHash,
    required String description,
  }) async {
    try {
      await _db.collection('transactions').add({
        'userAddress': userAddress,
        'productName': productName,
        'ethAmount': ethAmount.toString(),
        'txHash': txHash,
        'description': description,
        'timestamp': firestore.FieldValue.serverTimestamp(),
        'type': 'purchase',
      });
      print('Transaction saved to Firebase successfully');
    } catch (e) {
      print('Error saving transaction to Firebase: $e');
    }
  }

  // Get user's transaction history
  Future<List<tran.TransactionItem>> getUserTransactions(String userAddress) async {
    try {
      final snapshot = await _db
          .collection('transactions')
          .where('userAddress', isEqualTo: userAddress)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return tran.TransactionItem(
          id: doc.id,
          timestamp: data['timestamp'] != null
              ? (data['timestamp'] as firestore.Timestamp).toDate()
              : DateTime.now(),
          type: TransactionType.purchase,
          description: data['description'] ?? '',
          ethAmount: BigInt.parse(data['ethAmount'] ?? '0'),
          productName: data['productName'],
          txHash: data['txHash'],
          isPositive: false, userAddress: userAddress,
        );
      }).toList();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }
}

class PurchaseResult {
  final bool success;
  final String message;
  final String? txHash;
  final bool mockMode;

  PurchaseResult({
    required this.success,
    required this.message,
    this.txHash,
    this.mockMode = false,
  });
}
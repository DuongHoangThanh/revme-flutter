import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';

import '../enum/product_category.dart';
import '../models/product.dart';

class BlockchainService {
  Web3Client? _client;
  DeployedContract? _contract;
  ContractFunction? _mint;
  ContractFunction? _balanceOf;
  bool _isInitialized = false;

  // Mock data for products
  final List<Product> _mockProducts = [
    Product(
      id: 1,
      name: 'Protein Shake',
      description: 'High quality protein shake for muscle recovery',
      imageUrl: 'https://images.unsplash.com/photo-1594059917370-abcc813eb875',
      ethPrice: BigInt.from(1000000000000000),
      fitPrice: BigInt.parse('10000000000000000000'), // 10 FIT tokens
      isActive: true,
      category: ProductCategory.food,
    ),
    Product(
      id: 2,
      name: 'Dumbbells Set',
      description: 'Adjustable dumbbells set for home workouts',
      imageUrl: 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2',
      ethPrice: BigInt.from(5000000000000000),
      fitPrice: BigInt.parse('50000000000000000000'), // 50 FIT tokens
      isActive: true,
      category: ProductCategory.equipment,
    ),
    Product(
      id: 3,
      name: 'Vitamin Complex',
      description: 'Daily vitamin complex for athletes',
      imageUrl: 'https://images.unsplash.com/photo-1584308074727-e93dca1a2697',
      ethPrice: BigInt.from(2000000000000000),
      fitPrice: BigInt.parse('20000000000000000000'), // 20 FIT tokens
      isActive: true,
      category: ProductCategory.medicine,
    ),
    Product(
      id: 4,
      name: 'Yoga Mat',
      description: 'Premium non-slip yoga mat',
      imageUrl: 'https://images.unsplash.com/photo-1592432678016-e910b452f9a2',
      ethPrice: BigInt.from(3000000000000000),
      fitPrice: BigInt.parse('30000000000000000000'), // 30 FIT tokens
      isActive: true,
      category: ProductCategory.equipment,
    ),
    Product(
      id: 5,
      name: 'Energy Bar',
      description: 'Nutritious energy bar with nuts and dried fruits',
      imageUrl: 'https://images.unsplash.com/photo-1569544187391-5a80c94b9976',
      ethPrice: BigInt.from(500000000000000),
      fitPrice: BigInt.from(5000000000000000000), // 5 FIT tokens
      isActive: true,
      category: ProductCategory.food,
    ),
    Product(
      id: 6,
      name: 'Omega-3 Supplements',
      description: 'High-quality fish oil supplements',
      imageUrl: 'https://images.unsplash.com/photo-1577308856961-8e9ec5a88d8e',
      ethPrice: BigInt.from(1500000000000000),
      fitPrice: BigInt.parse('15000000000000000000'), // 15 FIT tokens
      isActive: true,
      category: ProductCategory.medicine,
    ),
  ];

  BlockchainService();

  // Get products - no blockchain required
  Future<List<Product>> getProducts() async {
    // Simulate network delay for realism
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts;
  }

  // Initialize blockchain connection only when needed
  // Add these improvements to your existing code:

// In the initBlockchain method, change the IP address to be configurable:
  Future<bool> initBlockchain() async {
    if (_isInitialized) return true;

    try {
      print("Initializing blockchain connection...");

      // Use a configurable blockchain URL - this could be moved to a config file later
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
  Future<PurchaseResult> mintTokens(String userAddress, BigInt amount) async {
    try {
      // Sử dụng private key của owner contract
      const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80'; // Private key của account #0 từ Hardhat
      final credentials = EthPrivateKey.fromHex(privateKey);

      final txHash = await _client!.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: _contract!,
          function: _mint!,
          parameters: [EthereumAddress.fromHex(userAddress), amount],
        ),
        chainId: 1337, // Đảm bảo đúng chainId
      );

      // Chờ một chút để transaction được xử lý
      await Future.delayed(Duration(seconds: 2));

      return PurchaseResult(
        success: true,
        message: 'Successfully minted $amount FIT tokens',
        txHash: txHash,
        mockMode: false,
      );
    } catch (e) {
      print('Error minting token: $e');
      return PurchaseResult(
        success: false,
        message: 'Failed to mint tokens: $e',
        mockMode: false,
      );
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
// Update the mint tokens function to handle errors better:
//   Future<PurchaseResult> mintTokens(String userAddress, BigInt amount) async {
//     // First try to connect to blockchain
//     if (!await initBlockchain()) {
//       return PurchaseResult(
//           success: true, // Changed to true since we want the UI to update in mock mode
//           message: "Cannot connect to blockchain. Minted tokens in mock mode.",
//           mockMode: true,
//           mockAmount: amount
//       );
//     }
//
//     try {
//       if (_mint == null) {
//         print("Mint function not available in contract");
//         return PurchaseResult(
//             success: true,
//             message: "Mint function not found in contract. Minted tokens in mock mode.",
//             mockMode: true,
//             mockAmount: amount
//         );
//       }
//
//       const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
//       final credentials = EthPrivateKey.fromHex(privateKey);
//
//       print("Attempting to mint $amount tokens to $userAddress");
//       final txHash = await _client!.sendTransaction(
//         credentials,
//         Transaction.callContract(
//           contract: _contract!,
//           function: _mint!,
//           parameters: [
//             EthereumAddress.fromHex(userAddress),
//             amount,
//           ],
//         ),
//         // chainId: 5777,
//         chainId: 1337,
//       ).timeout(const Duration(seconds: 10));
//
//       print("Mint transaction submitted: $txHash");
//
//       return PurchaseResult(
//           success: true,
//           message: "Tokens minted successfully!",
//           txHash: txHash
//       );
//     } catch (e) {
//       print('Error minting tokens: $e');
//
//       // Return mock success for testing with more detailed message
//       return PurchaseResult(
//           success: true,
//           message: "Tokens minted in mock mode (blockchain error: ${e.toString().split('\n')[0]})",
//           mockMode: true,
//           mockAmount: amount
//       );
//     }
//   }

  Future<void> _initContract() async {
    try {
      String jsonString = await rootBundle.loadString('assets/fitness_token_abi.json');
      final jsonData = jsonDecode(jsonString);
      final abi = jsonData['abi'];

      // Contract address after deployment
      String contractAddress = "0x95E11D44bE1a3014C7279cFAC7C4eBfc60FC8b23";

      _contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(abi), 'FitnessToken'),
        EthereumAddress.fromHex(contractAddress),
      );

      // Only initialize functions that exist in the contract
      final functions = _contract!.abi.functions;
      print("Available functions in contract: ${functions.map((f) => f.name).toList()}");

      if (functions.any((f) => f.name == 'mint')) {
        _mint = _contract!.function('mint');
      }

      if (functions.any((f) => f.name == 'balanceOf')) {
        _balanceOf = _contract!.function('balanceOf');
      }
    } catch (e) {
      print('Error initializing contract: $e');
      rethrow;
    }
  }

  // Get FIT token balance
  Future<BigInt> getBalance(String address) async {
    if (!await initBlockchain()) {
      return BigInt.zero; // Return zero if can't connect
    }

    try {
      if (_balanceOf == null) {
        return BigInt.zero;
      }

      final result = await _client!.call(
        contract: _contract!,
        function: _balanceOf!,
        params: [EthereumAddress.fromHex(address)],
      ).timeout(const Duration(seconds: 5));

      return result.first as BigInt;
    } catch (e) {
      print('Error getting balance: $e');
      return BigInt.zero; // Return zero on error
    }
  }

  // Simulate purchase with ETH (mock implementation)
  Future<PurchaseResult> purchaseProduct(int productId, BigInt ethAmount) async {
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

      final txHash = await _client!.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex('0x70997970C51812dc3A010C7d01b50e0d17dc79C8'),
          value: EtherAmount.fromBigInt(EtherUnit.wei, ethAmount),
        ),
        chainId: 1337,
        // chainId: 5777,
      ).timeout(const Duration(seconds: 10));

      return PurchaseResult(
          success: true,
          message: "Purchase successful! Transaction: ${txHash.substring(0, 10)}...",
          txHash: txHash
      );
    } catch (e) {
      print('Error purchasing product: $e');

      // If blockchain fails, return mock success for testing
      return PurchaseResult(
          success: true,
          message: "Purchase completed in mock mode",
          mockMode: true
      );
    }
  }

  // Simulate FIT token redemption
  Future<PurchaseResult> redeemReward(String userAddress, int productId) async {
    // First try to connect to blockchain
    if (!await initBlockchain()) {
      return PurchaseResult(
          success: false,
          message: "Cannot connect to blockchain service",
          mockMode: true
      );
    }

    try {
      final product = _mockProducts.firstWhere((p) => p.id == productId);
      const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
      final credentials = EthPrivateKey.fromHex(privateKey);

      final transferFunc = _contract!.function('transfer');
      final txHash = await _client!.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: _contract!,
          function: transferFunc,
          parameters: [
            EthereumAddress.fromHex('0x70997970C51812dc3A010C7d01b50e0d17dc79C8'),
            product.fitPrice,
          ],
        ),
        chainId: 5777,
      ).timeout(const Duration(seconds: 10));

      return PurchaseResult(
          success: true,
          message: "Redemption successful! Transaction: ${txHash.substring(0, 10)}...",
          txHash: txHash
      );
    } catch (e) {
      print('Error redeeming product: $e');

      // If blockchain fails, return mock success for testing
      return PurchaseResult(
          success: true,
          message: "Redemption completed in mock mode",
          mockMode: true
      );
    }
  }

}

class PurchaseResult {
  final bool success;
  final String message;
  final String? txHash;
  final bool mockMode;
  final BigInt? mockAmount;

  PurchaseResult({
    required this.success,
    required this.message,
    this.txHash,
    this.mockMode = false,
    this.mockAmount,
  });
}
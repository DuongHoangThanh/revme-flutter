import 'package:rev_me_app/data/local/local_product.dart';
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
  final List<Product> _mockProducts = LocalProduct().getProducts();

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
        'formattedEthAmount': formatEtherAmount(ethAmount), // Thêm giá trị đã định dạng
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
        final BigInt ethAmount = BigInt.parse(data['ethAmount'] ?? '0');
        
        return tran.TransactionItem(
          id: doc.id,
          timestamp: data['timestamp'] != null
              ? (data['timestamp'] as firestore.Timestamp).toDate()
              : DateTime.now(),
          type: TransactionType.purchase,
          description: data['description'] ?? '',
          ethAmount: ethAmount,
          formattedAmount: data['formattedEthAmount'] ?? formatEtherAmount(ethAmount),
          productName: data['productName'],
          txHash: data['txHash'],
          isPositive: false, 
          userAddress: userAddress,
        );
      }).toList();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }

  // Định dạng số lượng ETH từ wei thành đơn vị ETH dễ đọc
  String formatEtherAmount(BigInt weiAmount) {
    // Chuyển đổi wei thành ether (1 ETH = 10^18 wei)
    final etherValue = weiAmount / BigInt.from(10).pow(18);
    
    // Làm tròn thành số thập phân dễ đọc
    if (etherValue < 0.0001) {
      return "< 0.0001 ETH";
    } else if (etherValue < 0.001) {
      return "${etherValue.toStringAsFixed(5)} ETH";
    } else if (etherValue < 0.01) {
      return "${etherValue.toStringAsFixed(4)} ETH";
    } else {
      return "${etherValue.toStringAsFixed(3)} ETH";
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
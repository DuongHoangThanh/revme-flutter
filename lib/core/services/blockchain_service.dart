
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
  ContractFunction? _addMinter;
  ContractFunction? _mineTokens;

  bool _isInitialized = false;
  // final FirebaseService _firebaseService = FirebaseService();

  // Mock data for products
  final List<Product> _mockProducts = [
    Product(
      id: 1,
      name: 'Protein Shake',
      description: 'High quality protein shake for muscle recovery',
      imageUrl: 'https://dymatize.imgix.net/a/blog/ChocPeppermintProteinShake_1856x1236.jpg?ar=928%3A618&auto=format%2Ccompress&fit=crop&ixlib=php-3.1.0&s=16528de05896185ee56d4574ff411d60',
      ethPrice: BigInt.from(100000000000000000),
      fitPrice: BigInt.parse('10000000000000000000'), // 10 FIT tokens
      isActive: true,
      category: ProductCategory.food,
    ),
    Product(
      id: 2,
      name: 'Dumbbells Set',
      description: 'Adjustable dumbbells set for home workouts',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrhgxhPsy63RNpO3KjCapgaZbPCzw0J8BYVA&s',
      ethPrice: BigInt.from(5000000000000000),
      fitPrice: BigInt.parse('50000000000000000000'), // 50 FIT tokens
      isActive: true,
      category: ProductCategory.equipment,
    ),
    Product(
      id: 3,
      name: 'Vitamin Complex',
      description: 'Daily vitamin complex for athletes',
      imageUrl: 'https://bizweb.dktcdn.net/thumb/1024x1024/100/462/999/products/240577110-4655693474549767-2813376463094547685-n-768x768.jpg?v=1683076949843',
      ethPrice: BigInt.from(2000000000000000),
      fitPrice: BigInt.parse('20000000000000000000'), // 20 FIT tokens
      isActive: true,
      category: ProductCategory.medicine,
    ),
    Product(
      id: 4,
      name: 'Yoga Mat',
      description: 'Premium non-slip yoga mat',
      imageUrl: 'https://cdn.thewirecutter.com/wp-content/media/2024/07/yoga-mat-2048px-1633-2x1-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      ethPrice: BigInt.from(3000000000000000),
      fitPrice: BigInt.parse('30000000000000000000'), // 30 FIT tokens
      isActive: true,
      category: ProductCategory.equipment,
    ),
    Product(
      id: 5,
      name: 'Energy Bar',
      description: 'Nutritious energy bar with nuts and dried fruits',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeqA9-_GzIUh6kkNJF91p1JWbvMcFEeGXBKQ&s',
      ethPrice: BigInt.from(500000000000000),
      fitPrice: BigInt.from(5000000000000000000), // 5 FIT tokens
      isActive: true,
      category: ProductCategory.food,
    ),
    Product(
      id: 6,
      name: 'Omega-3 Supplements',
      description: 'High-quality fish oil supplements',
      imageUrl: 'https://product.hstatic.net/200000713511/product/fish-oil-natural-made-300-vien_00f5522296424117b6681a159172f4e5.jpg',
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
      if (!await initBlockchain()) {
        return PurchaseResult(
          success: false,
          message: 'Failed to initialize blockchain',
          mockMode: false,
        );
      }

      if (_mineTokens == null) {
        print("Error: mineTokens function not found in contract");
        return PurchaseResult(
          success: false,
          message: "mineTokens function not found in contract",
          mockMode: false,
        );
      }

      // Sử dụng private key của owner contract
      const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
      final credentials = EthPrivateKey.fromHex(privateKey);

      final txHash = await _client!.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: _contract!,
          function: _mineTokens!, // Use _mineTokens instead of _mint
          parameters: [EthereumAddress.fromHex(userAddress), amount],
        ),
        chainId: 1337,
      );

      // Rest of your code remains the same
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
  // Future<PurchaseResult> mintTokens(String userAddress, BigInt amount) async {
  //   try {
  //     // Sử dụng private key của owner contract
  //     const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80'; // Private key của account #0 từ Hardhat
  //     final credentials = EthPrivateKey.fromHex(privateKey);
  //
  //     final txHash = await _client!.sendTransaction(
  //       credentials,
  //       Transaction.callContract(
  //         contract: _contract!,
  //         function: _mint!,
  //         parameters: [EthereumAddress.fromHex(userAddress), amount],
  //       ),
  //       chainId: 1337, // Đảm bảo đúng chainId
  //     );
  //
  //     // Chờ một chút để transaction được xử lý
  //     await Future.delayed(Duration(seconds: 2));
  //
  //     return PurchaseResult(
  //       success: true,
  //       message: 'Successfully minted $amount FIT tokens',
  //       txHash: txHash,
  //       mockMode: false,
  //     );
  //   } catch (e) {
  //     print('Error minting token: $e');
  //     return PurchaseResult(
  //       success: false,
  //       message: 'Failed to mint tokens: $e',
  //       mockMode: false,
  //     );
  //   }
  // }
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

      if (functions.any((f) => f.name == 'mint')) {
        _mint = _contract!.function('mint');
      }

      // Sử dụng checkBalance thay vì balanceOf
      if (functions.any((f) => f.name == 'checkBalance')) {
        _balanceOf = _contract!.function('checkBalance');
      }
      if (functions.any((f) => f.name == 'balanceOf')) {
        _balanceOf = _contract!.function('balanceOf');
      }

      if (functions.any((f) => f.name == 'addMinter')) {
        _addMinter = _contract!.function('addMinter');
      }

      if (functions.any((f) => f.name == 'mineTokens')) {
        _mineTokens = _contract!.function('mineTokens');
      }

      if (functions.any((f) => f.name == 'checkBalance')) {
        _balanceOf = _contract!.function('checkBalance');
      }
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

  // Get FIT token balance
  Future<BigInt> getBalance(String address) async {
    if (!await initBlockchain()) {
      return BigInt.zero;
    }

    try {
      // Sử dụng cách gọi JSON-RPC trực tiếp để tránh lỗi của thư viện web3dart
      // Xử lý địa chỉ
      String cleanAddress = address;
      if (cleanAddress.startsWith('0x')) {
        cleanAddress = cleanAddress.substring(2);
      }
      cleanAddress = cleanAddress.toLowerCase().padLeft(40, '0');

      // Tạo data cho JSON-RPC call với function selector của balanceOf
      final String dataField = "0x70a08231000000000000000000000000$cleanAddress";

      print("Calling balanceOf with data: $dataField");

      final response = await http.post(
        Uri.parse('http://192.168.1.119:8545'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'jsonrpc': '2.0',
          'method': 'eth_call',
          'params': [
            {
              'to': _contract!.address.hex,
              'data': dataField,
            },
            'latest'
          ],
          'id': 1,
        }),
      );

      final jsonResponse = json.decode(response.body);
      if (jsonResponse['result'] != null) {
        final String hexValue = jsonResponse['result'];
        print("Raw balance result: $hexValue");

        if (hexValue == '0x' || hexValue == '0x0') {
          return BigInt.zero;
        }

        final BigInt balance = BigInt.parse(hexValue.substring(2), radix: 16);
        print("Parsed balance: $balance wei");

        // In ra số token thực tế (chia cho 10^18)
        final double tokenBalance = balance / BigInt.from(10).pow(18);
        print("Token balance: $tokenBalance FIT");

        return balance;
      } else {
        print("JSON-RPC error: ${jsonResponse['error']}");
        return BigInt.zero;
      }
    } catch (e) {
      print('Error getting balance: $e');
      return BigInt.zero;
    }
  }

  // Simulate purchase with ETH (mock implementation)
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
  Future<PurchaseResult> addMinter(String minterAddress) async {
    if (!await initBlockchain()) {
      return PurchaseResult(
        success: false,
        message: 'Blockchain not initialized',
        mockMode: true,
      );
    }

    try {
      if (_addMinter == null) {
        return PurchaseResult(
          success: false,
          message: 'addMinter function not found in contract',
          mockMode: true,
        );
      }

      // Sử dụng private key của owner
      const privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
      final credentials = EthPrivateKey.fromHex(privateKey);

      final txHash = await _client!.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: _contract!,
          function: _addMinter!,
          parameters: [EthereumAddress.fromHex(minterAddress)],
        ),
        chainId: 1337,
      );

      return PurchaseResult(
        success: true,
        message: 'Minter added successfully',
        txHash: txHash,
      );
    } catch (e) {
      print('Error calling addMinter: $e');
      return PurchaseResult(
        success: false,
        message: 'Failed to add minter: $e',
        mockMode: true,
      );
    }
  }
  Future<void> testBalance(String address) async {
    try {
      print("Testing balance for address: $address");

      if (!address.startsWith('0x')) {
        address = '0x$address';
      }

      final balance = await getBalance(address);
      final tokenAmount = balance / BigInt.from(10).pow(18);

      print("==========================================");
      print("Address: $address");
      print("Balance: $balance wei");
      print("Token amount: $tokenAmount FIT");
      print("==========================================");
    } catch (e) {
      print("Error in testBalance: $e");
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
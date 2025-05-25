import '../enum/transaction_type.dart';

class TransactionItem {
  final String id;
  final DateTime timestamp;
  final TransactionType type;
  final String description;
  final BigInt ethAmount;
  final String? productName;
  final String? txHash;
  final bool isPositive;
  final String userAddress;

  TransactionItem({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.description,
    required this.ethAmount,
    this.productName,
    this.txHash,
    required this.isPositive,
    required this.userAddress,
  });

  // Factory constructor for creating a purchase transaction
  factory TransactionItem.purchase({
    required String id,
    required DateTime timestamp,
    required String description,
    required BigInt ethAmount,
    required String productName,
    required String txHash,
    required String userAddress,
  }) {
    return TransactionItem(
      id: id,
      timestamp: timestamp,
      type: TransactionType.purchase,
      description: description,
      ethAmount: ethAmount,
      productName: productName,
      txHash: txHash,
      isPositive: false, // Purchase is always spending
      userAddress: userAddress,
    );
  }
}
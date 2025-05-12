import 'package:web3dart/web3dart.dart';
import '../enum/transaction_type.dart';

class TransactionItem {
  final String id;
  final DateTime timestamp;
  final TransactionType type;
  final String description;
  final BigInt? tokenAmount;
  final BigInt? ethAmount;
  final String? productName;
  final String? txHash;
  final bool isPositive;

  TransactionItem({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.description,
    this.tokenAmount,
    this.ethAmount,
    this.productName,
    this.txHash,
    required this.isPositive,
  });
}
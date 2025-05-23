import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction.dart';
import '../enum/transaction_type.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveTransaction(TransactionItem transaction) async {
    try {
      await _firestore.collection('transactions').doc(transaction.id).set({
        'id': transaction.id,
        'timestamp': transaction.timestamp,
        'type': transaction.type.toString(),
        'description': transaction.description,
        'ethAmount': transaction.ethAmount?.toString(),
        'tokenAmount': transaction.tokenAmount?.toString(),
        'productName': transaction.productName,
        'txHash': transaction.txHash,
        'isPositive': transaction.isPositive,
        'userAddress': transaction.userAddress,
      });
    } catch (e) {
      print('Error saving transaction: $e');
      throw e;
    }
  }

  Future<List<TransactionItem>> getTransactionsByUser(String userAddress) async {
    try {
      final snapshot = await _firestore
          .collection('transactions')
          .where('userAddress', isEqualTo: userAddress)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return TransactionItem(
          id: data['id'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          type: _parseTransactionType(data['type']),
          description: data['description'],
          ethAmount: data['ethAmount'] != null
              ? BigInt.parse(data['ethAmount'])
              : null,
          tokenAmount: data['tokenAmount'] != null
              ? BigInt.parse(data['tokenAmount'])
              : null,
          productName: data['productName'],
          txHash: data['txHash'],
          isPositive: data['isPositive'],
          userAddress: data['userAddress'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }

  TransactionType _parseTransactionType(String type) {
    if (type.contains('purchase')) return TransactionType.purchase;
    if (type.contains('redemption')) return TransactionType.redemption;
    if (type.contains('checkIn')) return TransactionType.checkIn;
    return TransactionType.reward;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveTransaction(TransactionItem transaction) async {
    try {
      await _firestore.collection('transactions').doc(transaction.id).set({
        'id': transaction.id,
        'timestamp': transaction.timestamp,
        'type': transaction.type.toString(),
        'description': transaction.description,
        'ethAmount': transaction.ethAmount.toString(),
        // 'tokenAmount': transaction.tokenAmount?.toString(),
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

  Future<List<TransactionItem>> getUserTransactions(String userAddress) async {
    try {
      final snapshot = await _firestore
          .collection('transactions')
          .where('userAddress', isEqualTo: userAddress)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return TransactionItem.purchase(
          id: doc.id,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          description: data['description'] as String,
          ethAmount: BigInt.parse(data['ethAmount'] as String),
          productName: data['productName'] as String,
          txHash: data['txHash'] as String,
          userAddress: data['userAddress'] as String,
        );
      }).toList();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }
}
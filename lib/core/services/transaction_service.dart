import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web3dart/web3dart.dart';
import '../enum/transaction_type.dart';
import '../models/transaction.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveTransaction({
    required String userAddress,
    required String productName,
    required BigInt ethAmount,
    required String txHash,
    required String description,
  }) async {
    try {
      await _firestore.collection('transactions').add({
        'userAddress': userAddress,
        'productName': productName,
        'ethAmount': ethAmount.toString(),
        'txHash': txHash,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'purchase',
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
        return TransactionItem(
          id: doc.id,
          userAddress: data['userAddress'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          type: TransactionType.purchase,
          description: data['description'],
          ethAmount: BigInt.parse(data['ethAmount']),
          productName: data['productName'],
          txHash: data['txHash'],
          isPositive: false,
        );
      }).toList();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }
}

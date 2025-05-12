import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../core/models/transaction.dart';
import '../core/enum/transaction_type.dart';

class TransactionHistoryViewModel extends ChangeNotifier {
  final List<TransactionItem> _transactions = [];
  List<TransactionItem> _filteredTransactions = [];
  bool _isLoading = true;

  TransactionType? _selectedType;
  String _searchTerm = '';

  TransactionHistoryViewModel() {
    _loadTransactions();
  }

  List<TransactionItem> get transactions => _transactions;
  List<TransactionItem> get filteredTransactions => _filteredTransactions;
  bool get isLoading => _isLoading;
  TransactionType? get selectedType => _selectedType;

  Future<void> _loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      // This would normally load from storage, an API, or blockchain
      // For demo, we'll add some mock transactions
      await Future.delayed(const Duration(seconds: 1));

      final now = DateTime.now();

      _transactions.addAll([
        TransactionItem(
          id: '1',
          timestamp: now.subtract(const Duration(minutes: 30)),
          type: TransactionType.purchase,
          description: 'Purchase with ETH',
          ethAmount: BigInt.from(5000000000000000),
          productName: 'Dumbbells Set',
          txHash: '0x1234567890abcdef1234567890abcdef12345678',
          isPositive: false,
        ),
        TransactionItem(
          id: '2',
          timestamp: now.subtract(const Duration(hours: 2)),
          type: TransactionType.redemption,
          description: 'Redeemed with FIT tokens',
          tokenAmount: BigInt.parse('20000000000000000000'), // 20 FIT
          productName: 'Protein Shake',
          txHash: '0xabcdef1234567890abcdef1234567890abcdef12',
          isPositive: false,
        ),
        TransactionItem(
          id: '3',
          timestamp: now.subtract(const Duration(hours: 6)),
          type: TransactionType.checkIn,
          description: 'Daily check-in reward',
          tokenAmount: BigInt.parse('5000000000000000000'), // 5 FIT
          txHash: '0x7890abcdef1234567890abcdef1234567890abcd',
          isPositive: true,
        ),
        TransactionItem(
          id: '4',
          timestamp: now.subtract(const Duration(days: 1)),
          type: TransactionType.reward,
          description: 'Completed workout challenge',
          tokenAmount: BigInt.parse('15000000000000000000'), // 15 FIT
          txHash: '0xdef1234567890abcdef1234567890abcdef12345',
          isPositive: true,
        ),
        TransactionItem(
          id: '5',
          timestamp: now.subtract(const Duration(days: 2)),
          type: TransactionType.purchase,
          description: 'Purchase with ETH',
          ethAmount: BigInt.from(3000000000000000),
          productName: 'Yoga Mat',
          txHash: '0x567890abcdef1234567890abcdef1234567890ab',
          isPositive: false,
        ),
        TransactionItem(
          id: '6',
          timestamp: now.subtract(const Duration(days: 2, hours: 5)),
          type: TransactionType.checkIn,
          description: 'Daily check-in reward',
          tokenAmount: BigInt.parse('5000000000000000000'), // 5 FIT
          txHash: '0x90abcdef1234567890abcdef1234567890abcdef',
          isPositive: true,
        ),
      ]);

      _applyFilters();
    } catch (e) {
      print('Error loading transactions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterByType(TransactionType? type) {
    _selectedType = type;
    _applyFilters();
    notifyListeners();
  }

  void filterBySearchTerm(String term) {
    _searchTerm = term.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredTransactions = _transactions.where((transaction) {
      // Apply type filter
      if (_selectedType != null && transaction.type != _selectedType) {
        return false;
      }

      // Apply search filter
      if (_searchTerm.isNotEmpty) {
        final description = transaction.description.toLowerCase();
        final productName = transaction.productName?.toLowerCase() ?? '';

        if (!description.contains(_searchTerm) && !productName.contains(_searchTerm)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  List<MapEntry<DateTime, List<TransactionItem>>> groupTransactionsByDate() {
    // Group transactions by day (ignoring time)
    final grouped = groupBy<TransactionItem, DateTime>(
      _filteredTransactions,
          (transaction) => DateTime(
        transaction.timestamp.year,
        transaction.timestamp.month,
        transaction.timestamp.day,
      ),
    );

    // Sort by date (most recent first)
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return sortedKeys.map((date) => MapEntry(date, grouped[date]!)).toList();
  }
}
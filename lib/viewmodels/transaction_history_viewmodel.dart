import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../core/models/transaction.dart';
import '../core/enum/transaction_type.dart';
import '../core/services/transaction_service.dart';
import '../core/services/user_preferences_service.dart';

class TransactionHistoryViewModel extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  final List<TransactionItem> _transactions = [];
  List<TransactionItem> _filteredTransactions = [];
  bool _isLoading = true;
  TransactionType? _selectedType;
  String _searchTerm = '';
  String _userAddress = '';

  TransactionHistoryViewModel() {
    _getUserAddress();
    loadUserAddress();
  }
  void loadUserAddress() async {
    String? address = await UserPreferencesService.getWalletAddress();
    _userAddress = address ?? '';
    print('User address loaded: $_userAddress');
    notifyListeners();
  }


  List<TransactionItem> get transactions => _transactions;
  List<TransactionItem> get filteredTransactions => _filteredTransactions;
  bool get isLoading => _isLoading;
  TransactionType? get selectedType => _selectedType;

  Future<void> _loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch transactions from Firebase
      final transactions = await _transactionService.getUserTransactions(_userAddress);
      _transactions.clear();
      _transactions.addAll(transactions);
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
        final txHash = transaction.txHash?.toLowerCase() ?? '';

        return description.contains(_searchTerm) || 
               productName.contains(_searchTerm) ||
               txHash.contains(_searchTerm);
      }

      return true;
    }).toList();

    // Sort by timestamp (most recent first)
    _filteredTransactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));
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

  // Refresh transactions (can be called after new purchases)
  Future<void> refreshTransactions() async {
    await _loadTransactions();
  }

  // Lấy địa chỉ ví người dùng từ SharedPreferences
  Future<void> _getUserAddress() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final address = await UserPreferencesService.getWalletAddress();
      if (address != null && address.isNotEmpty) {
        _userAddress = address;
      }
      
      // Sau khi lấy được địa chỉ ví, tiếp tục tải lịch sử giao dịch
      await _loadTransactions();
    } catch (e) {
      print('Error getting user wallet address: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
}
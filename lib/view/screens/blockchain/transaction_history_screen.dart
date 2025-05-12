import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/enum/transaction_type.dart';
import '../../../core/models/transaction.dart';
import '../../../themes/colors.dart';
import '../../../viewmodels/transaction_history_viewmodel.dart';

class TransactionHistoryScreen extends StatelessWidget {
  static const String id = 'transaction_history_screen';

  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionHistoryViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Transaction History',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Consumer<TransactionHistoryViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.transactions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.receipt_long,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No Transactions Yet',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your transaction history will\nappear here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Search and filter section
                _buildFilters(context, viewModel),

                // Transactions list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: viewModel.filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final groupedTransactions =
                      viewModel.groupTransactionsByDate();

                      if (index < groupedTransactions.length) {
                        final dateGroup = groupedTransactions[index];
                        return _buildTransactionGroup(context, dateGroup.key, dateGroup.value);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context, TransactionHistoryViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search bar
          TextField(
            onChanged: viewModel.filterBySearchTerm,
            decoration: InputDecoration(
              hintText: 'Search transactions',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 16),

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip(
                  label: 'All',
                  isSelected: viewModel.selectedType == null,
                  onTap: () => viewModel.filterByType(null),
                ),
                _filterChip(
                  label: 'Purchase',
                  isSelected: viewModel.selectedType == TransactionType.purchase,
                  onTap: () => viewModel.filterByType(TransactionType.purchase),
                ),
                _filterChip(
                  label: 'Redemption',
                  isSelected: viewModel.selectedType == TransactionType.redemption,
                  onTap: () => viewModel.filterByType(TransactionType.redemption),
                ),
                _filterChip(
                  label: 'Check-in',
                  isSelected: viewModel.selectedType == TransactionType.checkIn,
                  onTap: () => viewModel.filterByType(TransactionType.checkIn),
                ),
                _filterChip(
                  label: 'Reward',
                  isSelected: viewModel.selectedType == TransactionType.reward,
                  onTap: () => viewModel.filterByType(TransactionType.reward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionGroup(
      BuildContext context,
      DateTime date,
      List<TransactionItem> transactions,
      ) {
    final dateFormat = DateFormat('MMMM d, yyyy');
    final isToday = DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isToday ? AppColors.mainColor : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isToday ? 'Today' : dateFormat.format(date),
                  style: TextStyle(
                    color: isToday ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        ...transactions.map((transaction) => _buildTransactionItem(context, transaction)).toList(),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context, TransactionItem transaction) {
    final timeFormat = DateFormat('h:mm a');

    IconData icon;
    Color iconColor;
    String actionText;

    switch (transaction.type) {
      case TransactionType.purchase:
        icon = Icons.shopping_cart;
        iconColor = Colors.blue;
        actionText = 'Purchased';
        break;
      case TransactionType.redemption:
        icon = Icons.redeem;
        iconColor = Colors.purple;
        actionText = 'Redeemed';
        break;
      case TransactionType.checkIn:
        icon = Icons.check_circle;
        iconColor = Colors.green;
        actionText = 'Check-in Reward';
        break;
      case TransactionType.reward:
        icon = Icons.emoji_events;
        iconColor = Colors.amber;
        actionText = 'Earned Reward';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Transaction details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        actionText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        timeFormat.format(transaction.timestamp),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Transaction details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product name or transaction ID
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              transaction.productName ?? 'Token Transaction',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Amount
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: transaction.isPositive
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              transaction.isPositive ? Icons.add : Icons.remove,
                              size: 12,
                              color: transaction.isPositive ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatTransactionAmount(transaction),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: transaction.isPositive ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (transaction.txHash != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.link,
                            size: 12,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Tx: ${_shortenTxHash(transaction.txHash!)}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTransactionAmount(TransactionItem transaction) {
    if (transaction.tokenAmount != null) {
      return '${_formatBigInt(transaction.tokenAmount!)} FIT';
    } else if (transaction.ethAmount != null) {
      return '${_formatEthAmount(transaction.ethAmount!)} ETH';
    } else {
      return '';
    }
  }

  String _shortenTxHash(String txHash) {
    if (txHash.length > 16) {
      return '${txHash.substring(0, 6)}...${txHash.substring(txHash.length - 4)}';
    }
    return txHash;
  }

  String _formatBigInt(BigInt value) {
    final decimal = value % BigInt.from(1000000000000000000);
    final integer = value ~/ BigInt.from(1000000000000000000);

    if (decimal == BigInt.zero) {
      return integer.toString();
    }

    String decimalStr = decimal.toString().padLeft(18, '0');
    decimalStr = decimalStr.substring(0, 4);
    return '$integer.$decimalStr';
  }

  String _formatEthAmount(BigInt amount) {
    final etherValue = amount / BigInt.from(10).pow(18);
    return etherValue.toString();
  }
}